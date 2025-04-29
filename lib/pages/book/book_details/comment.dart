import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comment_box/comment/comment.dart';
import 'package:comment_tree/data/comment.dart';
import 'package:comment_tree/widgets/comment_tree_widget.dart';
import 'package:comment_tree/widgets/tree_theme_data.dart';
import 'package:ejazapp/core/services/services.dart';
import 'package:ejazapp/data/models/book.dart';
import 'package:ejazapp/helpers/colors.dart';
import 'package:ejazapp/helpers/constants.dart';
import 'package:ejazapp/helpers/routes.dart';
import 'package:ejazapp/providers/locale_provider.dart';
import 'package:ejazapp/providers/theme_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:octo_image/octo_image.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentPage extends StatefulWidget {
  const CommentPage({super.key});

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  Book? book;
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
  String RepComment = '';
  String DocId = "";
  FocusNode inputNode = FocusNode();

  /// Use [FirebaseAuth.authStateChanges] to listen to the state changes.
  User? firebaseUser;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _error = false;

  @override
  void initState() {
    // TODO: implement initState
    book = Get.arguments as Book;
    initializeFlutterFire();
    super.initState();
    FirebaseFirestore.instance.disableNetwork();
    FirebaseFirestore.instance.enableNetwork();
    timeago.setLocaleMessages('ar', timeago.ArMessages());
    timeago.setLocaleMessages('en', timeago.EnMessages());
  }

  void initializeFlutterFire() async {
    try {
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        setState(() {
          firebaseUser = user;
        });
      });
    } catch (e) {
      setState(() {
        _error = true;
      });
    }
  }

  Widget commentChild() {
    final theme = Theme.of(context);
    final localprovider = Provider.of<LocaleProvider>(context, listen: true);
    return Stack(
      children: [
        ListView(
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: OctoImage(
                  image: CachedNetworkImageProvider(
                    book!.imagePath,
                  ),
                  fit: BoxFit.contain,
                  height: 120,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                    textAlign: TextAlign.center,
                    localprovider.localelang!.languageCode == 'en'
                        ? book!.bk_Name as String
                        : book!.bk_Name_Ar as String,
                    style: theme.textTheme.headlineLarge!
                        .copyWith(fontSize: 18, height: 1.2),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
                height: MediaQuery.of(context).size.height * 0.8,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('comment/${book!.bk_ID}/ForumComment')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Text(
                          localprovider.localelang!.languageCode == 'en'
                              ? 'There is no comment'
                              : 'لا يوجد تعليق',
                          style: TextStyle(color: Colors.white),
                        );
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                            child: Text(
                          'Loading',
                          style: TextStyle(color: Colors.white),
                        ));
                      }
                      return ListView(
                        children: [
                          Column(children: getListComment(snapshot)),
                          const SizedBox(
                            height: 300,
                          )
                        ],
                      );
                    })),
          ],
        )
      ],
    );
  }

  List<Widget> getListComment(AsyncSnapshot<QuerySnapshot> snapshot) {
    DateTime now = DateTime.now();
    return snapshot.data!.docs.map((doc) {
      List replies = doc['reply'] ?? [];

      return Card(
        elevation: 0,
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: CommentTreeWidget<Comment, Comment>(
            Comment(
              id: doc.id,
              avatar: doc['image'] ?? '',
              userName: doc['name'] ?? '',
              content: doc['text'] ?? '',
              reply: replies,
              time: (doc['timestamp'] as Timestamp?)?.toDate() ?? now,
            ),
            replies.map<Comment>((r) {
              return Comment(
                id: doc.id,
                avatar: r['image'] ?? '',
                userName: r['name'] ?? '',
                content: r['text'] ?? '',
                reply: replies,
                time: (r['timestamp'] as Timestamp?)?.toDate() ?? now,
              );
            }).toList(),
            treeThemeData: const TreeThemeData(
              lineColor: Colors.transparent,
              lineWidth: 2,
            ),
            avatarRoot: (context, data) => _buildAvatar(data.avatar!, 20),
            avatarChild: (context, data) => _buildAvatar(data.avatar!, 16),
            contentRoot: (context, data) =>
                _buildCommentContent(context, data, isRoot: true),
            contentChild: (context, data) =>
                _buildCommentContent(context, data, isRoot: false),
          ),
        ),
      );
    }).toList();
  }

  PreferredSize _buildAvatar(String url, double radius) {
    return PreferredSize(
      preferredSize: Size.fromRadius(radius),
      child: CircleAvatar(
        radius: radius,
        backgroundColor: Colors.white,
        backgroundImage: CachedNetworkImageProvider(url),
      ),
    );
  }

  Widget _buildCommentContent(BuildContext context, Comment data,
      {bool isRoot = false}) {
    final themeProv = Provider.of<ThemeProvider>(context);
    final isDark = themeProv.isDarkTheme!;
    final textColor = isDark ? Colors.white : Colors.black87;
    final locale = Localizations.localeOf(context).languageCode;
    return Container(
      decoration: BoxDecoration(
        color: isDark ? Colors.grey.shade800 : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                (data.userName != null && data.userName!.isNotEmpty)
                    ? data.userName!.split(' ')[0]
                    : (locale == 'ar' ? 'مستخدم' : 'User'),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: isRoot ? 13 : 12,
                  color: textColor,
                ),
              ),
              Text(
                timeago.format(data.time, locale: locale), // or 'en' for full
                style: TextStyle(color: ColorLight.primary, fontSize: 10),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            data.content!,
            style: TextStyle(color: textColor, fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              TextButton.icon(
                onPressed: () {
                  setState(() {
                    RepComment = "replay";
                    DocId = data.id as String;
                  });
                  FocusScope.of(context).requestFocus(inputNode);
                },
                icon: Icon(Icons.reply, size: 18, color: ColorLight.primary),
                label:  Text(
                  locale == 'en'?"Reply":"رد",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: ColorLight.primary),
                ),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  minimumSize: Size(0, 0),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeProv = Provider.of<ThemeProvider>(context);
    final localprovider = Provider.of<LocaleProvider>(context, listen: true);
    return Scaffold(
        body: CustomScrollView(
            physics: const NeverScrollableScrollPhysics(),
            slivers: [
          // A flexible app bar
          SliverAppBar(
            backgroundColor: theme.colorScheme.surface,
            foregroundColor: themeProv.isDarkTheme! ? Colors.blue : Colors.blue,
            actions: [
              // SizedBox(
              //     width: 50,
              //     height: 50,
              //     child: FittedBox(
              //       child: FloatingActionButton(
              //         onPressed: () {
              //           Get.toNamed(Routes.comment);
              //         },
              //         backgroundColor: Colors.blue,
              //         elevation: 0,
              //         child: const Icon(
              //           Icons.chat,
              //           color: Colors.white,
              //           size: 25,
              //         ),
              //       ),
              //     )),
            ],
          ),
          SliverFillRemaining(
            child: Container(
              child: CommentBox(
                userImage: CommentBox.commentImageParser(
                    imageURLorPath: firebaseUser != null
                        ? (firebaseUser!.photoURL ?? Const.avatar1)
                        : Const.avatar1),
                child: commentChild(),
                labelText: localprovider.localelang!.languageCode == 'en'
                    ? 'Write a comment...'
                    : 'أكتب تعليقا...',
                errorText: localprovider.localelang!.languageCode == 'en'
                    ? 'Comment cannot be blank'
                    : 'لا يمكن أن يكون التعليق فارغاً',
                focusNode: inputNode,
                withBorder: false,
                sendButtonMethod: () {
                  if (formKey.currentState!.validate()) {
                    print(commentController.text);
                    String? comID = book!.bk_ID;
                    if (RepComment == '') {
                      communityPageComment(commentController.text, comID!);
                    } else {
                      replyToComment(commentController.text, comID!, DocId);
                    }
                    setState(() {});
                    commentController.clear();
                    FocusScope.of(context).unfocus();
                  } else {
                    print('Not validated');
                  }
                },
                formKey: formKey,
                commentController: commentController,
                backgroundColor: Colors.transparent,
                textColor: themeProv.isDarkTheme!
                    ? Colors.white
                    : ColorDark.background,
                sendWidget: Icon(Icons.send_sharp,
                    size: 30,
                    color: themeProv.isDarkTheme!
                        ? Colors.white
                        : ColorDark.background),
              ),
            ),
          )
        ]));
  }

//********************* posting or commenting wih firebase ***********/

  communityPageComment(String comment, String comId) async {
    String displayname = mybox!.get('name');
    if (_auth.currentUser != null) {
      if (_auth.currentUser!.displayName == null) {
        await _auth.currentUser!.updateDisplayName(displayname);
      }
      if (_auth.currentUser!.photoURL == null) {
        await _auth.currentUser!.updatePhotoURL(
            "https://firebasestorage.googleapis.com/v0/b/ejaz-ca748.appspot.com/o/apple%2Favatar.jpeg?alt=media&token=0cd72d6c-bfc9-4208-83c2-78a69d44f7b8");
      }
    }
    FirebaseFirestore.instance
        .collection('comment')
        .doc(comId)
        .collection('ForumComment')
        .doc()
        .set({
      'name':
          _auth.currentUser != null ? _auth.currentUser!.displayName : "Apple",
      'image': firebaseUser != null
          ? (firebaseUser!.photoURL != null
              ? firebaseUser!.photoURL
              : "https://firebasestorage.googleapis.com/v0/b/ejaz-ca748.appspot.com/o/apple%2Favatar.jpeg?alt=media&token=0cd72d6c-bfc9-4208-83c2-78a69d44f7b8")
          : "https://firebasestorage.googleapis.com/v0/b/ejaz-ca748.appspot.com/o/apple%2Favatar.jpeg?alt=media&token=0cd72d6c-bfc9-4208-83c2-78a69d44f7b8",
      'timestamp': FieldValue.serverTimestamp(),
      'text': comment,
      'reply':
          [] // here will be where all the replies of this post will be in Map...
    });
  }

//********************* replyToComment wih firebase ***********/
  replyToComment(String comment, String comId, String DocId) async {
    String displayname = mybox!.get('name');
    if (_auth.currentUser != null) {
      if (_auth.currentUser!.displayName == null) {
        await _auth.currentUser!.updateDisplayName(displayname);
      }
      if (_auth.currentUser!.photoURL == null) {
        await _auth.currentUser!.updatePhotoURL(
            "https://cdn-icons-png.flaticon.com/512/6386/6386976.png");
      }
    }
    Map data = {
      'name':
          _auth.currentUser != null ? _auth.currentUser!.displayName : "Apple",
      'image': firebaseUser != null
          ? (firebaseUser!.photoURL != null
              ? firebaseUser!.photoURL
              : "https://firebasestorage.googleapis.com/v0/b/ejaz-ca748.appspot.com/o/apple%2Favatar.jpeg?alt=media&token=0cd72d6c-bfc9-4208-83c2-78a69d44f7b8")
          : "https://firebasestorage.googleapis.com/v0/b/ejaz-ca748.appspot.com/o/apple%2Favatar.jpeg?alt=media&token=0cd72d6c-bfc9-4208-83c2-78a69d44f7b8",
      'timestamp': Timestamp.fromDate(DateTime.now()),
      'text': comment,
      'reply': []
    };

    FirebaseFirestore.instance
        .collection('comment')
        .doc(comId)
        .collection('ForumComment')
        .doc(DocId)
        .update({
      'reply': FieldValue.arrayUnion([data])
    });
    setState(() {
      RepComment = "";
    });
  }

  ////*************** *********************/
}
