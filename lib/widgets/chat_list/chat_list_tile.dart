
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:ejazapp/pages/chat_pages/util.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
// import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import '../../helpers/colors.dart';
// import '../../providers/theme_provider.dart';
// import '../seen_tick.dart';

// class ChatListTile extends StatefulWidget {
//   const ChatListTile({
//     super.key,
//     required this.index,
//     required this.user,
//   });

//   final int index;
//   final types.User user;

//   @override
//   State<ChatListTile> createState() => _ChatListTileState();
// }

// class _ChatListTileState extends State<ChatListTile> {
//   types.Room? room;
//   String lastMessage = "No messages yet";
//   bool hasSeenMessage = false;

//   @override
//   void initState() {
//     super.initState();
//     _initializeUserAndRoom();
//     _loadLastMessage(widget.user.id);
//   }

//   Future<void> _initializeUserAndRoom() async {
//     final doc = await FirebaseFirestore.instance
//         .collection('users')
//         .doc(widget.user.id)
//         .get();

//     if (!doc.exists || doc.data()?['id'] == null) {
//       await _saveUserToFirestore();
//     }

//     room = await FirebaseChatCore.instance.createRoom(widget.user);

//     if (mounted) {
//       setState(() {});
//     }
//   }

//   Future<void> _saveUserToFirestore() async {
//     final now = DateTime.now();
//     await FirebaseFirestore.instance
//         .collection('users')
//         .doc(widget.user.id)
//         .set({
//       'id': widget.user.id,
//       'firstName': widget.user.firstName ?? 'No name',
//       'lastName': widget.user.lastName ?? 'No last name',
//       'createdAt': widget.user.createdAt ?? Timestamp.fromDate(now),
//       'updatedAt': Timestamp.fromDate(now),
//       'role': widget.user.role?.toString() ?? 'user',
//       'lastSeen': widget.user.lastSeen ?? Timestamp.fromDate(now),
//       'metadata': widget.user.metadata ?? {},
//       'imageUrl': widget.user.imageUrl ??
//           'https://png.pngtree.com/png-vector/20191101/ourmid/pngtree-cartoon-color-simple-male-avatar-png-image_1934459.jpg',
//     }, SetOptions(merge: true));
//   }

// Future<void> _loadLastMessage(String chatId) async {
//   final currentUserId = FirebaseAuth.instance.currentUser?.uid;
//   if (currentUserId == null) return;

//   final chatDoc = await FirebaseFirestore.instance.collection('chats').doc(chatId).get();
//   final data = chatDoc.data();

//   if (data != null && data.containsKey('lastMessage')) {
//     final String lastMsg = data['lastMessage'] ?? "No messages yet";
//     final bool isUnread = data['hasUnread'] ?? false;

//     // Optional: You can use 'lastSeenMessage' logic as well for per-user accuracy
//     final String? lastSeenMessage = data['lastSeenMessage'];

//     if (mounted) {
//       setState(() {
//         lastMessage = lastMsg;
//         hasSeenMessage = lastSeenMessage == lastMsg || !isUnread;
//       });
//     }
//   }
// }



//  Widget _buildAvatar(types.User user) {
//   final color = getUserAvatarNameColor(user);
//   final name = getUserName(user);

//   // Safer URL check
//   final String? imageUrl = user.imageUrl;
//   final bool isValidImageUrl = imageUrl != null &&
//       imageUrl.isNotEmpty &&
//       Uri.tryParse(imageUrl)?.hasAbsolutePath == true &&
//       imageUrl.startsWith('http');

//   return Container(
//     margin: const EdgeInsets.only(right: 16),
//     child: CircleAvatar(
//       backgroundColor: isValidImageUrl ? Colors.transparent : color,
//       backgroundImage: isValidImageUrl
//           ? NetworkImage(imageUrl!)
//           : const AssetImage('assets/avatar.png')
//               as ImageProvider,
//       radius: 20,
//       child: !isValidImageUrl
//           ? Text(
//               name.isNotEmpty ? name[0].toUpperCase() : '',
//               style: const TextStyle(color: Colors.white),
//             )
//           : null,
//     ),
//   );
// }


//   @override
//   Widget build(BuildContext context) {
//     final themeProv = Provider.of<ThemeProvider>(context);
//     final isDark = themeProv.isDarkTheme ?? false;
//     final theme = Theme.of(context);
//     final isArabic = Localizations.localeOf(context).languageCode == 'ar';

//     final f13Font = TextStyle(
//         fontSize: 13,fontWeight: FontWeight.w700, color: isDark ? Colors.white : Color(0xff222743));
//     final f11Font = TextStyle(
//         fontSize: 11,
//         fontWeight: FontWeight.w400,
//         color: isDark ? ColorDark.fontTitle : ColorLight.fontTitle);

//     if (room == null) return const SizedBox();

//     return StreamBuilder<types.Room>(
//       initialData: room,
//       stream: FirebaseChatCore.instance.room(room!.id),
//       builder: (context, roomSnapshot) {
//         if (!roomSnapshot.hasData) return const SizedBox();

//         return StreamBuilder<List<types.Message>>(
//           initialData: const [],
//           stream: FirebaseChatCore.instance.messages(roomSnapshot.data!),
//           builder: (context, messageSnapshot) {
//             return GestureDetector(
//               child: Row(
//                 children: [
//                   _buildAvatar(widget.user),
//                   const SizedBox(width: 16),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(widget.user.firstName ?? "User", style: f13Font),
//                         const SizedBox(height: 4),
//                         Text(
//                           lastMessage,
//                           style: f13Font.copyWith(
//                             fontWeight: FontWeight.w400,
//                             fontSize: 11,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Column(
//                     children: [
//                       Text(
//                         widget.user.lastSeen != null
//                             ? DateFormat('hh:mm a').format(
//                                 DateTime.fromMillisecondsSinceEpoch(
//                                     widget.user.lastSeen! * 1000))
//                             : "--:--",
//                         style: f11Font,
//                       ),
//                       const SizedBox(height: 10),
//                       Row(
//                         children: [
//                           widget.index < 5
//                               ? CircleAvatar(
//                                   radius: 8.5,
//                                   backgroundColor: theme.primaryColor,
//                                   child: Padding(
//                                     padding:  EdgeInsets.only(top:isArabic?0:3.0),
//                                     child: Text(
//                                       hasSeenMessage ? "1" : "0",
//                                       style: f11Font.copyWith(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.w700,
//                                       ),
//                                     ),
//                                   ),
//                                 )
//                               : const SizedBox(width: 17),
//                           const SizedBox(width: 12),
//                           SeenTick(
//                             color: hasSeenMessage
//                                 ? const Color(0xffA8A8A8)
//                                 : const Color(0xff2CB3C9),
//                           ),
//                         ],
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ejazapp/pages/chat_pages/util.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  bool hasSeenMessage = false;

  @override
  void initState() {
    super.initState();
    _initializeUserAndRoom();
  }

  Future<void> _initializeUserAndRoom() async {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.user.id)
        .get();

    if (!doc.exists || doc.data()?['id'] == null) {
      await _saveUserToFirestore();
    }

    room = await FirebaseChatCore.instance.createRoom(widget.user);
    await _loadLastMessage(room!.id);

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _saveUserToFirestore() async {
    final now = DateTime.now();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.user.id)
        .set({
      'id': widget.user.id,
      'firstName': widget.user.firstName ?? 'No name',
      'lastName': widget.user.lastName ?? 'No last name',
      'createdAt': widget.user.createdAt ?? Timestamp.fromDate(now),
      'updatedAt': Timestamp.fromDate(now),
      'role': widget.user.role?.toString() ?? 'user',
      'lastSeen': widget.user.lastSeen ?? Timestamp.fromDate(now),
      'metadata': widget.user.metadata ?? {},
      'imageUrl': widget.user.imageUrl ??
          'https://png.pngtree.com/png-vector/20191101/ourmid/pngtree-cartoon-color-simple-male-avatar-png-image_1934459.jpg',
    }, SetOptions(merge: true));
  }

  Future<void> _loadLastMessage(String chatId) async {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;
    if (currentUserId == null) return;

    final chatDoc = await FirebaseFirestore.instance.collection('chats').doc(chatId).get();
    final data = chatDoc.data();

    if (data != null && data.containsKey('lastMessage')) {
      final String lastMsg = data['lastMessage'] ?? "No messages yet";
      final bool isUnread = data['hasUnread'] ?? false;
      final String? lastSeenMessage = data['lastSeenMessage'];

      if (mounted) {
        setState(() {
          lastMessage = lastMsg;
          hasSeenMessage = lastSeenMessage == lastMsg || !isUnread;
        });
      }
    }
  }

  Widget _buildAvatar(types.User user) {
    final color = getUserAvatarNameColor(user);
    final name = getUserName(user);

    final String? imageUrl = user.imageUrl;
    final bool isValidImageUrl = imageUrl != null &&
        imageUrl.isNotEmpty &&
        Uri.tryParse(imageUrl)?.hasAbsolutePath == true &&
        imageUrl.startsWith('http');

    return Container(
      margin: const EdgeInsets.only(right: 16),
      child: CircleAvatar(
        backgroundColor: isValidImageUrl ? Colors.transparent : color,
        backgroundImage: isValidImageUrl
            ? NetworkImage(imageUrl!)
            : const AssetImage('assets/avatar.png') as ImageProvider,
        radius: 20,
        child: !isValidImageUrl
            ? Text(
                name.isNotEmpty ? name[0].toUpperCase() : '',
                style: const TextStyle(color: Colors.white),
              )
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProv = Provider.of<ThemeProvider>(context);
    final isDark = themeProv.isDarkTheme ?? false;
    final theme = Theme.of(context);
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    final f13Font = TextStyle(
        fontSize: 13,fontWeight: FontWeight.w700, color: isDark ? Colors.white : Color(0xff222743));
    final f11Font = TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w400,
        color: isDark ? ColorDark.fontTitle : ColorLight.fontTitle);

    if (room == null) return const SizedBox();

    return StreamBuilder<types.Room>(
      initialData: room,
      stream: FirebaseChatCore.instance.room(room!.id),
      builder: (context, roomSnapshot) {
        if (!roomSnapshot.hasData) return const SizedBox();

        return StreamBuilder<List<types.Message>>(
          initialData: const [],
          stream: FirebaseChatCore.instance.messages(roomSnapshot.data!),
          builder: (context, messageSnapshot) {
            return GestureDetector(
              child: Row(
                children: [
                  _buildAvatar(widget.user),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.user.firstName ?? "User", style: f13Font),
                        const SizedBox(height: 4),
                        Text(
                          lastMessage,
                          style: f13Font.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    children: [
                      Text(
                        widget.user.lastSeen != null
                            ? DateFormat('hh:mm a').format(
                                DateTime.fromMillisecondsSinceEpoch(
                                    widget.user.lastSeen! * 1000))
                            : "--:--",
                        style: f11Font,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          widget.index < 5
                              ? CircleAvatar(
                                  radius: 8.5,
                                  backgroundColor: theme.primaryColor,
                                  child: Padding(
                                    padding:  EdgeInsets.only(top:isArabic?0:3.0),
                                    child: Text(
                                      hasSeenMessage ? "1" : "0",
                                      style: f11Font.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox(width: 17),
                          const SizedBox(width: 12),
                          SeenTick(
                            color: hasSeenMessage
                                ? const Color(0xffA8A8A8)
                                : const Color(0xff2CB3C9),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
