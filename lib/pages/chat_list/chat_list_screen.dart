import 'package:ejazapp/helpers/colors.dart';
import 'package:ejazapp/pages/chat_list/sample_data.dart';
import 'package:ejazapp/widgets/search_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../controllers/chat/chat_controllers.dart';
import '../../helpers/routes.dart';
import '../../providers/theme_provider.dart';
import '../../widgets/chat_list/chat_category_button.dart';
import '../../widgets/chat_list/chat_list_tile.dart';
import '../../widgets/rectangularButton.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  int chatCategoryCurrentIndex = 1;
  late ChatController chatController;

  @override
  void initState() {
    super.initState();
    chatController = Get.put(ChatController());
    chatController.initHubConnection();
    initHubConnection();
  }
  initHubConnection() async {
    await chatController.hubConnection.start();
    chatController.hubConnection.invoke('SendMessage', args: ['name', 'test']);
    chatController.hubConnection.on('ReceiveMessage', (arguments) {
      print(arguments);
    },);
  }

  @override
  Widget build(BuildContext context) {
    final themeProv = Provider.of<ThemeProvider>(context);
    final theme = Theme.of(context);

    Color dividerColor=(themeProv.isDarkTheme??false)?ColorDark.divider:ColorLight.divider;

    final locale= AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SquareButton(
                        child: Icon(Icons.more_horiz),
                      ),
                      const Spacer(),
                      SquareButton(
                          child: Icon(
                        CupertinoIcons.archivebox_fill,
                      )),
                      const SizedBox(
                        width: 12,
                      ),
                      SquareButton(child: Icon(CupertinoIcons.camera_fill)),
                      const SizedBox(
                        width: 12,
                      ),
                      SquareButton(
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        backGroundColor: theme.primaryColor,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                      locale.ejazChat,
                    style: theme.textTheme.headlineMedium?.copyWith(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: theme.cardColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: SearchWidget(
                                text: '',
                                onChanged: (value) {},
                                hintText: locale.search),
                          ),
                        ],
                      )),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    spacing: 12,
                    children: [
                      ChatCategoryButton(
                        text: locale.allChat,
                        isSelected: chatCategoryCurrentIndex == 1,
                        action: () {
                          setState(() {
                            chatCategoryCurrentIndex = 1;
                          });
                        },
                      ),
                      ChatCategoryButton(
                        text: locale.unreadChat,
                        isSelected: chatCategoryCurrentIndex == 2,
                        action: () {
                          setState(() {
                            chatCategoryCurrentIndex = 2;
                          });
                        },
                      ),
                      ChatCategoryButton(
                        text: locale.groupChat,
                        isSelected: chatCategoryCurrentIndex == 3,
                        action: () {
                          setState(() {
                            chatCategoryCurrentIndex = 3;
                          });
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Expanded(
              child: Container(
                  width: double.infinity,
                  color: theme.cardColor,
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(vertical: 0,),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Get.toNamed<dynamic>(
                            arguments: {
                              "user":chats[index]
                            },
                            Routes.chat,
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical:17,horizontal: 16),
                          child: ChatListTile(
                            index: index,
                            user: chats[index],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => Container(
                      height: 1,
                      color: dividerColor
                    ),
                    itemCount: chats.length,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
