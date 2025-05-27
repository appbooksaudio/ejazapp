import 'package:ejazapp/core/class/statusrequest.dart';
import 'package:ejazapp/core/functions/handingdatacontroller.dart';
import 'package:ejazapp/core/services/services.dart';
import 'package:ejazapp/data/datasource/remote/auth/login.dart';
import 'package:ejazapp/data/datasource/remote/firebaseapi/updatetoken.dart';
import 'package:ejazapp/helpers/colors.dart';
import 'package:ejazapp/helpers/routes.dart';
import 'package:ejazapp/l10n/app_localizations.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class LoginController extends GetxController {
  late BuildContext context;
  login(context);
}

class LoginControllerImp extends LoginController {
  LoginData loginData = LoginData(Get.find());
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  late TextEditingController email;
  late TextEditingController password;

  MyServices myServices = Get.find();

  bool isshowpassword = true;

  StatusRequest statusRequest = StatusRequest.none;

  showPassword() {
    isshowpassword = isshowpassword == true ? false : true;
    update();
  }

  List data = [];

  @override
  login(context) async {
    if (formstate.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      var response = await loginData.postdata(email.text, password.text);
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['isSubscribed'] == true) {
          mybox!.put('PaymentStatus', 'success');
          myServices.prefs.setString('name', response['displayName'] as String);
          myServices.prefs.setString("authorized", response['token'] as String);
          myServices.prefs.setString('refreshToken', response['refreshToken']);
          myServices.prefs.setString("image", response['image'] as String);
          mybox!.put('name', response['displayName'] as String);
          await FirebaseMessaging.instance.getToken().then((value) {
            print(value);
            String? token = value;
            myServices.prefs.setString('token', token!);
            UpdateFirebaseToken(token);
          });
          Get.offNamed(Routes.home);
          return;
        }
        if (response['isSubscribed'] == false) {
          mybox!.put('PaymentStatus', 'pending');
          myServices.prefs.setString('name', response['displayName'] as String);
          myServices.prefs.setString("authorized", response['token'] as String);
          myServices.prefs.setString('refreshToken', response['refreshToken']);
          myServices.prefs.setString("image", response['image'] as String);
          mybox!.put('name', response['displayName'] as String);
          await FirebaseMessaging.instance.getToken().then((value) {
            print(value);
            String? token = value;
            myServices.prefs.setString('token', token!);
            UpdateFirebaseToken(token);
          });

          Get.offNamed(Routes.home);
          return;
        } else {
          //  ShowPopup(response);
          showLoaderDialog(context);
        }
      } else {
        // ShowPopup(response);
        showLoaderDialog(context);
      }
      update();
    } else {}
  }

  @override
  goToSignUp() {
    //  Get.offNamed(AppRoute.signUp);
  }

  @override
  void onInit() {
    // FirebaseMessaging.instance.getToken().then((value) {
    //   print(value);
    //   String? token = value;
    // });
    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  goToForgetPassword() {
    // Get.toNamed(Routes.forgetPassword);
  }
  showLoaderDialog(
    BuildContext context,
  ) {
    final theme = Theme.of(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    AlertDialog alert = AlertDialog(
        insetPadding: EdgeInsets.only(
            bottom: height * 0.4,
            top: height * 0.20,
            left: width * 0.02,
            right: width * 0.02),
        content: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // CircularProgressIndicator(
              //   color: Colors.white,
              // ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  AppLocalizations.of(context)!.passwordwrong,
                  style: theme.textTheme.titleLarge!
                      .copyWith(color: ColorLight.primary, fontSize: 20),
                ),
              ),
            ],
          ),
        ));
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(height: 300, child: alert);
      },
    );
  }
}
