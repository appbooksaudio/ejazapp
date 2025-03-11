import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../../helpers/colors.dart';
import '../../providers/theme_provider.dart';
import '../seen_tick.dart';

class messageContainer extends StatefulWidget {
  const messageContainer({
    super.key,
    required this.isReceived,
    this.child,
    this.messageType,
    this.isGroup,
  });

  final bool isReceived;
  final bool? isGroup;
  final Widget? child;
  final MessageType? messageType;

  @override
  State<messageContainer> createState() => _messageContainerState();
}

class _messageContainerState extends State<messageContainer> {
  double? width;
  Color receivedColor = Color(0xffE4E4E4);
  Color sendColor = Color(0xff0F99D6);

  @override
  void initState() {
    super.initState();
    if (widget.messageType != MessageType.text) {
      width = 178;
    }
    _updateColorWithMessageType();
  }

  _updateColorWithMessageType() {
    if (widget.messageType == MessageType.audio ||
        widget.messageType == MessageType.file) {
      sendColor = sendColor.withAlpha(20);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final themeProv = Provider.of<ThemeProvider>(context);
    final theme = Theme.of(context);
    final Color grey = Color(0xffA8A8A8);
    final TextStyle f13Font =
        TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: grey);

    final TextStyle f11Font = TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w400,
        color: themeProv.isDarkTheme != null && themeProv.isDarkTheme!
            ? ColorDark.fontTitle
            : ColorLight.fontTitle);
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        mainAxisAlignment:
            widget.isReceived ? MainAxisAlignment.start : MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.isReceived && (widget.isGroup ?? false))
            Container(
              margin: EdgeInsets.only(right: 8),
              height: 38,
              width: 38,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: theme.primaryColor,
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: CachedNetworkImageProvider(
                          'https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg'))),
            ),
          Column(
            crossAxisAlignment: widget.isReceived
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: widget.isReceived
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.end,
                children: [
                  Text(
                    '10.24 PM',
                    style: f11Font.copyWith(
                        color: grey, fontWeight: FontWeight.w400),
                  ),
                  /// todo should update with real logic (message seen)
                  if (!widget.isReceived)
                    SeenTick(
                        color: true ? theme.primaryColor : Color(0xffA8A8A8))
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                  // width: width,
                  padding: EdgeInsets.all(12),
                  constraints: BoxConstraints(maxWidth: 250),
                  decoration: BoxDecoration(
                    color: widget.isReceived ? receivedColor : sendColor,
                    borderRadius: BorderRadius.only(
                      topLeft: !widget.isReceived
                          ? Radius.circular(12)
                          : Radius.circular(0),
                      topRight: widget.isReceived
                          ? Radius.circular(12)
                          : Radius.circular(0),
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                  child: Directionality(
                      textDirection:
                          isArabic ? TextDirection.rtl : TextDirection.ltr,
                      child: widget.child ?? SizedBox()))
            ],
          ),
        ],
      ),
    );
  }
}