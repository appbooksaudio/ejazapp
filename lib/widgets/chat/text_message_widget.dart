
import 'package:flutter/material.dart';

class TextMessageWidget extends StatelessWidget {
  const TextMessageWidget({
    super.key,
    required this.text, required this.isReceived,
  });

  final String text;
  final bool isReceived;
  @override
  Widget build(BuildContext context) {
    final Color grey = Color(0xffA8A8A8);

    final TextStyle f13Font =
    TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: grey);

    return Text(
      text,
      style: f13Font.copyWith(color:isReceived?Color(0xff131313):Colors.white, fontWeight: FontWeight.w400),
    );
  }
}