import 'package:ejazapp/helpers/routes.dart';
import 'package:ejazapp/pages/book_scanner/camerapreview.dart';
import 'package:ejazapp/pages/Sign_pages/Sign_in/sign_in_page.dart'; //
import 'package:ejazapp/pages/Sign_pages/Sign_in/sign_in_with_email_page.dart'; //
import 'package:ejazapp/pages/book/book_details/view_publishers.dart';
import 'package:ejazapp/pages/chat/chat_screen.dart';
import 'package:ejazapp/pages/chat_list/chat_list_screen.dart';
import 'package:ejazapp/pages/profile/statistic.dart';
import 'package:ejazapp/pages/home/stories/add_post.dart';
import 'package:ejazapp/pages/home/authors/list_authors.dart';
import 'package:ejazapp/pages/home/authors/profile_page.dart';
import 'package:ejazapp/pages/playlist/play_audio_multi/audiobookitem.dart';
import 'package:ejazapp/pages/book/book_details/book_detail.dart';
import 'package:ejazapp/pages/book/book_details/comment.dart';
import 'package:ejazapp/pages/book/play_audio_single/player_list.dart';
import 'package:ejazapp/pages/book/book_details/takeway.dart';
import 'package:ejazapp/pages/book/chat_user/userchoose.dart';
import 'package:ejazapp/pages/book/chat_user/userslist.dart';
import 'package:ejazapp/pages/bottom_nav_page.dart';
import 'package:ejazapp/pages/book_scanner/chat_ai.dart';
import 'package:ejazapp/pages/for_you/category/details_category.dart';
import 'package:ejazapp/pages/favorite/favorite_page.dart';
import 'package:ejazapp/pages/Sign_pages/forgot_password/forgot_password_page.dart';
import 'package:ejazapp/pages/Sign_pages/forgot_password/reset_password.dart';
import 'package:ejazapp/pages/Sign_pages/forgot_password/select_phone_email.dart';
import 'package:ejazapp/pages/Sign_pages/forgot_password/updatepassword.dart';
import 'package:ejazapp/pages/for_you/gift_ejaz/gift-ejaz.dart';
import 'package:ejazapp/pages/view_all/all_item.dart';
import 'package:ejazapp/pages/home/collection/collection.dart';
import 'package:ejazapp/pages/download/list.dart';
import 'package:ejazapp/pages/notification/notificationList.dart';
import 'package:ejazapp/pages/notification/notificationPage.dart';
import 'package:ejazapp/pages/on_boarding/on_boarding_page.dart';
import 'package:ejazapp/pages/Sign_pages/optverification/mobile_number_page.dart';
import 'package:ejazapp/pages/Sign_pages/optverification/otp_view.dart';
import 'package:ejazapp/pages/payment/checkout_page.dart';
import 'package:ejazapp/pages/payment/order_detail_page.dart';
import 'package:ejazapp/pages/payment/order_success_page.dart';
import 'package:ejazapp/pages/payment/payment_page.dart';
import 'package:ejazapp/pages/payment/paypal_payment_page.dart';
import 'package:ejazapp/pages/payment/slectplan.dart';
import 'package:ejazapp/pages/payment/thanku_page.dart';
import 'package:ejazapp/pages/playlist/add_audio_playlist.dart';
import 'package:ejazapp/pages/playlist/add_playlist.dart';
import 'package:ejazapp/pages/playlist/create_show_list.dart';
import 'package:ejazapp/pages/privacy_page/privacy_policy.dart';
import 'package:ejazapp/pages/profile/change_language_page.dart';
import 'package:ejazapp/pages/profile/change_language_profile.dart';
import 'package:ejazapp/pages/profile/setting_page.dart';
import 'package:ejazapp/pages/Sign_pages/sign_up/select_category.dart';
import 'package:ejazapp/pages/Sign_pages/sign_up/select_dark_light.dart';
import 'package:ejazapp/pages/Sign_pages/sign_up/sign_up_user_address_page.dart';
import 'package:ejazapp/pages/Sign_pages/sign_up/signup_page.dart'; //
import 'package:ejazapp/pages/Sign_pages/sign_up/summaries_lang.dart';
import 'package:ejazapp/pages/Sign_pages/sign_up/uploaded_avatar.dart';
import 'package:ejazapp/pages/splash_page.dart';
import 'package:ejazapp/pages/home/suggestion/suggest.dart';
import 'package:get/get.dart';

List<GetPage<dynamic>> allPages = [
  GetPage(name: Routes.splash,
      page: () => SplashPage()),
  GetPage(name: Routes.onboarding, page: () => const OnBoardingPage()),
  GetPage(name: Routes.signin,
      page: () => const SignInPage()),
  GetPage(
    name: Routes.signinwithemail,
    page: () => const SignInWithEmailPage(), //,
  ),
  GetPage(name: Routes.signup, page: () => const SignUpPage()), //
  GetPage(
    name: Routes.signupaddress,
    page: () => const SignUpUserAddressPage(),
  ),
  GetPage(name: Routes.mobilenumberpage, page: () => const MobileNumberPage()),
  GetPage(name: Routes.forgotpassword, page: () => const ForgotPasswordPage()),
  GetPage(name: Routes.updatepassword, page: () => const UpdatePasswrod()),
  GetPage(name: Routes.selectphoneemail, page: () => const SelectPhoneEmail()),
  GetPage(name: Routes.home, page: () => const BottomNavPage()),
  GetPage(
    name: Routes.explore,
    page: () => const BottomNavPage(initialIndex: 1),
  ),
  //  GetPage(
  //   name: Routes.chatai,
  //   page: () => const BottomNavPage(initialIndex: 2),
  // ),
  GetPage(
      name: Routes.createshowList,
      page: () => const BottomNavPage(initialIndex: 2)),
  GetPage(
    name: Routes.profile,
    page: () => const BottomNavPage(initialIndex: 3),
  ),
  GetPage(name: Routes.bookdetail, page: () => const BookDetailPage()),
  GetPage(name: Routes.checkout, page: () => const CheckoutPage()),
  GetPage(name: Routes.ordersuccess, page: () => const OrderSuccessPage()),
  GetPage(name: Routes.payment, page: () => const PaymentPage()),
  GetPage(name: Routes.orderdetail, page: () => const OrderDetailPage()),
  GetPage(name: Routes.paypal, page: () => const PayPalPaymentPage()),
  GetPage(name: Routes.settings, page: () => const SettingPage()),
  GetPage(name: Routes.changeLanguage, page: () => const ChangeLanguage()),
  GetPage(name: Routes.privacypolicy, page: () => const PrivacyPolicy()),
  GetPage(name: Routes.resetpassword, page: () => const ResetPasswrod()),
  GetPage(name: Routes.listbook, page: () => const ListBook()),
  GetPage(name: Routes.otpview, page: () => const OTPView()),
  GetPage(name: Routes.favorite, page: () => const FavoritePage()),
  GetPage(name: Routes.authors, page: () => const AuthorsPage()),
  GetPage(name: Routes.category, page: () => const CategoryPage()),
  GetPage(name: Routes.allitem, page: () => const AllItem()),
  GetPage(name: Routes.notification, page: () => const NotificationList()),
  GetPage(name: Routes.selectcategory, page: () => const SelectCategory()),
  GetPage(name: Routes.summarieslang, page: () => const SummariesLanguage()),
  GetPage(name: Routes.selectdarklight, page: () => const SelectDarkLight()),
  GetPage(name: Routes.uploadedavatar, page: () => const UploadedAvatar()),
  GetPage(
      name: Routes.notificationdetails, page: () => const NotificationPage()),
  GetPage(
    name: Routes.changeLanguageprofile,
    page: () => const ChangeLanguageProfile(),
  ),
  GetPage(name: Routes.selectplan, page: () => const SelectPlan()),
  GetPage(name: Routes.comment, page: () => const UsersPage()),
  GetPage(name: Routes.audiobook, page: () =>  AudioBook()),
  GetPage(name: Routes.listauthors, page: () => const ListAuthors()),
  GetPage(name: Routes.comentpage, page: () => const CommentPage()),
  GetPage(name: Routes.userchoose, page: () => const UserChoose()),
  GetPage(name: Routes.collection, page: () => const CollectionPage()),
  GetPage(name: Routes.takeway, page: () => const takeway()),
  GetPage(name: Routes.playerList, page: () => const Player()),
  GetPage(name: Routes.playListPage, page: () => const Create_showList()),
  GetPage(name: Routes.createshowList, page: () => const Create_showList()),
  GetPage(name: Routes.addaudioplay, page: () => const AddAudioPlay()),
  GetPage(name: Routes.addplayList, page: () => const AddplayList()),
  GetPage(name: Routes.giftejaz, page: () => const GiftEjaz()),
  GetPage(name: Routes.suggesttejaz, page: () => const SuggestEjaz()),
  GetPage(name: Routes.addpost, page: () => const AddPost()),
  GetPage(name: Routes.chatai, page: () => const GeminiChat()),
  GetPage(name: Routes.thankyou, page: () => const ThankYouPage(title: '',)),
  GetPage(name: Routes.TakePictureScreen, page: () =>  TakePictureScreen(camera: null,)),
  GetPage(name: Routes.viewpublishers, page: () =>  ListViewpublisher()),
  GetPage(name: Routes.statistic, page: () =>  Statistic()),
   GetPage(name: Routes.chatList, page: () => ChatListScreen(),),
  GetPage(name: Routes.chat, page: () => ChatScreen(user: Get.arguments['user'],),)


];
