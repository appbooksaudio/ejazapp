import 'package:chat_app/helpers/colors.dart';
import 'package:chat_app/chat_list/sample_data.dart';
import 'package:chat_app/widgets/search_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../helpers/routes.dart';
import '../../providers/theme_provider.dart';
import '../../widgets/chat_list/chat_list_tile.dart';
import '../../widgets/rectangularButton.dart';
import 'package:chat_app/l10n/app_localizations.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  int chatCategoryCurrentIndex = 1;

  @override
  Widget build(BuildContext context) {
    final themeProv = Provider.of<ThemeProvider?>(context, listen: true);

    final theme = Theme.of(context);

    final dividerColor = (themeProv?.isDarkTheme ?? false)
        ? ColorDark.divider
        : ColorLight.divider;

    final locale = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SquareButton(
                        child: const Icon(Icons.more_horiz),
                        action: () {
                          showMenu(
                            color: theme.cardColor,
                            context: context,
                            position: const RelativeRect.fromLTRB(
                              76,
                              16,
                              76,
                              0,
                            ),
                            items: List.generate(
                              5,
                              (index) => PopupMenuItem(
                                child: Text(
                                  'Text $index',
                                  style: theme.textTheme.titleMedium,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      const Spacer(),
                      SquareButton(
                        child: const Icon(CupertinoIcons.archivebox_fill),
                      ),
                      const SizedBox(width: 12),
                      SquareButton(
                        child: const Icon(CupertinoIcons.camera_fill),
                      ),
                      const SizedBox(width: 12),
                      SquareButton(
                        child: const Icon(Icons.add, color: Colors.white),
                        backGroundColor: theme.primaryColor,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    locale.ejazChat,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: theme.cardColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 16),
                        Expanded(
                          child: SearchWidget(
                            text: '',
                            onChanged: (value) {},
                            hintText: locale.search,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Chat Category Buttons if any (currently empty row)
                  Row(
                    children: [
                      // Placeholder for future category filters
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Container(
                width: double.infinity,
                color: theme.cardColor,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/chat',
                          arguments: {'user': chats[index]},
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 17,
                          horizontal: 16,
                        ),
                        child: ChatListTile(index: index, user: chats[index]),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      Container(height: 1, color: dividerColor),
                  itemCount: chats.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
