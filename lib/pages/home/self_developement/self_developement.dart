import 'package:ejazapp/data/datasource/remote/listapi/getdataserver.dart';
import 'package:ejazapp/data/models/book.dart';
import 'package:ejazapp/helpers/constants.dart';
import 'package:ejazapp/widgets/book_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SelfDevelopent extends StatefulWidget {
  final String category;
  const SelfDevelopent({super.key, required this.category});

  @override
  State<SelfDevelopent> createState() => _SelfDevelopentState();
}

class _SelfDevelopentState extends State<SelfDevelopent> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() {
    final booksApi = Provider.of<BooksApi>(context, listen: false);
    booksApi.fetchBooksSelfdevelopement();
  }

  @override
  Widget build(BuildContext context) {
    final booksApi = Provider.of<BooksApi>(context, listen: true);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          height: 270,
          child: booksApi.selfBook.isNotEmpty
              ? ListView.builder(
                  itemCount: booksApi.selfBook.length,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(left: Const.margin),
                  itemBuilder: (context, index) {
                    Book? book;

                    book = booksApi.selfBook[index];
                    return BookCard(book: book);
                  },
                )
              : Center(child: CircularProgressIndicator()),
        )
      ],
    );
  }
}

class ListFilterCategory extends StatelessWidget {
  final String category;
  const ListFilterCategory({super.key, required this.category});
  @override
  Widget build(BuildContext context) {
    final booksApi = Provider.of<BooksApi>(context, listen: false);
    return booksApi.selfBook.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 270,
                child: ListView.builder(
                  itemCount: booksApi.selfBook.length,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(left: Const.margin),
                  itemBuilder: (context, index) {
                    Book? book;
                    if (booksApi.selfBook[index].categories.length > 0) {
                      if ((booksApi.selfBook[index].categories[0]['ct_Name'] ==
                              category) ||
                          (booksApi.selfBook[index].categories[0]
                                  ['ct_Name_Ar'] ==
                              category)) {
                        book = booksApi.selfBook[index];
                        return BookCard(book: book);
                      } else {
                        return Text('');
                      }
                    }
                    return null;
                  },
                ),
              )
            ],
          )
        : Center(child: CircularProgressIndicator());
  }
}

class ListFilterCategoryForyou extends StatefulWidget {
  final String category;
  const ListFilterCategoryForyou({super.key, required this.category});

  @override
  State<ListFilterCategoryForyou> createState() =>
      _ListFilterCategoryForyouState();
}

class _ListFilterCategoryForyouState extends State<ListFilterCategoryForyou> {
  void initState() {
    super.initState();
    if (mounted) {
      FetchData();
    }
  }

  FetchData() async {
    if (!mounted) return;
    final booksApi = Provider.of<BooksApi>(context, listen: false);
    await booksApi.getBooks();

    if (!mounted) return;
    setState(() {
      mockBookList; // just an example
    });
  }

  @override
  Widget build(BuildContext context) {
    return mockBookList.isNotEmpty
        ? Column(
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
                    Book? book;
                    if (mockBookList[index].categories.length > 0) {
                      if ((mockBookList[index].categories[0]['ct_Name'] ==
                              widget.category) ||
                          (mockBookList[index].categories[0]['ct_Name_Ar'] ==
                              widget.category)) {
                        book = mockBookList[index];
                        return BookCard(book: book);
                      } else {
                        return Text('');
                      }
                    }
                    return null;
                  },
                ),
              )
            ],
          )
        : Center(child: CircularProgressIndicator());
  }
}

class ListTrendBooks extends StatefulWidget {
  const ListTrendBooks({super.key});

  @override
  State<ListTrendBooks> createState() => _ListTrendBooksState();
}

class _ListTrendBooksState extends State<ListTrendBooks> {
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final booksApi = Provider.of<BooksApi>(context, listen: false);
    await booksApi.GetTrendBooks();
  }

  @override
  Widget build(BuildContext context) {
    final booksApi = context.watch<BooksApi>();

    if (booksApi.trendBook.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          height: 270,
          child: ListView.builder(
            itemCount: booksApi.trendBook.length,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(left: Const.margin),
            itemBuilder: (context, index) {
              final trendBook = booksApi.trendBook[index];

              return FutureBuilder<Book?>(
                future: booksApi.searchBookbyIdList(trendBook.bk_ID!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox(
                      width: 150,
                      child: Center(child: CircularProgressIndicator()),
                    );
                  } else if (snapshot.hasData && snapshot.data != null) {
                    return BookCard(book: snapshot.data!);
                  } else {
                    return const SizedBox();
                  }
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
