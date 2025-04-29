import 'package:ejazapp/data/datasource/remote/listapi/getdataserver.dart';
import 'package:ejazapp/data/models/book.dart';
import 'package:ejazapp/helpers/colors.dart';
import 'package:ejazapp/helpers/constants.dart';
import 'package:ejazapp/providers/locale_provider.dart';
import 'package:ejazapp/providers/theme_provider.dart';
import 'package:ejazapp/widgets/book_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ListViewpublisher extends StatefulWidget {
  const ListViewpublisher({Key? key}) : super(key: key);

  @override
  State<ListViewpublisher> createState() => _ListViewpublisherState();
}

class _ListViewpublisherState extends State<ListViewpublisher> {
  Book? book;
  String Id_Pub = "";
  String Id_Pub_name = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    book = Get.arguments[0] as Book;
    Id_Pub_name = Get.arguments[1] as String;
    Id_Pub = Get.arguments[2] as String;
    ;
    Future.microtask(() async {
      await Provider.of<BooksApi>(context, listen: false)
          .getBooksBypublishers(Id_Pub);
    });
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    var height = MediaQuery.of(context).size.height;
    final themeProv = Provider.of<ThemeProvider>(context);
    final theme = Theme.of(context);
    final localprovider = Provider.of<LocaleProvider>(context, listen: true);
    return Scaffold(
      backgroundColor:
          themeProv.isDarkTheme! ? ColorDark.background : Color(0xFFdde3f9),
      appBar: AppBar(
        title: Text(
          Id_Pub_name,
          style: TextStyle(
              fontSize: 20,
              color:
                  themeProv.isDarkTheme! ? Colors.white : ColorDark.background),
        ),
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color:
              themeProv.isDarkTheme! ? Color(0xFFdde3f9) : ColorDark.background,
          onPressed: () => Get.back<dynamic>(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: Consumer<BooksApi>(
                      builder: (context, booksApi, child) {
                        return Text(
                          "${localprovider.localelang!.languageCode == 'en' ? "Showing" : "عرض"} "
                          "${booksApi.getbooksbypublishers.length} "
                          "${localprovider.localelang!.languageCode == 'en' ? "books" : "كتب"}",
                          textAlign: TextAlign.start,
                          style: theme.textTheme.bodyMedium!
                              .copyWith(height: 1.3, fontSize: 15),
                        );
                      },
                    )),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Consumer<BooksApi>(
                builder: (context, booksApi, child) {
                  return booksApi.getbooksbypublishers.isNotEmpty
                      ? GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 0,
                            crossAxisSpacing: 0,
                            mainAxisExtent: height * 0.30,
                            crossAxisCount:
                                (orientation == Orientation.portrait) ? 3 : 6,
                            childAspectRatio:
                                MediaQuery.of(context).size.width /
                                    (MediaQuery.of(context).size.height),
                          ),
                          itemCount: booksApi.getbooksbypublishers.length,
                          scrollDirection: Axis.vertical,
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(left: Const.margin),
                          itemBuilder: (BuildContext context, int index) {
                            Book book;
                            book = booksApi.getbooksbypublishers[index];
                            return BookCardDetailsCategory(book: book);
                          })
                      : Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
