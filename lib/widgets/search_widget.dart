import 'package:chat_app/helpers/colors.dart';
import 'package:chat_app/providers/locale_provider.dart';
import 'package:chat_app/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/l10n/app_localizations.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';

class SearchWidget extends StatefulWidget {
  final String text;
  final ValueChanged<String> onChanged;
  final String? hintText;

  const SearchWidget({
    Key? key,
    required this.text,
    required this.onChanged,
    required this.hintText,
  }) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final themeProv = Provider.of<ThemeProvider>(context);
    final styleActive = TextStyle(
      color: themeProv.isDarkTheme! ? Colors.white : Colors.black,
    );

    final styleHint = TextStyle(
      color: themeProv.isDarkTheme! ? Colors.white : Colors.black,
    );
    final style = widget.text.isEmpty ? styleHint : styleActive;
    final theme = Theme.of(context);
    final localprovider = Provider.of<LocaleProvider>(context, listen: true);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        //border: Border.all(color: Colors.black26),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: controller,
              autocorrect: false,
              decoration: InputDecoration(
                hintStyle:
                    const TextStyle(fontSize: 14.0, color: Color(0xFF9CA3AF)),
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                suffixIcon: widget.text.isNotEmpty
                    ? GestureDetector(
                        child: Icon(Icons.close, color: style.color),
                        onTap: () {
                          controller.clear();
                          widget.onChanged('');
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                      )
                    : null,
                hintText:widget.hintText??
                    AppLocalizations.of(context)!.search_your_favorite_book,
                contentPadding: 
                         EdgeInsets.only(top: 5.0),
                icon: Icon(
                  Feather.search,
                  size: 20,
                  color: themeProv.isDarkTheme!
                      ? Colors.white
                      : ColorLight.primary,
                ),
              ),
              style: style,
              onChanged: widget.onChanged,
            ),
          ),
          // IconButton(
          //   icon: const Icon(Feather.sliders),
          //   iconSize: 0,
          //   color: theme.primaryColor,
          //   onPressed: slidersOnTap,
          // ),
        ],
      ),
    );
    //
    // Container(
    //   height: 42,
    //   margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(12),
    //     color: Colors.white,
    //     border: Border.all(color: Colors.black26),
    //   ),
    //   padding: const EdgeInsets.symmetric(horizontal: 8),
    //   child: Column(
    //     children: [
    //       TextField(
    //         controller: controller,
    //         decoration: InputDecoration(
    //           icon: Icon(Icons.search, color: style.color),
    //           suffixIcon: widget.text.isNotEmpty
    //               ? GestureDetector(
    //                   child: Icon(Icons.close, color: style.color),
    //                   onTap: () {
    //                     controller.clear();
    //                     widget.onChanged('');
    //                     FocusScope.of(context).requestFocus(FocusNode());
    //                   },
    //                 )
    //               : null,
    //           hintText: widget.hintText,
    //           hintStyle: style,
    //           border: InputBorder.none,
    //         ),
    //         style: style,
    //         onChanged: widget.onChanged,
    //       ),
    //       IconButton(
    //         icon: const Icon(Feather.sliders),
    //         iconSize: 20,
    //         color: theme.primaryColor,
    //         onPressed: slidersOnTap,
    //       ),
    //     ],
    //   ),
    // );
  }

  void slidersOnTap() {}
}
