import 'package:ejazapp/helpers/colors.dart';
import 'package:ejazapp/helpers/constants.dart';
import 'package:ejazapp/pages/chat_list/sample_data.dart';
import 'package:ejazapp/widgets/search_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';
import '../../widgets/chat_list/chat_category_button.dart';
import '../../widgets/chat_list/chat_list_tile.dart';
import '../../widgets/rectangularButton.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  int chatCategoryCurrentIndex = 1;

  @override
  Widget build(BuildContext context) {
    final themeProv = Provider.of<ThemeProvider>(context);
    final theme = Theme.of(context);

    Color dividerColor=(themeProv.isDarkTheme??false)?ColorDark.divider:ColorLight.divider;

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
                      RectangularButton(
                        child: Icon(Icons.more_horiz),
                      ),
                      const Spacer(),
                      RectangularButton(
                          child: Icon(
                        CupertinoIcons.archivebox_fill,
                      )),
                      const SizedBox(
                        width: 12,
                      ),
                      RectangularButton(child: Icon(CupertinoIcons.camera_fill)),
                      const SizedBox(
                        width: 12,
                      ),
                      RectangularButton(
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
                    'Ejaz Chat',
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
                                hintText: 'Search Chat'),
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
                        text: 'All Chat',
                        isSelected: chatCategoryCurrentIndex == 1,
                        action: () {
                          setState(() {
                            chatCategoryCurrentIndex = 1;
                          });
                        },
                      ),
                      ChatCategoryButton(
                        text: 'Unread Chat',
                        isSelected: chatCategoryCurrentIndex == 2,
                        action: () {
                          setState(() {
                            chatCategoryCurrentIndex = 2;
                          });
                        },
                      ),
                      ChatCategoryButton(
                        text: 'Group Chat',
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
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical:17,horizontal: 16),
                        child: ChatListTile(
                          index: index,
                          user: chats[index],
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
