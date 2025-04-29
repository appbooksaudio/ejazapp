import 'package:ejazapp/data/datasource/remote/listapi/getdataserver.dart';
import 'package:ejazapp/data/models/book.dart';
import 'package:ejazapp/helpers/constants.dart';
import 'package:ejazapp/pages/home/collection/collection.dart';
import 'package:ejazapp/providers/locale_provider.dart';
import 'package:ejazapp/providers/theme_provider.dart';
import 'package:ejazapp/widgets/book_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListTrendBooksViewAll extends StatefulWidget {
  const ListTrendBooksViewAll({super.key});

  @override
  State<ListTrendBooksViewAll> createState() => _ListTrendBooksViewAllState();
}

class _ListTrendBooksViewAllState extends State<ListTrendBooksViewAll> {
  late final BooksApi booksApi;

  @override
  void initState() {
    super.initState();
    booksApi = Provider.of<BooksApi>(context, listen: false);
    _fetchData();
  }

  Future<void> _fetchData() async {
    await booksApi.GetTrendBooks();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final orientation = MediaQuery.of(context).orientation;
    final localeProv = Provider.of<LocaleProvider>(context);
    final themeProv = Provider.of<ThemeProvider>(context);
    final theme = Theme.of(context);
    return Scaffold(
      body: NestedScrollView(
        physics: NeverScrollableScrollPhysics(),
        body: Consumer<BooksApi>(
          builder: (context, booksApi, _) {
            if (booksApi.trendBook.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),

                // Top Title Widget
                Consumer<BooksApi>(
                  builder: (context, booksApi, child) {
                    return buildSettingApp(
                      context,
                      title: localeProv.localelang!.languageCode == 'en'
                          ? "Showing ${booksApi.trendBook.length} books"
                          : "عرض ${booksApi.trendBook.length} كتب",
                      style:
                          theme.textTheme.headlineLarge!.copyWith(fontSize: 17),
                      trailing: Container(),
                      onTap: () {},
                    );
                  },
                ),

                const SizedBox(height: 10),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.all(10),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        mainAxisExtent: height * 0.29,
                        crossAxisCount:
                            orientation == Orientation.portrait ? 3 : 6,
                      ),
                      itemCount: booksApi.trendBook.length,
                      itemBuilder: (context, index) {
                        final book = booksApi.trendBook[index];
                        return FutureBuilder<Book?>(
                          future: booksApi.searchBookbyIdList(book.bk_ID!),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (snapshot.hasData &&
                                snapshot.data != null) {
                              return BookCardDetailsCategory(
                                  book: snapshot.data!);
                            } else {
                              return const SizedBox(); // or placeholder
                            }
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: theme.colorScheme.surface,
              foregroundColor:
                  themeProv.isDarkTheme! ? Colors.blue : Colors.blue,
              pinned: true,
              centerTitle: true,
              automaticallyImplyLeading: true,
            ),
          ];
        },
      ),
    );
  }
}
