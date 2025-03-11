import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ejazapp/pages/chat_pages/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../helpers/colors.dart';
import '../../providers/theme_provider.dart';
import '../seen_tick.dart';

class ChatListTile extends StatefulWidget {
  const ChatListTile({
    super.key,
    required this.index,
    required this.user,
  });

  final int index;
  final types.User user;

  @override
  State<ChatListTile> createState() => _ChatListTileState();
}

class _ChatListTileState extends State<ChatListTile> {
  types.Room? room;
  String lastMessage = "No messages yet";
  bool lasseen = false;
  Widget _buildAvatar(types.User user) {
    final color = getUserAvatarNameColor(user);
    final hasImage = user.imageUrl != null;
    final name = getUserName(user);

    return Container(
      margin: const EdgeInsets.only(
        right: 16,
      ),
      child: CircleAvatar(
        backgroundColor: hasImage ? Colors.transparent : color,
        backgroundImage: hasImage ? NetworkImage(user.imageUrl!) : null,
        radius: 20,
        child: !hasImage
            ? Text(
                name.isEmpty ? '' : name[0].toUpperCase(),
                style: const TextStyle(color: Colors.white),
              )
            : null,
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    init();
    getLastMessage(widget.user.id);
  }

  init() async {
    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.user.id)
        .get();

    if (!userDoc.exists || userDoc.data() == null) {
      print("Error: User document is missing!");
      SaveUser();
    }

    final userData = userDoc.data()!;

    if (userData['id'] == null) {
      print("Error: User data is incomplete!");
      SaveUser();
    }
    print("widget.user ${widget.user.id}");
    room = await FirebaseChatCore.instance.createRoom(widget.user);
    if (mounted) {
      setState(() {});
    }
    print("room ${room}");
  }
  //save user firestore

  SaveUser() async {
    DateTime now = DateTime.now();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.user.id)
        .set({
      'id': widget.user.id,
      'firstName': widget.user.firstName ?? 'No name',
      'lastName': widget.user.lastName ?? 'No last name',
      'createdAt': widget.user.createdAt ??
          Timestamp.fromDate(now), // Store server timestamp if null
      'updatedAt': Timestamp.fromDate(now), // Always update timestamp
      'role': widget.user.role?.toString() ??
          'user', // Ensure role is stored as a string
      'lastSeen': widget.user.lastSeen ??
          Timestamp.fromDate(now), // Use last seen or server time
      'metadata': widget.user.metadata ?? {}, // Ensure metadata is a map
      'imageUrl': widget.user.imageUrl ?? 'https://png.pngtree.com/png-vector/20191101/ourmid/pngtree-cartoon-color-simple-male-avatar-png-image_1934459.jpg',
    }, SetOptions(merge: true));
  }

  Future<void> getLastMessage(String chatId) async {
    // ✅ Await the Future before assigning it to a variable
    DocumentSnapshot<Map<String, dynamic>> chatDoc =
        await FirebaseFirestore.instance.collection('chats').doc(chatId).get();

    if (chatDoc.exists) {
      // ✅ No need to cast .data(), it already returns Map<String, dynamic>?
      Map<String, dynamic>? chatData = chatDoc.data();

      if (chatData != null && chatData.containsKey('lastMessage')) {
        if (mounted) {
          setState(() {
            lastMessage = chatData['lastMessage'] ?? "No messages yet";
            lasseen = chatData['lastMessage'] != "" ? true : false;
          });
        }

        print("Last message: $lastMessage");
      } else {
        print("No last message found.");
      }
    } else {
      print("Chat does not exist.");
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProv = Provider.of<ThemeProvider>(context);
    final theme = Theme.of(context);

    bool isArabic = Localizations.localeOf(context).languageCode == 'ar';

    final double screeWidth = MediaQuery.of(context).size.width;

    /// colors
    Color textColor =
        (themeProv.isDarkTheme ?? false) ? Colors.white : Color(0xff222743);

    final TextStyle f13Font =
        TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: textColor);
    final TextStyle f11Font = TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w400,
        color: themeProv.isDarkTheme != null && themeProv.isDarkTheme!
            ? ColorDark.fontTitle
            : ColorLight.fontTitle);
    return room != null
        ? StreamBuilder<types.Room>(
            initialData: room,
            stream: FirebaseChatCore.instance.room(room!.id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.data == null) {
                return Center(child: CircularProgressIndicator());
              }
              return StreamBuilder<List<types.Message>>(
                  initialData: const [],
                  stream: snapshot.data != null
                      ? FirebaseChatCore.instance.messages(snapshot.data!)
                      : Stream.empty(),
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return Center(child: CircularProgressIndicator());
                    }

                    return GestureDetector(
                      child: Row(
                        children: [
                          _buildAvatar(widget.user),
                          const SizedBox(
                            width: 24,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    widget.user.firstName != null
                                        ? widget.user.firstName!
                                        : "user",
                                    style: f13Font),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  lastMessage,
                                  style: f13Font.copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Column(
                            children: [
                              Text(
                                widget.user.lastSeen != null
                                    ? DateFormat('hh:mm a')
                                        .format(
                                            DateTime.fromMillisecondsSinceEpoch(
                                                widget.user.lastSeen! * 1000))
                                        .toString()
                                    : "10:45 AM",
                                style: f11Font,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  /// todo should update with real logic (new message)
                                  widget.index < 5
                                      ? CircleAvatar(
                                          radius: 8.5,
                                          backgroundColor: theme.primaryColor,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                top: isArabic ? 0 : 3),
                                            child: Text(
                                              lasseen ? "1" : "0",
                                              style: f11Font.copyWith(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                        )
                                      : const SizedBox(
                                          width: 17,
                                        ),
                                  const SizedBox(
                                    width: 12,
                                  ),

                                  /// todo should update with real logic (message seen)
                                  SeenTick(
                                    color: lasseen
                                        ? Color(0xffA8A8A8)
                                        : Color(0xff2CB3C9),
                                  )
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  });
            })
        : Container();
  }
}
