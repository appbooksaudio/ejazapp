import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/rectangularButton.dart';

class ImageScreen extends StatefulWidget {
  const ImageScreen({super.key, this.image});

  final String? image;

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  Matrix4 matrix = Matrix4.identity();

  @override
  Widget build(BuildContext context) {
    bool isArabic = Localizations.localeOf(context).languageCode == 'ar';
    return Scaffold(
      body:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 50, 16, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SquareButton(
                action: () {
                  Get.back();
                },
                child: Padding(
                  padding: EdgeInsets.only(left: isArabic ? 0 : 8),
                  child: Icon(Icons.arrow_back_ios),
                ),
              ),
            ],
          ),
        ),
        // SizedBox(
        //   height: 600,
        //   child: PhotoView(
        //      minScale: 1.0,
        //     maxScale: 4.0,
        //     imageProvider:  NetworkImage('https://bukovero.com/wp-content/uploads/2016/07/Harry_Potter_and_the_Cursed_Child_Special_Rehearsal_Edition_Book_Cover.jpg'),
        //   )
        // ),
        SizedBox(
          height: 500,
          width: double.infinity,
          child: InteractiveViewer(
            maxScale: 8.0,
            child: Image.network(
              'https://hbkupress.com/cdn/shop/articles/HBKU_Press_Highlights_the_Benefits_of_Reading_Books_in_a_Series.jpg?v=1683665622',
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        SizedBox(
          height: 50,
        )
      ]),
    );
  }
}
