import 'dart:io' show Platform;
import 'package:ejazapp/core/services/services.dart';
import 'package:ejazapp/data/datasource/remote/listapi/getdataserver.dart';
import 'package:ejazapp/data/models/subscription.dart';
import 'package:ejazapp/helpers/colors.dart';
import 'package:ejazapp/helpers/constants.dart';
import 'package:ejazapp/providers/locale_provider.dart';
import 'package:ejazapp/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ejazapp/l10n/app_localizations.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_fatoorah/my_fatoorah.dart';
import 'package:provider/provider.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../profile/profile_page.dart';
import 'package:pay/pay.dart';

class SelectPlan extends StatefulWidget {
  const SelectPlan({super.key});

  @override
  State<SelectPlan> createState() => _SelectPlanState();
}

class _SelectPlanState extends State<SelectPlan> {
  late final Future<PaymentConfiguration> _googlePayConfigFuture;
  late final Future<PaymentConfiguration> _applePayConfigFuture;

  @override
  void initState() {
    super.initState();
    _googlePayConfigFuture =
        PaymentConfiguration.fromAsset('default_google_pay_config.json');
    _applePayConfigFuture =
        PaymentConfiguration.fromAsset('default_apple_pay_config.json');
  }

  void onGooglePayResult(paymentResult) {
    print(paymentResult);
    final token =
        paymentResult['paymentMethodData']['tokenizationData']['token'];
    print(token);
   // BooksApi().PaymentPostGoogle(token, paymentResult);
    // Get.toNamed(Routes.thankyou);
  }

  void onApplePayResult(paymentResult) async {
    print(paymentResult.toString());
    final token = paymentResult['token'];
    // final tokenJson = Map.castFrom(json.decode(token));
 //   BooksApi().PaymentPostApple(token, paymentResult);
    // Get.toNamed(Routes.thankyou,arguments: ['success']);
  }

  int? selectedIndex = -1;
  int index = 0;
  int index1 = 1;
  double ammountS = 0;
  List payment = [true];

  @override
  Widget build(BuildContext context) {
    List<dynamic> plandescription = [];
    List<Subscription> SubscriptionList = [];
    plandescription = mybox!.get('subscriptionplan') as List;
    index = 0;
    for (var element in plandescription) {
      Map? obj = element as Map;
      SubscriptionList.add(Subscription(
          sb_Active: obj['sb_Active'] as bool,
          sb_Code: "",
          index: index,
          sb_Desc: obj['sb_Desc'] as String,
          sb_Desc_Ar: obj['sb_Desc_Ar'] as String,
          sb_DiscountDesc: obj['sb_DiscountDesc'] as String,
          sb_DiscountDesc_Ar: obj['sb_DiscountDesc_Ar'] as String,
          sb_ID: obj['sb_ID'] as String,
          sb_Name: obj['sb_Name'] as String,
          sb_Name_Ar: obj['sb_Name_Ar'] as String,
          sb_Price: obj['sb_Price'] as int));
      index = 1;
    }
    // print('number plan   $data');
    final theme = Theme.of(context);
    final themeProv = Provider.of<ThemeProvider>(context);
    final localprovider = Provider.of<LocaleProvider>(context, listen: true);
    return Scaffold(
        body: NestedScrollView(
      body: Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: payment.isNotEmpty
            ? Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    child: Column(children: <Widget>[
                      Container(
                        alignment:
                            localprovider.localelang!.languageCode == 'ar'
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                        child: Text(
                          AppLocalizations.of(context)!
                              .select_your_plan_subscription,
                          style: theme.textTheme.headlineMedium!.copyWith(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: themeProv.isDarkTheme!
                                  ? Colors.white
                                  : ColorDark.background),
                          maxLines: 1,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Container(
                        alignment:
                            localprovider.localelang!.languageCode == 'ar'
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                        child: Text(
                          AppLocalizations.of(context)!.get_prenuim,
                          style: theme.textTheme.headlineMedium!.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: themeProv.isDarkTheme!
                                  ? Colors.white
                                  : ColorDark.background),
                          maxLines: 1,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Column(
                          children: SubscriptionList.map(
                        (e) => GestureDetector(
                          child: Card(
                            color: selectedIndex == e.index
                                ? themeProv.isDarkTheme!
                                    ? Color.fromARGB(255, 71, 182, 234)
                                    : Color.fromARGB(255, 155, 213, 240)
                                : null,
                            child: ListTile(
                              title: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      localprovider.localelang!.languageCode ==
                                              'ar'
                                          ? e.sb_Name_Ar
                                          : e.sb_Name,
                                      style: theme.textTheme.headlineMedium!
                                          .copyWith(
                                              fontSize: 20,
                                              fontWeight: FontWeight.normal,
                                              color: themeProv.isDarkTheme!
                                                  ? Colors.white
                                                  : ColorDark.background),
                                      maxLines: 1,
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          NumberFormat.currency(
                                            symbol: r'USD ',
                                            decimalDigits: 0,
                                            locale: 'en-EN',
                                          ).format(e.sb_Price),
                                          overflow: TextOverflow.clip,
                                          textAlign: TextAlign.left,
                                          style: theme.textTheme.bodyLarge!
                                              .copyWith(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold,
                                                  color: themeProv.isDarkTheme!
                                                      ? Colors.white
                                                      : ColorDark.background),
                                        ),
                                        if (e.sb_DiscountDesc != '')
                                          Container(
                                              padding: const EdgeInsets.only(
                                                  left: 10, right: 10),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(18),
                                                color: ColorLight.primary,
                                              ),
                                              child: Padding(
                                                padding: localprovider
                                                            .localelang!
                                                            .languageCode ==
                                                        'ar'
                                                    ? const EdgeInsets.only(
                                                        top: 0)
                                                    : const EdgeInsets.only(
                                                        top: 8.0),
                                                child: Text(
                                                  localprovider.localelang!
                                                              .languageCode ==
                                                          'ar'
                                                      ? e.sb_DiscountDesc_Ar
                                                      : e.sb_DiscountDesc,
                                                  style: theme
                                                      .textTheme.bodyLarge!
                                                      .copyWith(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                ),
                                              ))
                                        else
                                          Text(''),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              if (selectedIndex == e.index) {
                                selectedIndex = -1;
                                ammountS = 0;
                                int? numb = e.index;
                                print('index     $numb');
                              } else {
                                selectedIndex = e.index;
                                ammountS = e.sb_Price.toDouble();
                                print('ammountS     $ammountS');
                                int? numb = e.index;
                                print('index     $numb');
                              }
                            });
                          },
                        ),
                      ).toList()),
                    ]),
                  ),
                  const Spacer(),
                  Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Platform.isIOS != true
                          ?
                          // code pay button configured using an asset
                          FutureBuilder<PaymentConfiguration>(
                              future: _googlePayConfigFuture,
                              builder: (context, snapshot) => snapshot.hasData
                                  ? ammountS != 0
                                      ? GooglePayButton(
                                          theme: themeProv.isDarkTheme!
                                              ? GooglePayButtonTheme.light
                                              : GooglePayButtonTheme.dark,
                                          width: double.infinity,
                                          margin: EdgeInsets.only(
                                              left: 20, right: 20, top: 15),
                                          paymentConfiguration: snapshot.data!,
                                          paymentItems: [
                                            PaymentItem(
                                              label: 'Total',
                                              amount: '$ammountS',
                                              status:
                                                  PaymentItemStatus.final_price,
                                            )
                                          ],
                                          type: GooglePayButtonType.buy,
                                          onPaymentResult: onGooglePayResult,
                                          loadingIndicator: const Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                          onError: (error) {
                                            print(error);
                                          },
                                        )
                                      : const SizedBox.shrink()
                                  : Container())
                          : // code pay button configured using a string
                     
                          FutureBuilder<PaymentConfiguration>(
                              future: _applePayConfigFuture,
                              builder: (context, snapshot) => snapshot.hasData
                                  ? ammountS != 0
                                      ? ApplePayButton(
                                          cornerRadius: 80.0,
                                          width: double.infinity,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.05,
                                          margin: EdgeInsets.only(
                                              left: 20, right: 20, top: 15),
                                          style: themeProv.isDarkTheme!
                                              ? ApplePayButtonStyle.white
                                              : ApplePayButtonStyle.black,
                                          paymentConfiguration: snapshot.data!,
                                          paymentItems: [
                                            PaymentItem(
                                              label: 'Total',
                                              amount: '$ammountS',
                                              status:
                                                  PaymentItemStatus.final_price,
                                            )
                                          ],
                                          type: ApplePayButtonType.buy,
                                          onPaymentResult: onApplePayResult,
                                          loadingIndicator: const Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                          onError: (error) {
                                            print(error);
                                          },
                                        )
                                      : Container(
                                          child: Text(
                                            "",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        )
                                  : Container())

                      //  MyRaisedButton(
                      //   onTap: () {
                      //     PayNow(localprovider);
                      //   }, // PayNow(localprovider),
                      //   label: AppLocalizations.of(context)!.pay_now,
                      // ),
                      ),
                  const SizedBox(height: Const.margin),
                ],
              )
            : Container(
                child: Center(
                  child: Text(
                    localprovider.localelang!.languageCode == 'ar'
                        ? "سيتم التحديث قريبا !"
                        : "Will update soon !",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
      ),
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

  void PayNow(localprovider) async {
    print('ammount          $ammountS');
    if (ammountS != 0) {
      final response = await MyFatoorah.startPayment(
        context: context,
        successChild: const Icon(Icons.rocket),
        errorChild: const Icon(Icons.error),
        // afterPaymentBehaviour:
        // AfterPaymentBehaviour.BeforeCallbackExecution,
        request: MyfatoorahRequest.test(
          currencyIso: Country.Qatar,
          successUrl: 'https://www.facebook.com',
          errorUrl: 'https://www.google.com/',
          invoiceAmount: ammountS,
          language: localprovider.localelang!.languageCode == 'ar'
              ? ApiLanguage.Arabic
              : ApiLanguage.English,
          token:
              'rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL',
        ),
      );
      String status = response.status.toString();
      print('payment Status    $status');
      mybox!.put('PaymentStatus', status);
      log(response.paymentId.toString());
    } else {
      // set up the button
      Widget okButton = TextButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.pop(context);
        },
      );
      // ignore: omit_local_variable_types
      AlertDialog alert = AlertDialog(
        title: Text(
          AppLocalizations.of(context)!.alert,
          style: TextStyle(
            fontSize: 15,
          ),
          textAlign: TextAlign.center,
        ),
        contentPadding: EdgeInsets.all(20),
        content: Text(
          AppLocalizations.of(context)!.please_select_plan_subsc,
          style: TextStyle(fontSize: 17),
        ),
        actions: [
          okButton,
        ],
      );
      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
  }
}

void PaymentDo(BuildContext context) async {
  try {
    Offerings offerings = await Purchases.getOfferings();
    if (offerings.current != null &&
        offerings.current!.availablePackages.isNotEmpty) {
      // Display current offering with offerings.current
      // final offer = offerings.first;
      // ignore: inference_failure_on_function_invocation, use_build_context_synchronously
      await showModalBottomSheet(
        useRootNavigator: true,
        isDismissible: true,
        isScrollControlled: true,
        backgroundColor: ColorDark.background,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setModalState) {
            return Paywall(
              offering: offerings.current!,
            );
          });
        },
      );
    } else {
      Get.snackbar('Ejaz', 'No Subscription', snackPosition: SnackPosition.TOP);
    }
  } on PlatformException catch (e) {
    Get.snackbar('Ejaz', e.toString(), snackPosition: SnackPosition.TOP);
    print(e);
    // optional error handling
  }
}
