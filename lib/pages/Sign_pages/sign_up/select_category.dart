import 'dart:io' show Platform;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ejazapp/core/services/services.dart';
import 'package:ejazapp/data/models/category.dart';
import 'package:ejazapp/helpers/colors.dart';
import 'package:ejazapp/helpers/routes.dart';
import 'package:ejazapp/providers/locale_provider.dart';
import 'package:ejazapp/providers/theme_provider.dart';
import 'package:ejazapp/widgets/custom_elevated_button.dart';
import 'package:ejazapp/widgets/placeholders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class SelectCategory extends StatefulWidget {
  const SelectCategory({super.key});

  @override
  State<SelectCategory> createState() => _SelectCategoryState();
}

class _SelectCategoryState extends State<SelectCategory> {
  late final List<CategoryL> category;
  bool valuefirst = false;

  List<Map<String, String>> _selectValue = [];
  final List<bool> _checks = List.generate(CategoryList.length, (_) => false);
  @override
  void initState() {
    category = CategoryList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localeProv = Provider.of<LocaleProvider>(context);
    final themeProv = Provider.of<ThemeProvider>(context);
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
        bottomNavigationBar: BottomAppBar(
            color: Colors.transparent,
            elevation: 0,
            height: Platform.isIOS ? 100 : 85,
            child: getStartedButton()),
        body: NestedScrollView(
          body: Stack(children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10),
              child: Text(
                AppLocalizations.of(context)!
                    .select_catetegory, // AppLocalizations.of(context)!.change_language,
                style: theme.textTheme.headlineLarge!.copyWith(fontSize: 28),
                textAlign: TextAlign.center,
              ), //
            ),
            const SizedBox(height: 30),
            Padding(
                padding: const EdgeInsets.only(top: 55.0, left: 10, right: 10),
                child: Text(
                  AppLocalizations.of(context)!.choose_witch_you_have,
                  style: theme.textTheme.headlineLarge!
                      .copyWith(fontSize: 12, height: 1.3),
                  textAlign: TextAlign.start,
                )),
            const SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.only(top: 120.0, left: 25, right: 25),
              child: RotatedBox(
                quarterTurns:
                    localeProv.localelang!.languageCode == 'ar' ? 2 : 0,
                child: LinearPercentIndicator(
                  width: MediaQuery.of(context).size.width - 50,
                  lineHeight: 6.0,
                  percent: 0.25,
                  linearStrokeCap: LinearStrokeCap.roundAll,
                  backgroundColor: Colors.grey,
                  progressColor: ColorLight.primary,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(top: 160.0),
              child: category.isNotEmpty
                  ? GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            (orientation == Orientation.portrait) ? 2 : 3,
                        childAspectRatio: MediaQuery.of(context).size.width /
                            (MediaQuery.of(context).size.height / 2.5),
                      ),
                      padding: EdgeInsets.all(0),
                      itemCount: category.length,
                      itemBuilder: (context, index) {
                        final category = CategoryList[index];

                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                    category.imagePath),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 85.0, bottom: 20),
                              child: Theme(
                                data: ThemeData(
                                  unselectedWidgetColor: Colors.white,
                                ),
                                child: CheckboxListTile(
                                  side: const BorderSide(color: Colors.white),
                                  activeColor: Colors.green,
                                  checkColor: Colors.white,
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  visualDensity: VisualDensity(
                                      horizontal: -1, vertical: -2),
                                  // groupValue: _selectedIndex,
                                  title: Text(
                                    localeProv.localelang!.languageCode == 'ar'
                                        ? category.ct_Name_Ar
                                        : category.ct_Name,
                                    maxLines: 2,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        height: 1),
                                  ),
                                  value: _checks[index],
                                  onChanged: (newVal) {
                                    setState(() {
                                      _checks[index] = newVal!;

                                      if (newVal) {
                                        // Add the selected item if it doesn't already exist
                                        if (!_selectValue.any((element) =>
                                            element["ct_Title"] ==
                                                category.ct_Title &&
                                            element["ct_Title_Ar"] ==
                                                category.ct_Title_Ar)) {
                                          _selectValue.add({
                                            "ct_Title": category.ct_Title,
                                            "ct_Title_Ar": category.ct_Title_Ar,
                                          });
                                        }
                                      } else {
                                        // Remove the selected item
                                        _selectValue.removeWhere((element) =>
                                            element["ct_Title"] ==
                                                category.ct_Title &&
                                            element["ct_Title_Ar"] ==
                                                category.ct_Title_Ar);
                                      }

                                      // Save to local storage
                                      mybox!.put('category', _selectValue);
                                      var cat = mybox!.get('category');
                                      print("_selectValue ====$cat");
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : SizedBox(
                      child: Center(
                        child: Shimmer.fromColors(
                          baseColor: Colors.blue,
                          highlightColor: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 15,
                              ),
                              ContentPlaceholder(
                                lineType: ContentLineType.threeLines,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              ContentPlaceholder(
                                lineType: ContentLineType.threeLines,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              BannerPlaceholder(),
                            ],
                          ),
                        ),
                      ),
                    ),
            )
          ]),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                  backgroundColor: theme.colorScheme.surface,
                  foregroundColor:
                      themeProv.isDarkTheme! ? Colors.blue : Colors.blue,
                  // backgroundColor: themeProv.isDarkTheme!
                  //     ? ColorDark.background
                  //     : Colors.white,
                  pinned: true,
                  centerTitle: true,
                  automaticallyImplyLeading: true),
            ];
          },
        ));
  }

  SizedBox getStartedButton() {
    return SizedBox(
      height: 100,
      child: Padding(
        padding:
            const EdgeInsets.only(top: 5, bottom: 10, left: 30.0, right: 30),
        child: MyRaisedButton(
          height: 50,
          width: 50,
          label: AppLocalizations.of(context)!.setep1,
          onTap: () async {
            Get.toNamed(Routes.summarieslang);
          },
        ),
      ),
    );
  }
}
