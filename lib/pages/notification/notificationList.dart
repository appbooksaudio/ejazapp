import 'package:ejazapp/core/services/services.dart';
import 'package:ejazapp/helpers/constants.dart';
import 'package:ejazapp/pages/notification/component/notificationTiles.dart';
import 'package:ejazapp/providers/theme_provider.dart';
import 'package:ejazapp/widgets/empty_widget.dart';
import 'package:ejazapp/widgets/rectangularButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

class NotificationList extends StatefulWidget {
  const NotificationList() : super();

  @override
  _NotificationListState createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  get key1 => null;

  @override
  Widget build(BuildContext context) {
    bool isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final theme = Theme.of(context);
    final themeProv = Provider.of<ThemeProvider>(context);
    // mybox!.get('message').clear();
    List ListNotif = [];
    var message = mybox!.get('message');
    if (message != null) ListNotif = mybox!.get('message') as List;

    return Scaffold(
        body: NestedScrollView(
            physics: NeverScrollableScrollPhysics(),
            body: ListNotif.isNotEmpty
                ? ListView.separated(
                    physics: const ClampingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: ListNotif.length,
                    itemBuilder: (context, index) {
                      return NotificationTiles(
                        title: ListNotif[index][0].toString(),
                        subtitle: ListNotif[index][1].toString(),
                        date: ListNotif[index][2].toString(),
                        enable: true,
                        // ignore: inference_failure_on_function_invocation
                        onTap: () {
                          // ListNotif.removeAt(index);
                          // mybox!.put('message', ListNotif);
                          // setState(() {
                          //   ListNotif = ListNotif;
                          // });
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        color: themeProv.isDarkTheme!
                            ? Colors.white
                            : Colors.black,
                        height: 2,
                      );
                    })
                : Center(
                    child: EmptyWidget(
                      image: Const.notificationsstate,
                      title: AppLocalizations.of(context)!.no_notification_yet,
                      subtitle: AppLocalizations.of(context)!.no_notification,
                    ),
                  ),
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  backgroundColor: theme.colorScheme.surface,
                  foregroundColor:
                      themeProv.isDarkTheme! ? Colors.blue : Colors.blue,
                  pinned: true,
                  centerTitle: false,
                  automaticallyImplyLeading: true,
                  actions: [
                 if(ListNotif.isNotEmpty)  GestureDetector(
                   onTap: () {
                     ListNotif.clear();
                     mybox!.put('message', ListNotif);
                     setState(() {
                       ListNotif = ListNotif;
                     });
                   },
                   child: Container(height: 30,width: 100,decoration: BoxDecoration(
                       color: Colors.red.withAlpha(90),
                       borderRadius: BorderRadius.circular(8)

                     ),child: Center(child: Padding(
                       padding: const EdgeInsets.only(top: 5),
                       child: Text('Clear all',style: theme.textTheme.titleMedium,),
                     )),),
                 ),
                        // : SizedBox.shrink()
                    SizedBox(width: 16,)
                  ],
                ),
              ];
            }));
  }

}
