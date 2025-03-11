import 'package:ejazapp/data/datasource/remote/listapi/getdataserver.dart';
import 'package:flutter/material.dart';

import 'package:ejazapp/helpers/constants.dart';
import 'package:ejazapp/data/models/book.dart';
import 'package:ejazapp/widgets/book_card.dart';
import 'package:provider/provider.dart';

class BiographyTab extends StatelessWidget {
  const BiographyTab({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<BooksApi>(
      builder:  (context, booksApi, child) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 270,
            child: ListView.builder(
              itemCount: booksApi.books2.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.only(left: Const.margin),
              itemBuilder: (context, index) {
                Book? book;
                if (mockBookList[index].categories.length > 0) {
                  if (mockBookList[index].categories.length > 0) {
                    if (mockBookList[index].categories[0]['ct_Name'] ==
                        'Biographies') {
                      book = mockBookList[index];
                      return BookCard(book: book);
                    } else {
                      return Text('');
                    }
                  }
                }
                return null;
              },
            ),
          )
        ],
      );}
    );
  }
}
