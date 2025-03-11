import 'package:ejazapp/data/datasource/remote/listapi/getdataserver.dart';
import 'package:ejazapp/data/models/book.dart';
import 'package:ejazapp/data/models/collections.dart';
import 'package:ejazapp/helpers/constants.dart';
import 'package:ejazapp/widgets/book_card.dart';
import 'package:ejazapp/widgets/placeholders.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class MyGroupes extends StatelessWidget {
  const MyGroupes({super.key});
  @override
  Widget build(BuildContext context) {
  
     return Consumer<BooksApi>(
      builder:  (context, booksApi, child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        booksApi.collectionActive.isNotEmpty
            ? SizedBox(
                width: double.infinity,
                height: 270,
                child: ListView.builder(
                  itemCount: booksApi.collectionActive.length,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(left: Const.margin),
                  itemBuilder: (context, index) {
                    return GroupBookVerticalCard(
                        collection: booksApi.collectionActive[index]);
                  },
                ),
              )
            : Center(
                child: SizedBox(
                  height: 120,
                  child: Shimmer.fromColors(
                    baseColor: Colors.blue,
                    highlightColor: Colors.white,
                    child: ContentPlaceholder(
                      lineType: ContentLineType.threeLines,
                    ),
                  ),
                ),
              ),
      ],
    );});
  }
}

class Populardiscussions extends StatelessWidget {
  const Populardiscussions({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          height: 270,
          child: ListView.builder(
            itemCount: mockBookList.length,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.only(left: Const.margin),
            itemBuilder: (context, index) {
              final book = mockBookList[index];
              return PopularVerticalCard(book: book);
            },
          ),
        )
      ],
    );
  }
}
