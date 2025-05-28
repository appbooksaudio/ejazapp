import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../helpers/colors.dart';
import '../../providers/theme_provider.dart';
import '../seen_tick.dart';

class ChatListTile extends StatelessWidget {
  const ChatListTile({
    super.key,
    required this.index,
    required this.user,
  });

  final int index;
  final Map<String, dynamic> user;

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
    return GestureDetector(

      child: Row(
        children: [
          Container(
              height: 44,
              width: 44,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xffD9D9D9),
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(user['profileUrl']),
                      fit: BoxFit.fill)),
              child: user['profileUrl'] == null
                  ? Icon(
                      Icons.person_outline_rounded,
                      color: Colors.white,
                    )
                  : null),
          const SizedBox(
            width: 24,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(user['name'], style: f13Font),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  user['lastMessage'],
                  style: f13Font.copyWith(fontWeight: FontWeight.w400),
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
                user['lastMessageTime'],
                style: f11Font,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  /// todo should update with real logic (new message)
                  index < 5
                      ? CircleAvatar(
                          radius: 8.5,
                          backgroundColor: theme.primaryColor,
                          child: Padding(
                            padding: EdgeInsets.only(top:0),
                            child: Text(
                              user['unreadMessages'].toString(),
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
                    color:
                        user['seen'] ? Color(0xff2CB3C9) : Color(0xffA8A8A8),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
