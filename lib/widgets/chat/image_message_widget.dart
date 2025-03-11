import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageMessageWidget extends StatelessWidget {
  const ImageMessageWidget({
    super.key,
    required this.isReceived,
  });

  final bool isReceived;

  @override
  Widget build(BuildContext context) {
    final Color grey = Color(0xffA8A8A8);

    final TextStyle f13Font =
        TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: grey);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 113,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: CachedNetworkImageProvider(
                      'https://hbkupress.com/cdn/shop/articles/HBKU_Press_Highlights_the_Benefits_of_Reading_Books_in_a_Series.jpg?v=1683665622'))),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "check this out",
              style: f13Font.copyWith(
                  color: isReceived ? Color(0xff131313) : Colors.white,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ],
    );
  }
}