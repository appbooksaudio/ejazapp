import 'package:ejazapp/data/datasource/remote/listapi/getdataserver.dart';
import 'package:ejazapp/data/models/authors.dart';
import 'package:ejazapp/helpers/constants.dart';
import 'package:ejazapp/widgets/book_card.dart';
import 'package:ejazapp/widgets/placeholders.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class AuthorsExplore extends StatefulWidget {
  const AuthorsExplore({super.key});

  @override
  State<AuthorsExplore> createState() => _AuthorsExploreState();
}

class _AuthorsExploreState extends State<AuthorsExplore> {
  @override
  Widget build(BuildContext context) {
    return Consumer<BooksApi>(
      builder: (context, booksApi, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            SizedBox(
                width: double.infinity,
                height: 150,
                child: booksApi.listauthors.isNotEmpty
                    ? ListView.builder(
                        itemCount: 10,
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(left: Const.margin),
                        itemBuilder: (context, index) {
                          final authors = booksApi.listauthors[index];
                          return AuthorsCard(authors: authors);
                        },
                      )
                    : Center(child: CircularProgressIndicator()))
          ],
        );
      },
    );
  }
}
