
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

import '../../helpers/colors.dart';
import '../../providers/theme_provider.dart';

class documentMessageWidget extends StatelessWidget {
  const documentMessageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final themeProv = Provider.of<ThemeProvider>(context);
    final theme = Theme.of(context);

    final Color grey = Color(0xffA8A8A8);
    Color blueColor = Color(0xff0F99D6);

    bool isArabic=Localizations.localeOf(context).languageCode=='ar';

    final TextStyle f11Font = TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w400,
        color: themeProv.isDarkTheme != null && themeProv.isDarkTheme!
            ? ColorDark.fontTitle
            : ColorLight.fontTitle);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 36,
          width: 198,
          padding: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
              color: blueColor, borderRadius: BorderRadius.circular(8)),
          child: Row(
            children: [
              Icon(
                CupertinoIcons.doc_fill,
                size: 12,
                color: theme.cardColor,
              ),
              SizedBox(
                width: 10,
              ),
              Padding(
                padding:EdgeInsets.only(top:!isArabic?5:0),
                child: Text(
                  'document docx',
                  style: f11Font.copyWith(color: Colors.white),
                ),
              ),
              Spacer(),
              Icon(
                Feather.download,
                size: 12,
                color: theme.cardColor,
              )
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Text(
              'Document File',
              style: f11Font.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(),
            Text(
              '2mb',
              style: f11Font,
            )
          ],
        )
      ],
    );
  }
}