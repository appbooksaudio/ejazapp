import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

import '../../providers/theme_provider.dart';
import '../rectangularButton.dart';

class MessageSendingSection extends StatelessWidget {
  const MessageSendingSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final themeProv = Provider.of<ThemeProvider>(context);
    final theme = Theme.of(context);

    
    final Color grey = Color(0xffA8A8A8);
    final Color buttonBackGround = (themeProv.isDarkTheme ?? false)
        ? Color(0xFF1F2937)
        : Color(0xffF6F5F5);

    final TextStyle f13Font =
        TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: grey);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      height: 88,
      width: double.infinity,
      decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(12),
          ),
          boxShadow: [
            BoxShadow(
                color: (themeProv.isDarkTheme??false?Colors.white:Colors.black).withAlpha(10),
                blurRadius: 32,
                spreadRadius: 0,
                offset: Offset(0, -8))
          ]),
      child: Row(
        children: [
          RectangularButton(
            child: Icon(
              Feather.paperclip,
              size: 20,
            ),
            backGroundColor: buttonBackGround,
          ),
          const SizedBox(
            width: 8,
          ),
          Container(
            height: 44,
            width: 225,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Color(0xffE3E3E3))),
            child: TextFormField(
              style: f13Font.copyWith(color: theme.cardColor),
              decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                  suffixIcon: GestureDetector(
                    onTap: () {},
                    child: Icon(
                      CupertinoIcons.paperplane_fill,
                      size: 20,color: Color(0xff0F99D6),
                    ),
                  ),
                  hintText: 'Type Chat Here...',
                  hintStyle: f13Font,
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
              child: GestureDetector(
                  onTap: () {
                    // Get.toNamed<dynamic>(Routes.TakePictureScreen,);
                  },
                  child: Icon(CupertinoIcons.camera_fill))),
          Expanded(
              child: GestureDetector(
                  onTap: () {}, child: Icon(CupertinoIcons.mic_fill)))
        ],
      ),
    );
  }
}
