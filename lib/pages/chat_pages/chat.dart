import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart' show Chat;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:mime/mime.dart'; // for mimeType in file upload

class ChatPage extends StatefulWidget {
  const ChatPage({
    super.key,
    required this.room,
    required this.user,
  });

  final types.Room room;
  final User? user;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  bool _isAttachmentUploading = false;

  @override
  void initState() {
    super.initState();
    markChatAsSeen();
  }

  void _handleAttachmentPressed() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) => SafeArea(
        child: SizedBox(
          height: 144,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleImageSelection();
                },
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Photo'),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleFileSelection();
                },
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('File'),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Cancel'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleFileSelection() async {
    // FilePicker was commented out earlier, add it if needed.
  }

  void _handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    if (result != null) {
      _setAttachmentUploading(true);
      final file = File(result.path);
      final size = file.lengthSync();
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);
      final name = result.name;

      try {
        final reference = FirebaseStorage.instance.ref(name);
        await reference.putFile(file);
        final uri = await reference.getDownloadURL();

        final message = types.PartialImage(
          height: image.height.toDouble(),
          name: name,
          size: size,
          uri: uri,
          width: image.width.toDouble(),
        );

        FirebaseChatCore.instance.sendMessage(message, widget.room.id);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Image upload failed: $e')),
        );
      } finally {
        _setAttachmentUploading(false);
      }
    }
  }

  void _handleMessageTap(BuildContext _, types.Message message) async {
    if (message is types.FileMessage) {
      var localPath = message.uri;

      if (message.uri.startsWith('http')) {
        try {
          final updatedMessage = message.copyWith(isLoading: true);
          FirebaseChatCore.instance.updateMessage(
            updatedMessage,
            widget.room.id,
          );

          final client = http.Client();
          final request = await client.get(Uri.parse(message.uri));
          final bytes = request.bodyBytes;
          final documentsDir = (await getApplicationDocumentsDirectory()).path;
          localPath = '$documentsDir/${message.name}';

          if (!File(localPath).existsSync()) {
            final file = File(localPath);
            await file.writeAsBytes(bytes);
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to open file: $e')),
          );
        } finally {
          final updatedMessage = message.copyWith(isLoading: false);
          FirebaseChatCore.instance.updateMessage(
            updatedMessage,
            widget.room.id,
          );
        }
      }

      await OpenFilex.open(localPath);
    }
  }

  void _handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    final updatedMessage = message.copyWith(previewData: previewData);
    FirebaseChatCore.instance.updateMessage(updatedMessage, widget.room.id);
  }

  void _handleSendPressed(types.PartialText message) async {
    final senderId = FirebaseAuth.instance.currentUser?.uid;
    final receiverId = widget.user?.uid;
    if (senderId == null || receiverId == null) return;

    final customMessage = types.PartialText(
      text: message.text,
      metadata: {
        'isSeen': false,
        'senderId': senderId,
        'receiverId': receiverId,
      },
    );

    FirebaseChatCore.instance.sendMessage(customMessage, widget.room.id);

    await FirebaseFirestore.instance
        .collection('chats')
        .doc(widget.room.id)
        .set({
      'lastMessage': message.text,
      'lastMessageTime': FieldValue.serverTimestamp(),
      'hasUnread': true,
      'unreadBy': {
        receiverId: true,
      },
    }, SetOptions(merge: true));
  }

  void markChatAsSeen() async {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;
    if (currentUserId == null) return;

    final chatDoc = await FirebaseFirestore.instance
        .collection('chats')
        .doc(widget.room.id)
        .get();

    if (chatDoc.exists) {
      final lastMessage = chatDoc.data()?['lastMessage'];
      await FirebaseFirestore.instance
          .collection('chats')
          .doc(widget.room.id)
          .set({
        'lastSeenMessage': lastMessage,
        'lastSeenTime': FieldValue.serverTimestamp(),
        'hasUnread': false,
        'unreadBy': {
          currentUserId: false,
        },
      }, SetOptions(merge: true));
    }

    final unreadMessages = await FirebaseFirestore.instance
        .collection('chats')
        .doc(widget.room.id)
        .collection('messages')
        .where('metadata.isSeen', isEqualTo: false)
        .where('metadata.receiverId', isEqualTo: currentUserId)
        .get();

    final batch = FirebaseFirestore.instance.batch();

    for (final doc in unreadMessages.docs) {
      final metadata = Map<String, dynamic>.from(doc.data()['metadata'] ?? {});
      metadata['isSeen'] = true;
      metadata['seenAt'] = FieldValue.serverTimestamp();
      batch.update(doc.reference, {'metadata': metadata});
    }

    await batch.commit();
  }

  void _setAttachmentUploading(bool uploading) {
    setState(() {
      _isAttachmentUploading = uploading;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Chat",
              style: TextStyle(fontSize: 20, color: Colors.blue)),
          centerTitle: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.blue,
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: StreamBuilder<types.Room>(
          initialData: widget.room,
          stream: FirebaseChatCore.instance.room(widget.room.id),
          builder: (context, snapshot) => StreamBuilder<List<types.Message>>(
            initialData: const [],
            stream: snapshot.hasData == true
                ? FirebaseChatCore.instance.messages(snapshot.data!)
                : const Stream.empty(),
            builder: (context, messagesSnapshot) => Chat(
              messages: messagesSnapshot.data ?? [],
              user: types.User(id: FirebaseAuth.instance.currentUser!.uid),
              onSendPressed: _handleSendPressed,
              onAttachmentPressed: _handleAttachmentPressed,
              onMessageTap: _handleMessageTap,
              onPreviewDataFetched: _handlePreviewDataFetched,
              isAttachmentUploading: _isAttachmentUploading,
            ),
          ),
        ),
      );
}
