
import 'package:ejazapp/widgets/rectangularButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../helpers/colors.dart';
import '../../providers/theme_provider.dart';
import '../../widgets/chat/audio_message_widget.dart';
import '../../widgets/chat/document_message_widget.dart';
import '../../widgets/chat/image_message_widget.dart';
import '../../widgets/chat/message_container.dart';
import '../../widgets/chat/message_sending_section.dart';
import '../../widgets/chat/profile_details_section.dart';
import '../../widgets/chat/text_message_widget.dart';
import 'dart:math' as math;
class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, this.user});

  final Map<String, dynamic>? user;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProv = Provider.of<ThemeProvider>(context);
    final theme = Theme.of(context);

    bool isArabic = Localizations.localeOf(context).languageCode == 'ar';

    /// colors
    Color textColor =
        (themeProv.isDarkTheme ?? false) ? Colors.white : Color(0xff222743);
    final Color grey = Color(0xffA8A8A8);

    final TextStyle f13Font =
        TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: grey);

    final TextStyle f11Font = TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w400,
        color: themeProv.isDarkTheme != null && themeProv.isDarkTheme!
            ? ColorDark.fontTitle
            : ColorLight.fontTitle);
    final amplitudes = [
      0.09,
      0.12,
      0.15,
      0.35,
      0.02,
      0.03,
      0.37,
      0.04,
      0.10,
      0.55,
      0.06,
      0.05,
      0.03,
      0.10,
      0.30,
      0.15,
      0.48,
      0.02,
      0.01,
      0.08,
      0.90,
      0.50,
      0.02,
      0.12,
      0.20,
      0.40,
    ];
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: 55,
                        width: 55,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            RectangularButton(
                              action: () {
                                Get.back();
                              },
                              child: Padding(
                                padding:
                                    EdgeInsets.only(left: isArabic ? 0 : 8),
                                child: Icon(Icons.arrow_back_ios),
                              ),
                            ),
                            Positioned(
                              right: 0,
                              bottom: 36,
                              left: 36,
                              child: CircleAvatar(
                                radius: 8.5,
                                backgroundColor: theme.primaryColor,
                                child: Padding(
                                    child: Text(
                                      '4',
                                      style: f11Font.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    padding:
                                        EdgeInsets.only(top: isArabic ? 0 : 3)),
                              ),
                            )
                          ],
                        ),
                      ),
                      const Spacer(),
                      RectangularButton(
                        child: Icon(Icons.more_horiz),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  ProfileDetailsSection(
                    user: widget.user ?? {},
                  )
                ],
              ),
            ),
            Expanded(
                child: ColoredBox(
              color: theme.cardColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: ListView(
                  children: [
                    SizedBox(
                      height: 32,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Today',
                          style: f13Font.copyWith(
                              color: textColor, fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    messageContainer(
                        isReceived: true,
                        messageType: MessageType.text,
                        child: TextMessageWidget(
                            isReceived: true,
                            text:
                                "Hey, I hope you're doing well. I wanted to talk to you about the project analysis we've been working on.")),
                    SizedBox(
                      height: 10,
                    ),
                    messageContainer(
                        isReceived: false,
                        messageType: MessageType.text,
                        child: TextMessageWidget(
                            isReceived: false,
                            text:
                                "Hey, I hope you're doing well. I wanted to talk to you about the project analysis we've been working on.")),
                    SizedBox(
                      height: 10,
                    ),
                    messageContainer(
                      isReceived: false,
                      messageType: MessageType.image,
                      child: ImageMessageWidget(
                        isReceived: false,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    messageContainer(
                      messageType: MessageType.image,
                      isReceived: true,
                      child: TextMessageWidget(
                        isReceived: true,
                        text: "Fantastic",
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    messageContainer(
                        messageType: MessageType.file,
                        isReceived: false,
                        child: documentMessageWidget()),
                    const SizedBox(
                      height: 10,
                    ),
                    messageContainer(
                        messageType: MessageType.file,
                        isReceived: false,
                        child: AudioMessageWidget()),
                    const SizedBox(
                      height: 85,
                    )
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
      bottomSheet: MessageSendingSection(),
    );
  }
}
