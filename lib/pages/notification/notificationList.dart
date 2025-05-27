import 'package:ejazapp/core/services/services.dart';
import 'package:ejazapp/helpers/constants.dart';
import 'package:ejazapp/pages/notification/component/notificationTiles.dart';
import 'package:ejazapp/providers/theme_provider.dart';
import 'package:ejazapp/widgets/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:ejazapp/l10n/app_localizations.dart';

import 'package:provider/provider.dart';

class NotificationList extends StatefulWidget {
  const NotificationList() : super();

  @override
  _NotificationListState createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  get key1 => null;
  List ListNotif = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  init() {
    var message = mybox!.get('message');
    if (message != null) ListNotif = mybox!.get('message') as List;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeProv = Provider.of<ThemeProvider>(context);
    // mybox!.get('message').clear();

    return Scaffold(
        body: NestedScrollView(
            physics: NeverScrollableScrollPhysics(),
            body: ListNotif.isNotEmpty
                ? ListView.separated(
                    physics: const ClampingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: ListNotif.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key:
                            UniqueKey(), // Using UniqueKey instead of ListNotif[index][0].toString()
                        // Unique key for each item
                        direction: DismissDirection
                            .endToStart, // Swipe from right to left
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        onDismissed: (direction) {
                          // Remove the item and update storage
                          setState(() {
                            ListNotif.removeAt(index);
                            mybox!.put('message', ListNotif);
                            // Use Future.microtask to ensure the widget tree updates properly
                            Future.microtask(() => setState(() {}));
                          });
                        },
                        child: NotificationTiles(
                          title: ListNotif[index][0].toString(),
                          subtitle: ListNotif[index][1].toString(),
                          date: ListNotif[index][2].toString(),
                          enable: true,
                          onTap: () {},
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        color: themeProv.isDarkTheme!
                            ? Colors.white
                            : Colors.black,
                        height: 2,
                      );
                    },
                  )
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
                    automaticallyImplyLeading: true),
              ];
            }));
  }
}
