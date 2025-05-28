import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart' as intl;
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @chat_app.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Ejaz'**
  String get chat_app;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @about_us.
  ///
  /// In en, this message translates to:
  /// **'About us'**
  String get about_us;

  /// No description provided for @accept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get accept;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @activities.
  ///
  /// In en, this message translates to:
  /// **'Activities'**
  String get activities;

  /// No description provided for @addToCart.
  ///
  /// In en, this message translates to:
  /// **'Add to Cart'**
  String get addToCart;

  /// No description provided for @add_address.
  ///
  /// In en, this message translates to:
  /// **'Add address'**
  String get add_address;

  /// No description provided for @add_credit_card.
  ///
  /// In en, this message translates to:
  /// **'Add credit card'**
  String get add_credit_card;

  /// No description provided for @add_to_cart.
  ///
  /// In en, this message translates to:
  /// **'Add to Cart'**
  String get add_to_cart;

  /// No description provided for @add_to_list.
  ///
  /// In en, this message translates to:
  /// **'Add to List'**
  String get add_to_list;

  /// No description provided for @added_to_cart.
  ///
  /// In en, this message translates to:
  /// **'Added to cart'**
  String get added_to_cart;

  /// No description provided for @added_to_favorite.
  ///
  /// In en, this message translates to:
  /// **'Added to Favorite'**
  String get added_to_favorite;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @address_added.
  ///
  /// In en, this message translates to:
  /// **'Address added'**
  String get address_added;

  /// No description provided for @address_changed.
  ///
  /// In en, this message translates to:
  /// **'Address changed'**
  String get address_changed;

  /// No description provided for @address_deleted.
  ///
  /// In en, this message translates to:
  /// **'Address deleted'**
  String get address_deleted;

  /// No description provided for @again.
  ///
  /// In en, this message translates to:
  /// **'again'**
  String get again;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @all_bag.
  ///
  /// In en, this message translates to:
  /// **'All bag'**
  String get all_bag;

  /// No description provided for @all_dress.
  ///
  /// In en, this message translates to:
  /// **'All dress'**
  String get all_dress;

  /// No description provided for @all_movies.
  ///
  /// In en, this message translates to:
  /// **'All Movies'**
  String get all_movies;

  /// No description provided for @all_review.
  ///
  /// In en, this message translates to:
  /// **'All Review'**
  String get all_review;

  /// No description provided for @all_shoes.
  ///
  /// In en, this message translates to:
  /// **'All shoes'**
  String get all_shoes;

  /// No description provided for @already_have_an_account.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get already_have_an_account;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// No description provided for @and_the.
  ///
  /// In en, this message translates to:
  /// **'and the'**
  String get and_the;

  /// No description provided for @apart.
  ///
  /// In en, this message translates to:
  /// **'Apart'**
  String get apart;

  /// No description provided for @apple_sign_in_clicked.
  ///
  /// In en, this message translates to:
  /// **'Apple sign in clicked'**
  String get apple_sign_in_clicked;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @apply_coupon.
  ///
  /// In en, this message translates to:
  /// **'Apply coupon'**
  String get apply_coupon;

  /// No description provided for @apply_filter.
  ///
  /// In en, this message translates to:
  /// **'Apply Filter'**
  String get apply_filter;

  /// No description provided for @applying.
  ///
  /// In en, this message translates to:
  /// **'Applying'**
  String get applying;

  /// No description provided for @appointment.
  ///
  /// In en, this message translates to:
  /// **'Appointment'**
  String get appointment;

  /// No description provided for @appointment_details.
  ///
  /// In en, this message translates to:
  /// **'Appointment details'**
  String get appointment_details;

  /// No description provided for @appointment_number.
  ///
  /// In en, this message translates to:
  /// **'Appointment number'**
  String get appointment_number;

  /// No description provided for @are_you_sure.
  ///
  /// In en, this message translates to:
  /// **'Are you sure?'**
  String get are_you_sure;

  /// No description provided for @are_you_sure_cancel_your_order.
  ///
  /// In en, this message translates to:
  /// **'Are you sure cancel your order?'**
  String get are_you_sure_cancel_your_order;

  /// No description provided for @are_you_sure_wanna_delete_address.
  ///
  /// In en, this message translates to:
  /// **'Are you sure wanna delete address?'**
  String get are_you_sure_wanna_delete_address;

  /// No description provided for @are_you_sure_want_to_quit.
  ///
  /// In en, this message translates to:
  /// **'Are you sure want to Exit?'**
  String get are_you_sure_want_to_quit;

  /// No description provided for @are_you_sure_you_want_to_cancel_your_appointment.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to cancel your appointment?'**
  String get are_you_sure_you_want_to_cancel_your_appointment;

  /// No description provided for @are_you_sure_you_want_to_checkout_now.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to checkout now?'**
  String get are_you_sure_you_want_to_checkout_now;

  /// No description provided for @are_you_sure_you_want_to_delete_this_message.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this message?'**
  String get are_you_sure_you_want_to_delete_this_message;

  /// No description provided for @are_you_sure_you_want_to_move_to_chat.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to move to chat?'**
  String get are_you_sure_you_want_to_move_to_chat;

  /// No description provided for @are_you_sure_you_want_to_quit.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to Exit?'**
  String get are_you_sure_you_want_to_quit;

  /// No description provided for @are_you_sure_you_want_to_sign_out.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to sign out?'**
  String get are_you_sure_you_want_to_sign_out;

  /// No description provided for @at.
  ///
  /// In en, this message translates to:
  /// **'at'**
  String get at;

  /// No description provided for @attach_file_clicked.
  ///
  /// In en, this message translates to:
  /// **'Attach file clicked'**
  String get attach_file_clicked;

  /// No description provided for @authenticated_as.
  ///
  /// In en, this message translates to:
  /// **'Authenticated as'**
  String get authenticated_as;

  /// No description provided for @available_coupon.
  ///
  /// In en, this message translates to:
  /// **'Available coupon'**
  String get available_coupon;

  /// No description provided for @available_languages.
  ///
  /// In en, this message translates to:
  /// **'Available Languages'**
  String get available_languages;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @back_to_dashboard.
  ///
  /// In en, this message translates to:
  /// **'Back to Dashboard'**
  String get back_to_dashboard;

  /// No description provided for @back_to_my_order.
  ///
  /// In en, this message translates to:
  /// **'Back to My Order'**
  String get back_to_my_order;

  /// No description provided for @back_to_sign_in.
  ///
  /// In en, this message translates to:
  /// **'Back to Sign in'**
  String get back_to_sign_in;

  /// No description provided for @backup.
  ///
  /// In en, this message translates to:
  /// **'Backup'**
  String get backup;

  /// No description provided for @bag.
  ///
  /// In en, this message translates to:
  /// **'Bag'**
  String get bag;

  /// No description provided for @bank_tansfer.
  ///
  /// In en, this message translates to:
  /// **'Bank Transfer'**
  String get bank_tansfer;

  /// No description provided for @barber.
  ///
  /// In en, this message translates to:
  /// **'Barber'**
  String get barber;

  /// No description provided for @barber_specialist.
  ///
  /// In en, this message translates to:
  /// **'Barber specialist'**
  String get barber_specialist;

  /// No description provided for @barbershop.
  ///
  /// In en, this message translates to:
  /// **'Barbershop'**
  String get barbershop;

  /// No description provided for @basic_info.
  ///
  /// In en, this message translates to:
  /// **'Basic info'**
  String get basic_info;

  /// No description provided for @bath.
  ///
  /// In en, this message translates to:
  /// **'Bath'**
  String get bath;

  /// No description provided for @bathrooms.
  ///
  /// In en, this message translates to:
  /// **'Bathrooms'**
  String get bathrooms;

  /// No description provided for @best_barbershop.
  ///
  /// In en, this message translates to:
  /// **'Best Barbershop'**
  String get best_barbershop;

  /// No description provided for @best_seller.
  ///
  /// In en, this message translates to:
  /// **'Best Seller'**
  String get best_seller;

  /// No description provided for @bikini.
  ///
  /// In en, this message translates to:
  /// **'Bikini'**
  String get bikini;

  /// No description provided for @blouse.
  ///
  /// In en, this message translates to:
  /// **'Blouse'**
  String get blouse;

  /// No description provided for @book.
  ///
  /// In en, this message translates to:
  /// **'Book'**
  String get book;

  /// No description provided for @book_appointment.
  ///
  /// In en, this message translates to:
  /// **'Book appointment'**
  String get book_appointment;

  /// No description provided for @book_now.
  ///
  /// In en, this message translates to:
  /// **'Book now'**
  String get book_now;

  /// No description provided for @booking_details.
  ///
  /// In en, this message translates to:
  /// **'Booking details'**
  String get booking_details;

  /// No description provided for @booking_order_and_appointments.
  ///
  /// In en, this message translates to:
  /// **'Booking order and appointments'**
  String get booking_order_and_appointments;

  /// No description provided for @bookmarked.
  ///
  /// In en, this message translates to:
  /// **'Bookmarked'**
  String get bookmarked;

  /// No description provided for @boys.
  ///
  /// In en, this message translates to:
  /// **'Boys'**
  String get boys;

  /// No description provided for @brand.
  ///
  /// In en, this message translates to:
  /// **'Brand'**
  String get brand;

  /// No description provided for @browse_articles_photos_and_videos.
  ///
  /// In en, this message translates to:
  /// **'Browse articles, photos & videos'**
  String get browse_articles_photos_and_videos;

  /// No description provided for @browse_real_estate.
  ///
  /// In en, this message translates to:
  /// **'Browse Real Estate'**
  String get browse_real_estate;

  /// No description provided for @business_name.
  ///
  /// In en, this message translates to:
  /// **'Business name'**
  String get business_name;

  /// No description provided for @buy_again.
  ///
  /// In en, this message translates to:
  /// **'Buy again'**
  String get buy_again;

  /// No description provided for @buy_now.
  ///
  /// In en, this message translates to:
  /// **'Buy now'**
  String get buy_now;

  /// No description provided for @by_sign_in_you_agree_to_the.
  ///
  /// In en, this message translates to:
  /// **'By sign in you agree to the'**
  String get by_sign_in_you_agree_to_the;

  /// No description provided for @call.
  ///
  /// In en, this message translates to:
  /// **'Call'**
  String get call;

  /// No description provided for @camera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// No description provided for @camera_on_click.
  ///
  /// In en, this message translates to:
  /// **'Camera on click'**
  String get camera_on_click;

  /// No description provided for @can_send_again_in.
  ///
  /// In en, this message translates to:
  /// **'can send again in'**
  String get can_send_again_in;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @cancel_appointment.
  ///
  /// In en, this message translates to:
  /// **'Cancel appointment'**
  String get cancel_appointment;

  /// No description provided for @cancel_my_order.
  ///
  /// In en, this message translates to:
  /// **'Cancel My Order'**
  String get cancel_my_order;

  /// No description provided for @cancel_order.
  ///
  /// In en, this message translates to:
  /// **'Cancel order'**
  String get cancel_order;

  /// No description provided for @canceled_seller.
  ///
  /// In en, this message translates to:
  /// **'Canceled seller'**
  String get canceled_seller;

  /// No description provided for @cancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get cancelled;

  /// No description provided for @card_holder_name.
  ///
  /// In en, this message translates to:
  /// **'Card holder name'**
  String get card_holder_name;

  /// No description provided for @card_no.
  ///
  /// In en, this message translates to:
  /// **'Card No'**
  String get card_no;

  /// No description provided for @card_number.
  ///
  /// In en, this message translates to:
  /// **'Card Number'**
  String get card_number;

  /// No description provided for @cart.
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get cart;

  /// No description provided for @cart_added.
  ///
  /// In en, this message translates to:
  /// **'Cart added'**
  String get cart_added;

  /// No description provided for @cash_on_delivery.
  ///
  /// In en, this message translates to:
  /// **'Cash on delivery'**
  String get cash_on_delivery;

  /// No description provided for @categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @ccontinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get ccontinue;

  /// No description provided for @change.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get change;

  /// No description provided for @change_address.
  ///
  /// In en, this message translates to:
  /// **'Change address'**
  String get change_address;

  /// No description provided for @change_delivery_address.
  ///
  /// In en, this message translates to:
  /// **'Change delivery address'**
  String get change_delivery_address;

  /// No description provided for @change_email_address.
  ///
  /// In en, this message translates to:
  /// **'Change email address'**
  String get change_email_address;

  /// No description provided for @change_language.
  ///
  /// In en, this message translates to:
  /// **'Change language'**
  String get change_language;

  /// No description provided for @change_password.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get change_password;

  /// No description provided for @change_profile_photo.
  ///
  /// In en, this message translates to:
  /// **'Change profile photo'**
  String get change_profile_photo;

  /// No description provided for @changing.
  ///
  /// In en, this message translates to:
  /// **'Changing'**
  String get changing;

  /// No description provided for @chat.
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get chat;

  /// No description provided for @chat_archive.
  ///
  /// In en, this message translates to:
  /// **'Chat archive'**
  String get chat_archive;

  /// No description provided for @chat_with_us.
  ///
  /// In en, this message translates to:
  /// **'Chat with us'**
  String get chat_with_us;

  /// No description provided for @check_in.
  ///
  /// In en, this message translates to:
  /// **'Check in'**
  String get check_in;

  /// No description provided for @check_out.
  ///
  /// In en, this message translates to:
  /// **'Check out'**
  String get check_out;

  /// No description provided for @check_your_email.
  ///
  /// In en, this message translates to:
  /// **'Check your email'**
  String get check_your_email;

  /// No description provided for @checkout.
  ///
  /// In en, this message translates to:
  /// **'Checkout'**
  String get checkout;

  /// No description provided for @checkout_now.
  ///
  /// In en, this message translates to:
  /// **'Checkout Now'**
  String get checkout_now;

  /// No description provided for @choose_a_location.
  ///
  /// In en, this message translates to:
  /// **'Choose a location'**
  String get choose_a_location;

  /// No description provided for @choose_our_makeup_special_offer_price_package_that_fit_your_lifestyle.
  ///
  /// In en, this message translates to:
  /// **'Choose our Makeup special offer price Package that fit your Lifestyle'**
  String
      get choose_our_makeup_special_offer_price_package_that_fit_your_lifestyle;

  /// No description provided for @choose_the_destination_address.
  ///
  /// In en, this message translates to:
  /// **'Choose the destination address'**
  String get choose_the_destination_address;

  /// No description provided for @choose_your_furniture.
  ///
  /// In en, this message translates to:
  /// **'Choose your furniture'**
  String get choose_your_furniture;

  /// No description provided for @choose_your_payment_method.
  ///
  /// In en, this message translates to:
  /// **'Choose Your Payment Method'**
  String get choose_your_payment_method;

  /// No description provided for @choose_your_service.
  ///
  /// In en, this message translates to:
  /// **'Choose your service'**
  String get choose_your_service;

  /// No description provided for @city.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @color.
  ///
  /// In en, this message translates to:
  /// **'Color'**
  String get color;

  /// No description provided for @coloring.
  ///
  /// In en, this message translates to:
  /// **'Coloring'**
  String get coloring;

  /// No description provided for @colors.
  ///
  /// In en, this message translates to:
  /// **'Colors'**
  String get colors;

  /// No description provided for @comment.
  ///
  /// In en, this message translates to:
  /// **'Comment'**
  String get comment;

  /// No description provided for @complete.
  ///
  /// In en, this message translates to:
  /// **'Complete'**
  String get complete;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @condition.
  ///
  /// In en, this message translates to:
  /// **'Condition'**
  String get condition;

  /// No description provided for @conditions.
  ///
  /// In en, this message translates to:
  /// **'Conditions'**
  String get conditions;

  /// No description provided for @conditions_clicked.
  ///
  /// In en, this message translates to:
  /// **'Conditions clicked'**
  String get conditions_clicked;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @confirm_order.
  ///
  /// In en, this message translates to:
  /// **'Confirm order'**
  String get confirm_order;

  /// No description provided for @confirm_password.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirm_password;

  /// No description provided for @confirm_password_does_not_match.
  ///
  /// In en, this message translates to:
  /// **'Confirm password does not match'**
  String get confirm_password_does_not_match;

  /// No description provided for @congratuation_your_order_has_been_placed_please_make_a_payment_to_continue_the_transaction.
  ///
  /// In en, this message translates to:
  /// **'Congratulation your order has been placed, please make a payment to continue the transaction.'**
  String
      get congratuation_your_order_has_been_placed_please_make_a_payment_to_continue_the_transaction;

  /// No description provided for @connect_with_apple_id.
  ///
  /// In en, this message translates to:
  /// **'Connect with Apple ID'**
  String get connect_with_apple_id;

  /// No description provided for @connect_with_facebook.
  ///
  /// In en, this message translates to:
  /// **'Connect with Facebook'**
  String get connect_with_facebook;

  /// No description provided for @connect_with_google.
  ///
  /// In en, this message translates to:
  /// **'Connect with Google'**
  String get connect_with_google;

  /// No description provided for @contact_the_seller.
  ///
  /// In en, this message translates to:
  /// **'Contact the seller'**
  String get contact_the_seller;

  /// No description provided for @contact_us.
  ///
  /// In en, this message translates to:
  /// **'Contact us'**
  String get contact_us;

  /// No description provided for @continue_shopping.
  ///
  /// In en, this message translates to:
  /// **'Continue Shopping'**
  String get continue_shopping;

  /// No description provided for @continuee.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continuee;

  /// No description provided for @copy_code.
  ///
  /// In en, this message translates to:
  /// **'Copy code'**
  String get copy_code;

  /// No description provided for @cost_high_to_low.
  ///
  /// In en, this message translates to:
  /// **'Cost High to Low'**
  String get cost_high_to_low;

  /// No description provided for @cost_low_to_high.
  ///
  /// In en, this message translates to:
  /// **'Cost Low to High'**
  String get cost_low_to_high;

  /// No description provided for @create_a_new_account.
  ///
  /// In en, this message translates to:
  /// **'Create a new account'**
  String get create_a_new_account;

  /// No description provided for @create_account.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get create_account;

  /// No description provided for @create_an_account.
  ///
  /// In en, this message translates to:
  /// **'Create an Account'**
  String get create_an_account;

  /// No description provided for @create_new_password.
  ///
  /// In en, this message translates to:
  /// **'Create new password'**
  String get create_new_password;

  /// No description provided for @create_your_account.
  ///
  /// In en, this message translates to:
  /// **'Create your account'**
  String get create_your_account;

  /// No description provided for @creative_solutions.
  ///
  /// In en, this message translates to:
  /// **'Creative Solutions'**
  String get creative_solutions;

  /// No description provided for @credit_card.
  ///
  /// In en, this message translates to:
  /// **'Credit Card'**
  String get credit_card;

  /// No description provided for @credit_card_added.
  ///
  /// In en, this message translates to:
  /// **'Credit card added'**
  String get credit_card_added;

  /// No description provided for @credit_card_or_debit.
  ///
  /// In en, this message translates to:
  /// **'Credit Card Or Debit'**
  String get credit_card_or_debit;

  /// No description provided for @credit_card_successfully_added.
  ///
  /// In en, this message translates to:
  /// **'Credit card successfully added'**
  String get credit_card_successfully_added;

  /// No description provided for @current_address.
  ///
  /// In en, this message translates to:
  /// **'Current address'**
  String get current_address;

  /// No description provided for @current_password.
  ///
  /// In en, this message translates to:
  /// **'Current Password'**
  String get current_password;

  /// No description provided for @custom.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get custom;

  /// No description provided for @customer_services.
  ///
  /// In en, this message translates to:
  /// **'Customer Services'**
  String get customer_services;

  /// No description provided for @cvv.
  ///
  /// In en, this message translates to:
  /// **'cvv'**
  String get cvv;

  /// No description provided for @dark_mode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get dark_mode;

  /// No description provided for @dark_theme.
  ///
  /// In en, this message translates to:
  /// **'Dark theme'**
  String get dark_theme;

  /// No description provided for @data_is_too_short.
  ///
  /// In en, this message translates to:
  /// **'Data is too short'**
  String get data_is_too_short;

  /// No description provided for @date_of_birth.
  ///
  /// In en, this message translates to:
  /// **'Date of birth'**
  String get date_of_birth;

  /// No description provided for @day.
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get day;

  /// No description provided for @days.
  ///
  /// In en, this message translates to:
  /// **'Days'**
  String get days;

  /// No description provided for @debit_or_credit_card.
  ///
  /// In en, this message translates to:
  /// **'Debit or Credit Card'**
  String get debit_or_credit_card;

  /// No description provided for @decline.
  ///
  /// In en, this message translates to:
  /// **'Decline'**
  String get decline;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @delete_chat.
  ///
  /// In en, this message translates to:
  /// **'Delete chat'**
  String get delete_chat;

  /// No description provided for @delete_on_click.
  ///
  /// In en, this message translates to:
  /// **'Delete on click'**
  String get delete_on_click;

  /// No description provided for @deliver_to.
  ///
  /// In en, this message translates to:
  /// **'Deliver to'**
  String get deliver_to;

  /// No description provided for @delivery.
  ///
  /// In en, this message translates to:
  /// **'Delivery'**
  String get delivery;

  /// No description provided for @delivery_details.
  ///
  /// In en, this message translates to:
  /// **'Delivery details'**
  String get delivery_details;

  /// No description provided for @delivery_method.
  ///
  /// In en, this message translates to:
  /// **'Delivery method'**
  String get delivery_method;

  /// No description provided for @delivery_status.
  ///
  /// In en, this message translates to:
  /// **'Delivery status'**
  String get delivery_status;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @destination.
  ///
  /// In en, this message translates to:
  /// **'Destination'**
  String get destination;

  /// No description provided for @destination_address.
  ///
  /// In en, this message translates to:
  /// **'Destination address'**
  String get destination_address;

  /// No description provided for @detail_address.
  ///
  /// In en, this message translates to:
  /// **'Detail address'**
  String get detail_address;

  /// No description provided for @detail_profile.
  ///
  /// In en, this message translates to:
  /// **'Detail profile'**
  String get detail_profile;

  /// No description provided for @detail_transaction.
  ///
  /// In en, this message translates to:
  /// **'Transaction Detail'**
  String get detail_transaction;

  /// No description provided for @did_not_receive_the_email_check_your_spam_filter_or.
  ///
  /// In en, this message translates to:
  /// **'Did not receive the email check your spam filter or'**
  String get did_not_receive_the_email_check_your_spam_filter_or;

  /// No description provided for @didnt_you_received_any_code.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t you received any code?'**
  String get didnt_you_received_any_code;

  /// No description provided for @direction.
  ///
  /// In en, this message translates to:
  /// **'Direction'**
  String get direction;

  /// No description provided for @discount.
  ///
  /// In en, this message translates to:
  /// **'Discount'**
  String get discount;

  /// No description provided for @discover.
  ///
  /// In en, this message translates to:
  /// **'Discover'**
  String get discover;

  /// No description provided for @discover_ideas_for_your_home.
  ///
  /// In en, this message translates to:
  /// **'Discover ideas for your home'**
  String get discover_ideas_for_your_home;

  /// No description provided for @discover_more_people.
  ///
  /// In en, this message translates to:
  /// **'Discover more People'**
  String get discover_more_people;

  /// No description provided for @discover_unique_ideas_for_your_home.
  ///
  /// In en, this message translates to:
  /// **'Discover unique ideas for your home'**
  String get discover_unique_ideas_for_your_home;

  /// No description provided for @district.
  ///
  /// In en, this message translates to:
  /// **'District'**
  String get district;

  /// No description provided for @do_you_want_to_exit.
  ///
  /// In en, this message translates to:
  /// **'Do you want to exit'**
  String get do_you_want_to_exit;

  /// No description provided for @does_not_have_a_rating_yet.
  ///
  /// In en, this message translates to:
  /// **'Does not have a rating yet'**
  String get does_not_have_a_rating_yet;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @dont_have_an_account.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dont_have_an_account;

  /// No description provided for @download.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get download;

  /// No description provided for @dress.
  ///
  /// In en, this message translates to:
  /// **'Dress'**
  String get dress;

  /// No description provided for @earn_and_buy.
  ///
  /// In en, this message translates to:
  /// **'Earn and Buy!'**
  String get earn_and_buy;

  /// No description provided for @easy.
  ///
  /// In en, this message translates to:
  /// **'Easy'**
  String get easy;

  /// No description provided for @easy_checkout_and_safe_payment_method_trusted_by_our_customers_from_all_over_the_world.
  ///
  /// In en, this message translates to:
  /// **'Easy Checkout & Safe Payment method. Trusted by our customers from all over the world.'**
  String
      get easy_checkout_and_safe_payment_method_trusted_by_our_customers_from_all_over_the_world;

  /// No description provided for @easy_discovering_new_places_and_share_these_between_your_friends_and_travel_together.
  ///
  /// In en, this message translates to:
  /// **'Easy discovering new places and share these between your friends and travel together'**
  String
      get easy_discovering_new_places_and_share_these_between_your_friends_and_travel_together;

  /// No description provided for @easy_payment.
  ///
  /// In en, this message translates to:
  /// **'Easy Payment'**
  String get easy_payment;

  /// No description provided for @easy_payment_for_you.
  ///
  /// In en, this message translates to:
  /// **'Easy Payment for You'**
  String get easy_payment_for_you;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @edit_address.
  ///
  /// In en, this message translates to:
  /// **'Edit address'**
  String get edit_address;

  /// No description provided for @edit_on_click.
  ///
  /// In en, this message translates to:
  /// **'Edit on click'**
  String get edit_on_click;

  /// No description provided for @edit_profile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get edit_profile;

  /// No description provided for @edit_your_profile.
  ///
  /// In en, this message translates to:
  /// **'Edit your Profile'**
  String get edit_your_profile;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @email_address.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get email_address;

  /// No description provided for @email_not_verified.
  ///
  /// In en, this message translates to:
  /// **'Email not verified'**
  String get email_not_verified;

  /// No description provided for @email_or_phone_number.
  ///
  /// In en, this message translates to:
  /// **'Email or phone number'**
  String get email_or_phone_number;

  /// No description provided for @empty_orders_lets_shop_now.
  ///
  /// In en, this message translates to:
  /// **'Empty order, let\'s shop now'**
  String get empty_orders_lets_shop_now;

  /// No description provided for @enjoy_your_shopping.
  ///
  /// In en, this message translates to:
  /// **'Enjoy Your Shopping'**
  String get enjoy_your_shopping;

  /// No description provided for @enjoy_your_trip.
  ///
  /// In en, this message translates to:
  /// **'Enjoy your Trip'**
  String get enjoy_your_trip;

  /// No description provided for @enter_address.
  ///
  /// In en, this message translates to:
  /// **'Enter your address'**
  String get enter_address;

  /// No description provided for @enter_card_holder_name.
  ///
  /// In en, this message translates to:
  /// **'Enter card holder name'**
  String get enter_card_holder_name;

  /// No description provided for @enter_card_number.
  ///
  /// In en, this message translates to:
  /// **'Enter the card number'**
  String get enter_card_number;

  /// No description provided for @enter_city_name.
  ///
  /// In en, this message translates to:
  /// **'Enter city name'**
  String get enter_city_name;

  /// No description provided for @enter_confirm_password.
  ///
  /// In en, this message translates to:
  /// **'Enter confirm password'**
  String get enter_confirm_password;

  /// No description provided for @enter_coupon.
  ///
  /// In en, this message translates to:
  /// **'Enter coupon'**
  String get enter_coupon;

  /// No description provided for @enter_coupon_code.
  ///
  /// In en, this message translates to:
  /// **'Enter coupon code'**
  String get enter_coupon_code;

  /// No description provided for @enter_cvv.
  ///
  /// In en, this message translates to:
  /// **'Enter CVV'**
  String get enter_cvv;

  /// No description provided for @enter_email_address.
  ///
  /// In en, this message translates to:
  /// **'Enter email address'**
  String get enter_email_address;

  /// No description provided for @enter_exp_date.
  ///
  /// In en, this message translates to:
  /// **'Enter exp date'**
  String get enter_exp_date;

  /// No description provided for @enter_first_name.
  ///
  /// In en, this message translates to:
  /// **'Enter first name'**
  String get enter_first_name;

  /// No description provided for @enter_full_name.
  ///
  /// In en, this message translates to:
  /// **'Enter username'**
  String get enter_full_name;

  /// No description provided for @enter_gender.
  ///
  /// In en, this message translates to:
  /// **'Enter gender'**
  String get enter_gender;

  /// No description provided for @enter_last_name.
  ///
  /// In en, this message translates to:
  /// **'Enter last name'**
  String get enter_last_name;

  /// No description provided for @enter_mobile_number.
  ///
  /// In en, this message translates to:
  /// **'Enter your mobile number to receive your verification code'**
  String get enter_mobile_number;

  /// No description provided for @send_code.
  ///
  /// In en, this message translates to:
  /// **'Send Code'**
  String get send_code;

  /// No description provided for @enter_new_password.
  ///
  /// In en, this message translates to:
  /// **'Enter new password'**
  String get enter_new_password;

  /// No description provided for @enter_password.
  ///
  /// In en, this message translates to:
  /// **'Enter password'**
  String get enter_password;

  /// No description provided for @enter_phone_number.
  ///
  /// In en, this message translates to:
  /// **'Enter phone number'**
  String get enter_phone_number;

  /// No description provided for @enter_promo_code.
  ///
  /// In en, this message translates to:
  /// **'Enter Promo Code'**
  String get enter_promo_code;

  /// No description provided for @enter_the_code_we_sent_via_sms_to_your_registered_phone.
  ///
  /// In en, this message translates to:
  /// **'Enter the code we sent via SMS to your registered phone'**
  String get enter_the_code_we_sent_via_sms_to_your_registered_phone;

  /// No description provided for @enter_the_email_associated_with_your_account_and_we_will_send_an_email_with_instructions_to_reset_your_password.
  ///
  /// In en, this message translates to:
  /// **'Enter the email associated with your account and we will send an email with instructions to reset your password'**
  String
      get enter_the_email_associated_with_your_account_and_we_will_send_an_email_with_instructions_to_reset_your_password;

  /// No description provided for @enter_the_email_associated_with_your_and_well_send_an_email_with_verification_code_to_reset_your_password.
  ///
  /// In en, this message translates to:
  /// **'Enter the email associated with your and we\'ll send an email with verification code to reset your password'**
  String
      get enter_the_email_associated_with_your_and_well_send_an_email_with_verification_code_to_reset_your_password;

  /// No description provided for @enter_the_promo_code.
  ///
  /// In en, this message translates to:
  /// **'Enter the promo code'**
  String get enter_the_promo_code;

  /// No description provided for @enter_the_verification_code_we_just_sent_you_on_your_email_address.
  ///
  /// In en, this message translates to:
  /// **'Enter the verification code we just sent you on your email address'**
  String get enter_the_verification_code_we_just_sent_you_on_your_email_address;

  /// No description provided for @enter_your_address.
  ///
  /// In en, this message translates to:
  /// **'Enter  Address'**
  String get enter_your_address;

  /// No description provided for @enter_your_city.
  ///
  /// In en, this message translates to:
  /// **'Enter your City'**
  String get enter_your_city;

  /// No description provided for @enter_your_details_informations.
  ///
  /// In en, this message translates to:
  /// **'Enter your Details Informations'**
  String get enter_your_details_informations;

  /// No description provided for @enter_your_email_address.
  ///
  /// In en, this message translates to:
  /// **'Enter your Email Address'**
  String get enter_your_email_address;

  /// No description provided for @enter_your_email_or_phone_number.
  ///
  /// In en, this message translates to:
  /// **'Enter your email or phone number'**
  String get enter_your_email_or_phone_number;

  /// No description provided for @enter_your_full_name.
  ///
  /// In en, this message translates to:
  /// **'Enter  Full Name'**
  String get enter_your_full_name;

  /// No description provided for @enter_your_password.
  ///
  /// In en, this message translates to:
  /// **'Enter password'**
  String get enter_your_password;

  /// No description provided for @enter_your_phone_number.
  ///
  /// In en, this message translates to:
  /// **'Enter  Phone Number'**
  String get enter_your_phone_number;

  /// No description provided for @enter_your_promo_code.
  ///
  /// In en, this message translates to:
  /// **'Enter your promo code'**
  String get enter_your_promo_code;

  /// No description provided for @enter_your_registered_email_address_or_phone_number_to_log_in.
  ///
  /// In en, this message translates to:
  /// **'Enter your registered email address or phone number to log in'**
  String get enter_your_registered_email_address_or_phone_number_to_log_in;

  /// No description provided for @enter_your_registered_email_below_to_receive_password_reset_authentication.
  ///
  /// In en, this message translates to:
  /// **'Enter your registered email below to receive password reset authentication'**
  String
      get enter_your_registered_email_below_to_receive_password_reset_authentication;

  /// No description provided for @enter_your_registered_email_below_to_receive_password_reset_instruction.
  ///
  /// In en, this message translates to:
  /// **'Enter your registered email below to receive password reset instruction'**
  String
      get enter_your_registered_email_below_to_receive_password_reset_instruction;

  /// No description provided for @enter_zip_code.
  ///
  /// In en, this message translates to:
  /// **'Enter Zip Code'**
  String get enter_zip_code;

  /// No description provided for @estimated.
  ///
  /// In en, this message translates to:
  /// **'Estimated'**
  String get estimated;

  /// No description provided for @estimated_duration.
  ///
  /// In en, this message translates to:
  /// **'Estimated duration'**
  String get estimated_duration;

  /// No description provided for @estimating_tax.
  ///
  /// In en, this message translates to:
  /// **'Estimating Tax'**
  String get estimating_tax;

  /// No description provided for @estimation.
  ///
  /// In en, this message translates to:
  /// **'Estimation'**
  String get estimation;

  /// No description provided for @excellent_developer.
  ///
  /// In en, this message translates to:
  /// **'Excellent Developer'**
  String get excellent_developer;

  /// No description provided for @exit.
  ///
  /// In en, this message translates to:
  /// **'Exit'**
  String get exit;

  /// No description provided for @exp_date.
  ///
  /// In en, this message translates to:
  /// **'Exp Date'**
  String get exp_date;

  /// No description provided for @expired.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get expired;

  /// No description provided for @explore.
  ///
  /// In en, this message translates to:
  /// **'For You'**
  String get explore;

  /// No description provided for @explore_trending_and_popular_designs_for_your_home_from_our_curated_list_of_collections.
  ///
  /// In en, this message translates to:
  /// **'Explore trending and popular designs for your home from our curated list of collections. '**
  String
      get explore_trending_and_popular_designs_for_your_home_from_our_curated_list_of_collections;

  /// No description provided for @eye_makeup.
  ///
  /// In en, this message translates to:
  /// **'Eye makeup'**
  String get eye_makeup;

  /// No description provided for @facebook.
  ///
  /// In en, this message translates to:
  /// **'Facebook'**
  String get facebook;

  /// No description provided for @facebook_sign_in_clicked.
  ///
  /// In en, this message translates to:
  /// **'Apple sign in clicked'**
  String get facebook_sign_in_clicked;

  /// No description provided for @facebook_sign_in_tapped.
  ///
  /// In en, this message translates to:
  /// **'Facebook Sign In Tapped!'**
  String get facebook_sign_in_tapped;

  /// No description provided for @fast.
  ///
  /// In en, this message translates to:
  /// **'Fast'**
  String get fast;

  /// No description provided for @discover_great.
  ///
  /// In en, this message translates to:
  /// **'Connecting readers globally'**
  String get discover_great;

  /// No description provided for @fast_delivery_and_secure.
  ///
  /// In en, this message translates to:
  /// **'Fast Delivery and Secure'**
  String get fast_delivery_and_secure;

  /// No description provided for @favorite.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorite;

  /// No description provided for @favorite_barbers_salon.
  ///
  /// In en, this message translates to:
  /// **'Favorite barbers salon'**
  String get favorite_barbers_salon;

  /// No description provided for @favorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites;

  /// No description provided for @feeds.
  ///
  /// In en, this message translates to:
  /// **'Feeds'**
  String get feeds;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @filter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// No description provided for @filter_applied.
  ///
  /// In en, this message translates to:
  /// **'Filter applied'**
  String get filter_applied;

  /// No description provided for @find_an_address.
  ///
  /// In en, this message translates to:
  /// **'Find an address'**
  String get find_an_address;

  /// No description provided for @find_and_book_barber_beauty_salon_spa_services_anywhere_anytime.
  ///
  /// In en, this message translates to:
  /// **'Find and Book barber, Beauty, Salon & Spa services anywhere, anytime'**
  String get find_and_book_barber_beauty_salon_spa_services_anywhere_anytime;

  /// No description provided for @find_and_book_service.
  ///
  /// In en, this message translates to:
  /// **'Find and Book Service'**
  String get find_and_book_service;

  /// No description provided for @find_best_deal.
  ///
  /// In en, this message translates to:
  /// **'Find best Deal'**
  String get find_best_deal;

  /// No description provided for @find_best_deal_on_furtira.
  ///
  /// In en, this message translates to:
  /// **'Find best deal on Furtira'**
  String get find_best_deal_on_furtira;

  /// No description provided for @find_books.
  ///
  /// In en, this message translates to:
  /// **'Find Titles'**
  String get find_books;

  /// No description provided for @find_perfect_place_for_your_dream.
  ///
  /// In en, this message translates to:
  /// **'Find Perfect Place\nfor Your Dream'**
  String get find_perfect_place_for_your_dream;

  /// No description provided for @find_the_best_local_professionals.
  ///
  /// In en, this message translates to:
  /// **'Find the best local professionals'**
  String get find_the_best_local_professionals;

  /// No description provided for @find_your_favorite_product_that_you_want_to_buy_easily.
  ///
  /// In en, this message translates to:
  /// **'Find your favorite product that you want to buy easily'**
  String get find_your_favorite_product_that_you_want_to_buy_easily;

  /// No description provided for @first_name.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get first_name;

  /// No description provided for @flash_sale.
  ///
  /// In en, this message translates to:
  /// **'Flash sale'**
  String get flash_sale;

  /// No description provided for @flat_shoes.
  ///
  /// In en, this message translates to:
  /// **'Flat shoes'**
  String get flat_shoes;

  /// No description provided for @follow.
  ///
  /// In en, this message translates to:
  /// **'Follow'**
  String get follow;

  /// No description provided for @follower.
  ///
  /// In en, this message translates to:
  /// **'Follower'**
  String get follower;

  /// No description provided for @following.
  ///
  /// In en, this message translates to:
  /// **'Following'**
  String get following;

  /// No description provided for @book_and_drink.
  ///
  /// In en, this message translates to:
  /// **'Book and Drink'**
  String get book_and_drink;

  /// No description provided for @book_shop.
  ///
  /// In en, this message translates to:
  /// **'No favorites yet'**
  String get book_shop;

  /// No description provided for @forgot_password.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgot_password;

  /// No description provided for @forgot_your_password.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get forgot_your_password;

  /// No description provided for @found_a_flight_that_matches_your_destination_and_schedule_book_it_instantly_in_just_a_few_taps.
  ///
  /// In en, this message translates to:
  /// **'Found a flight that matches your destination and schedule? Book it instantly in just a few taps'**
  String
      get found_a_flight_that_matches_your_destination_and_schedule_book_it_instantly_in_just_a_few_taps;

  /// No description provided for @follow_your_favorites.
  ///
  /// In en, this message translates to:
  /// **'Anytime, anywhere, any way'**
  String get follow_your_favorites;

  /// No description provided for @follow_your_favorites_two.
  ///
  /// In en, this message translates to:
  /// **'Contribute to the Ejaz library '**
  String get follow_your_favorites_two;

  /// No description provided for @discover_great_events_at_your_fingertips.
  ///
  /// In en, this message translates to:
  /// **'Discover great events at your fingertips'**
  String get discover_great_events_at_your_fingertips;

  /// No description provided for @friday.
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get friday;

  /// No description provided for @full_name.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get full_name;

  /// No description provided for @gallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @general.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get general;

  /// No description provided for @genre.
  ///
  /// In en, this message translates to:
  /// **'Genre'**
  String get genre;

  /// No description provided for @get_best_quality_product_from_shuppy_and_enjoy_with_product_discount.
  ///
  /// In en, this message translates to:
  /// **'Get best quality product from Shup.py and enjoy with product discount'**
  String
      get get_best_quality_product_from_shuppy_and_enjoy_with_product_discount;

  /// No description provided for @get_our_best_recommendation.
  ///
  /// In en, this message translates to:
  /// **'Get Our Best Recommendation'**
  String get get_our_best_recommendation;

  /// No description provided for @get_popular_fashion_from_home.
  ///
  /// In en, this message translates to:
  /// **'Get popular fashion from home'**
  String get get_popular_fashion_from_home;

  /// No description provided for @get_started.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get get_started;

  /// No description provided for @get_started_button_clicked.
  ///
  /// In en, this message translates to:
  /// **'Get started button clicked'**
  String get get_started_button_clicked;

  /// No description provided for @get_the_best_price_with_above_average_quality.
  ///
  /// In en, this message translates to:
  /// **'Get the best price with above average quality'**
  String get get_the_best_price_with_above_average_quality;

  /// No description provided for @get_your_favorite_book_from_here.
  ///
  /// In en, this message translates to:
  /// **'Get your favorite book from here'**
  String get get_your_favorite_book_from_here;

  /// No description provided for @gift_cards_vouchers.
  ///
  /// In en, this message translates to:
  /// **'Gift Cards & Vouchers'**
  String get gift_cards_vouchers;

  /// No description provided for @girls.
  ///
  /// In en, this message translates to:
  /// **'Girls'**
  String get girls;

  /// No description provided for @goods_received.
  ///
  /// In en, this message translates to:
  /// **'Goods received'**
  String get goods_received;

  /// No description provided for @google.
  ///
  /// In en, this message translates to:
  /// **'Google'**
  String get google;

  /// No description provided for @google_sign_in_clicked.
  ///
  /// In en, this message translates to:
  /// **'Google sign in clicked'**
  String get google_sign_in_clicked;

  /// No description provided for @google_sign_in_tapped.
  ///
  /// In en, this message translates to:
  /// **'Google Sign In Tapped!'**
  String get google_sign_in_tapped;

  /// No description provided for @great_fashion_app.
  ///
  /// In en, this message translates to:
  /// **'Great Fashion App'**
  String get great_fashion_app;

  /// No description provided for @haircut.
  ///
  /// In en, this message translates to:
  /// **'Haircut'**
  String get haircut;

  /// No description provided for @hairstyle.
  ///
  /// In en, this message translates to:
  /// **'Hairstyle'**
  String get hairstyle;

  /// No description provided for @handling_fee.
  ///
  /// In en, this message translates to:
  /// **'Handling fee'**
  String get handling_fee;

  /// No description provided for @has_been_canceled.
  ///
  /// In en, this message translates to:
  /// **'has been Canceled'**
  String get has_been_canceled;

  /// No description provided for @has_been_received_by_the_courier_please_wait_for_the_courier_to_arrive.
  ///
  /// In en, this message translates to:
  /// **'has been received by the courier, please wait for the courier to arrive'**
  String
      get has_been_received_by_the_courier_please_wait_for_the_courier_to_arrive;

  /// No description provided for @has_been_rejected_by_the_seller.
  ///
  /// In en, this message translates to:
  /// **'has been rejected by the seller'**
  String get has_been_rejected_by_the_seller;

  /// No description provided for @hat.
  ///
  /// In en, this message translates to:
  /// **'Hat'**
  String get hat;

  /// No description provided for @have_been_completed.
  ///
  /// In en, this message translates to:
  /// **'have been completed'**
  String get have_been_completed;

  /// No description provided for @hear_the_expert.
  ///
  /// In en, this message translates to:
  /// **'Hear The Expert'**
  String get hear_the_expert;

  /// No description provided for @hello.
  ///
  /// In en, this message translates to:
  /// **'Hello'**
  String get hello;

  /// No description provided for @help.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get help;

  /// No description provided for @hide_this_post.
  ///
  /// In en, this message translates to:
  /// **'Hide this post'**
  String get hide_this_post;

  /// No description provided for @hide_this_post_on_click.
  ///
  /// In en, this message translates to:
  /// **'Hide this post on click'**
  String get hide_this_post_on_click;

  /// No description provided for @high_hills.
  ///
  /// In en, this message translates to:
  /// **'High heels'**
  String get high_hills;

  /// No description provided for @highest_price_to_lowest_price.
  ///
  /// In en, this message translates to:
  /// **'Highest price to lowest price'**
  String get highest_price_to_lowest_price;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @list.
  ///
  /// In en, this message translates to:
  /// **'PlayList'**
  String get list;

  /// No description provided for @hooray_your_order_has_been_placed.
  ///
  /// In en, this message translates to:
  /// **'Hooray your order has been placed'**
  String get hooray_your_order_has_been_placed;

  /// No description provided for @hooray_your_package_is_being_packed_please_wait_for_the_seller_to_deliver_your_package.
  ///
  /// In en, this message translates to:
  /// **'Hooray your package is being packed please wait for the seller to deliver your package'**
  String
      get hooray_your_package_is_being_packed_please_wait_for_the_seller_to_deliver_your_package;

  /// No description provided for @hotel.
  ///
  /// In en, this message translates to:
  /// **'Hotel'**
  String get hotel;

  /// No description provided for @hours.
  ///
  /// In en, this message translates to:
  /// **'Hours'**
  String get hours;

  /// No description provided for @house.
  ///
  /// In en, this message translates to:
  /// **'House'**
  String get house;

  /// No description provided for @i_didnt_receive_the_code.
  ///
  /// In en, this message translates to:
  /// **'I didn’t receive the code'**
  String get i_didnt_receive_the_code;

  /// No description provided for @i_have_accept.
  ///
  /// In en, this message translates to:
  /// **'I have accept '**
  String get i_have_accept;

  /// No description provided for @if_you_select_log_out_it_will_return_to_the_login_screen.
  ///
  /// In en, this message translates to:
  /// **'If you log out, you will be returned to the log in screen'**
  String get if_you_select_log_out_it_will_return_to_the_login_screen;

  /// No description provided for @if_you_select_log_out_it_will_return_to_the_delete_account.
  ///
  /// In en, this message translates to:
  /// **'If you select delete, you will permanently lose your account and return to the login screen '**
  String get if_you_select_log_out_it_will_return_to_the_delete_account;

  /// No description provided for @delete_account.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get delete_account;

  /// No description provided for @import_charges.
  ///
  /// In en, this message translates to:
  /// **'Import charges'**
  String get import_charges;

  /// No description provided for @in_progress.
  ///
  /// In en, this message translates to:
  /// **'In Progress'**
  String get in_progress;

  /// No description provided for @inbox.
  ///
  /// In en, this message translates to:
  /// **'Inbox'**
  String get inbox;

  /// No description provided for @integrated_teamwork.
  ///
  /// In en, this message translates to:
  /// **'Integrated Teamwork'**
  String get integrated_teamwork;

  /// No description provided for @invalid_email_address_format.
  ///
  /// In en, this message translates to:
  /// **'Invalid email address format'**
  String get invalid_email_address_format;

  /// No description provided for @invalid_full_name_format.
  ///
  /// In en, this message translates to:
  /// **'invalid full name format'**
  String get invalid_full_name_format;

  /// No description provided for @invalid_number_format.
  ///
  /// In en, this message translates to:
  /// **'Invalid number format'**
  String get invalid_number_format;

  /// No description provided for @invalid_password_format.
  ///
  /// In en, this message translates to:
  /// **'Password must be more than 6 characters'**
  String get invalid_password_format;

  /// No description provided for @invalid_phone_number_format.
  ///
  /// In en, this message translates to:
  /// **'Invalid phone number format'**
  String get invalid_phone_number_format;

  /// No description provided for @invest_your_money.
  ///
  /// In en, this message translates to:
  /// **'Invest Your Money'**
  String get invest_your_money;

  /// No description provided for @is_waiting_for_payment.
  ///
  /// In en, this message translates to:
  /// **'is waiting for payment'**
  String get is_waiting_for_payment;

  /// No description provided for @item.
  ///
  /// In en, this message translates to:
  /// **'item'**
  String get item;

  /// No description provided for @item_color.
  ///
  /// In en, this message translates to:
  /// **'Item color'**
  String get item_color;

  /// No description provided for @item_ordered.
  ///
  /// In en, this message translates to:
  /// **'Item Ordered'**
  String get item_ordered;

  /// No description provided for @item_size.
  ///
  /// In en, this message translates to:
  /// **'Item size'**
  String get item_size;

  /// No description provided for @items.
  ///
  /// In en, this message translates to:
  /// **'Items'**
  String get items;

  /// No description provided for @items_purchased.
  ///
  /// In en, this message translates to:
  /// **'Items purchased'**
  String get items_purchased;

  /// No description provided for @jacket.
  ///
  /// In en, this message translates to:
  /// **'Jacket'**
  String get jacket;

  /// No description provided for @jeans.
  ///
  /// In en, this message translates to:
  /// **'Jeans'**
  String get jeans;

  /// No description provided for @just_2_clicks_and_you_can_buy_all_the_furniture_with_home_delivery.
  ///
  /// In en, this message translates to:
  /// **'Just 2 clicks and you can buy all the furniture with home delivery'**
  String get just_2_clicks_and_you_can_buy_all_the_furniture_with_home_delivery;

  /// No description provided for @just_stay_at_home_while_we_are_preparing_your_best_books.
  ///
  /// In en, this message translates to:
  /// **'Just stay at home while we are\npreparing your best books'**
  String get just_stay_at_home_while_we_are_preparing_your_best_books;

  /// No description provided for @kids.
  ///
  /// In en, this message translates to:
  /// **'Kids'**
  String get kids;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @last_name.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get last_name;

  /// No description provided for @leave_your_experience.
  ///
  /// In en, this message translates to:
  /// **'Leave your experience'**
  String get leave_your_experience;

  /// No description provided for @less.
  ///
  /// In en, this message translates to:
  /// **'less'**
  String get less;

  /// No description provided for @good_morning.
  ///
  /// In en, this message translates to:
  /// **'Good morning,'**
  String get good_morning;

  /// No description provided for @good_afternoon.
  ///
  /// In en, this message translates to:
  /// **'Good afternoon,'**
  String get good_afternoon;

  /// No description provided for @good_evening.
  ///
  /// In en, this message translates to:
  /// **'Good Evening,'**
  String get good_evening;

  /// No description provided for @lets_get_started.
  ///
  /// In en, this message translates to:
  /// **'Let\'s Get Started'**
  String get lets_get_started;

  /// No description provided for @lets_sign_you_in.
  ///
  /// In en, this message translates to:
  /// **'Let’s Sign You In.'**
  String get lets_sign_you_in;

  /// No description provided for @likes.
  ///
  /// In en, this message translates to:
  /// **'Likes'**
  String get likes;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @log_in.
  ///
  /// In en, this message translates to:
  /// **'Welcome back!'**
  String get log_in;

  /// No description provided for @log_in_button_clicked.
  ///
  /// In en, this message translates to:
  /// **'Log in button Clicked'**
  String get log_in_button_clicked;

  /// No description provided for @log_in_to_continue.
  ///
  /// In en, this message translates to:
  /// **'Log in to Continue'**
  String get log_in_to_continue;

  /// No description provided for @log_out.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get log_out;

  /// No description provided for @logging_in.
  ///
  /// In en, this message translates to:
  /// **'Logging in'**
  String get logging_in;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logout;

  /// No description provided for @looks_like_you_havent_added_any_item_to_your_cart_yet.
  ///
  /// In en, this message translates to:
  /// **'Looks like you havent added any item to your cart yet'**
  String get looks_like_you_havent_added_any_item_to_your_cart_yet;

  /// No description provided for @lowest_price_to_highest_price.
  ///
  /// In en, this message translates to:
  /// **'Lowest price to highest price'**
  String get lowest_price_to_highest_price;

  /// No description provided for @luxury.
  ///
  /// In en, this message translates to:
  /// **'Luxury'**
  String get luxury;

  /// No description provided for @make_a_payment.
  ///
  /// In en, this message translates to:
  /// **'Make a Payment'**
  String get make_a_payment;

  /// No description provided for @makeup.
  ///
  /// In en, this message translates to:
  /// **'Makeup'**
  String get makeup;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @man_bag.
  ///
  /// In en, this message translates to:
  /// **'Man Bag'**
  String get man_bag;

  /// No description provided for @man_pants.
  ///
  /// In en, this message translates to:
  /// **'Man Pants'**
  String get man_pants;

  /// No description provided for @man_shoes.
  ///
  /// In en, this message translates to:
  /// **'Man Shoes'**
  String get man_shoes;

  /// No description provided for @man_underwear.
  ///
  /// In en, this message translates to:
  /// **'Man Underwear'**
  String get man_underwear;

  /// No description provided for @manunderwear.
  ///
  /// In en, this message translates to:
  /// **'Man Underwear'**
  String get manunderwear;

  /// No description provided for @many_desktop_publishing_packages_and_web_page_editors_now_use.
  ///
  /// In en, this message translates to:
  /// **'Many desktop publishing packages and web page editors now use.'**
  String get many_desktop_publishing_packages_and_web_page_editors_now_use;

  /// No description provided for @material.
  ///
  /// In en, this message translates to:
  /// **'Material'**
  String get material;

  /// No description provided for @men.
  ///
  /// In en, this message translates to:
  /// **'Men'**
  String get men;

  /// No description provided for @message.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get message;

  /// No description provided for @min.
  ///
  /// In en, this message translates to:
  /// **'min'**
  String get min;

  /// No description provided for @misc.
  ///
  /// In en, this message translates to:
  /// **'Misc'**
  String get misc;

  /// No description provided for @mobile_number.
  ///
  /// In en, this message translates to:
  /// **'Mobile Number'**
  String get mobile_number;

  /// No description provided for @mom_and_baby.
  ///
  /// In en, this message translates to:
  /// **'Mom and Baby'**
  String get mom_and_baby;

  /// No description provided for @monday.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get monday;

  /// No description provided for @month.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get month;

  /// No description provided for @more.
  ///
  /// In en, this message translates to:
  /// **'more'**
  String get more;

  /// No description provided for @more_on_click.
  ///
  /// In en, this message translates to:
  /// **'more on click'**
  String get more_on_click;

  /// No description provided for @most_popular.
  ///
  /// In en, this message translates to:
  /// **'Most popular'**
  String get most_popular;

  /// No description provided for @my_coupon.
  ///
  /// In en, this message translates to:
  /// **'My coupon'**
  String get my_coupon;

  /// No description provided for @my_favorite.
  ///
  /// In en, this message translates to:
  /// **'My Favorite'**
  String get my_favorite;

  /// No description provided for @my_order.
  ///
  /// In en, this message translates to:
  /// **'My Order'**
  String get my_order;

  /// No description provided for @my_orders.
  ///
  /// In en, this message translates to:
  /// **'My orders'**
  String get my_orders;

  /// No description provided for @my_review.
  ///
  /// In en, this message translates to:
  /// **'My review'**
  String get my_review;

  /// No description provided for @my_saved_cards.
  ///
  /// In en, this message translates to:
  /// **'My Saved Cards'**
  String get my_saved_cards;

  /// No description provided for @my_shopping.
  ///
  /// In en, this message translates to:
  /// **'My shopping'**
  String get my_shopping;

  /// No description provided for @nails.
  ///
  /// In en, this message translates to:
  /// **'Nails'**
  String get nails;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @nearby.
  ///
  /// In en, this message translates to:
  /// **'Nearby'**
  String get nearby;

  /// No description provided for @nearest_barbershop.
  ///
  /// In en, this message translates to:
  /// **'Nearest barbershop'**
  String get nearest_barbershop;

  /// No description provided for @new_address.
  ///
  /// In en, this message translates to:
  /// **'New Address'**
  String get new_address;

  /// No description provided for @new_arrival.
  ///
  /// In en, this message translates to:
  /// **'New arrival'**
  String get new_arrival;

  /// No description provided for @new_buildings.
  ///
  /// In en, this message translates to:
  /// **'New Buildings'**
  String get new_buildings;

  /// No description provided for @new_card.
  ///
  /// In en, this message translates to:
  /// **'New Card'**
  String get new_card;

  /// No description provided for @new_password.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get new_password;

  /// No description provided for @new_product.
  ///
  /// In en, this message translates to:
  /// **'New product'**
  String get new_product;

  /// No description provided for @self_developement.
  ///
  /// In en, this message translates to:
  /// **'Self-development'**
  String get self_developement;

  /// No description provided for @biography.
  ///
  /// In en, this message translates to:
  /// **'Biography'**
  String get biography;

  /// No description provided for @culture.
  ///
  /// In en, this message translates to:
  /// **'Culture'**
  String get culture;

  /// No description provided for @mygroupes.
  ///
  /// In en, this message translates to:
  /// **'Ejaz Collections'**
  String get mygroupes;

  /// No description provided for @politics.
  ///
  /// In en, this message translates to:
  /// **'Politics'**
  String get politics;

  /// No description provided for @newest.
  ///
  /// In en, this message translates to:
  /// **'Newest'**
  String get newest;

  /// No description provided for @newly_listed.
  ///
  /// In en, this message translates to:
  /// **'Newly listed'**
  String get newly_listed;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @next_button_clicked.
  ///
  /// In en, this message translates to:
  /// **'Next button clicked'**
  String get next_button_clicked;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @no_name.
  ///
  /// In en, this message translates to:
  /// **'No name'**
  String get no_name;

  /// No description provided for @no_resi.
  ///
  /// In en, this message translates to:
  /// **'No. Resi'**
  String get no_resi;

  /// No description provided for @not_pay.
  ///
  /// In en, this message translates to:
  /// **'Not pay'**
  String get not_pay;

  /// No description provided for @not_yet_paid.
  ///
  /// In en, this message translates to:
  /// **'Not Yet Paid'**
  String get not_yet_paid;

  /// No description provided for @notification.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notification;

  /// No description provided for @notification_delete_clicked.
  ///
  /// In en, this message translates to:
  /// **'Notification delete clicked'**
  String get notification_delete_clicked;

  /// No description provided for @notification_deleted.
  ///
  /// In en, this message translates to:
  /// **'Notification deleted'**
  String get notification_deleted;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @offers.
  ///
  /// In en, this message translates to:
  /// **'Offers'**
  String get offers;

  /// No description provided for @office.
  ///
  /// In en, this message translates to:
  /// **'Office'**
  String get office;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @on_delivery.
  ///
  /// In en, this message translates to:
  /// **'On Delivery'**
  String get on_delivery;

  /// No description provided for @online_barber.
  ///
  /// In en, this message translates to:
  /// **'Online Barber'**
  String get online_barber;

  /// No description provided for @online_payment.
  ///
  /// In en, this message translates to:
  /// **'Online Payment'**
  String get online_payment;

  /// No description provided for @only_characters_are_allowed.
  ///
  /// In en, this message translates to:
  /// **'Only characters are allowed'**
  String get only_characters_are_allowed;

  /// No description provided for @open.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get open;

  /// No description provided for @open_camera_tapped.
  ///
  /// In en, this message translates to:
  /// **'Open camera tapped'**
  String get open_camera_tapped;

  /// No description provided for @open_email_app.
  ///
  /// In en, this message translates to:
  /// **'Open email app'**
  String get open_email_app;

  /// No description provided for @open_email_app_on_click.
  ///
  /// In en, this message translates to:
  /// **'Open email app on click'**
  String get open_email_app_on_click;

  /// No description provided for @open_gallery_tapped.
  ///
  /// In en, this message translates to:
  /// **'Open gallery tapped'**
  String get open_gallery_tapped;

  /// No description provided for @opening_hours.
  ///
  /// In en, this message translates to:
  /// **'Opening hours'**
  String get opening_hours;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get or;

  /// No description provided for @or_continue_with_email.
  ///
  /// In en, this message translates to:
  /// **'or continue with email'**
  String get or_continue_with_email;

  /// No description provided for @or_log_in_with.
  ///
  /// In en, this message translates to:
  /// **'or Log In With'**
  String get or_log_in_with;

  /// No description provided for @or_login_with.
  ///
  /// In en, this message translates to:
  /// **'or Login with'**
  String get or_login_with;

  /// No description provided for @or_login_with_email.
  ///
  /// In en, this message translates to:
  /// **'or Login with email'**
  String get or_login_with_email;

  /// No description provided for @order.
  ///
  /// In en, this message translates to:
  /// **'Order'**
  String get order;

  /// No description provided for @order_accepted.
  ///
  /// In en, this message translates to:
  /// **'Orders Accepted'**
  String get order_accepted;

  /// No description provided for @order_by_number.
  ///
  /// In en, this message translates to:
  /// **'Order by number'**
  String get order_by_number;

  /// No description provided for @order_detail.
  ///
  /// In en, this message translates to:
  /// **'Order detail'**
  String get order_detail;

  /// No description provided for @order_history.
  ///
  /// In en, this message translates to:
  /// **'Order history'**
  String get order_history;

  /// No description provided for @order_now.
  ///
  /// In en, this message translates to:
  /// **'Order Now'**
  String get order_now;

  /// No description provided for @order_number.
  ///
  /// In en, this message translates to:
  /// **'Order number'**
  String get order_number;

  /// No description provided for @order_other_book.
  ///
  /// In en, this message translates to:
  /// **'Order Other Book'**
  String get order_other_book;

  /// No description provided for @order_rejected.
  ///
  /// In en, this message translates to:
  /// **'Order rejected'**
  String get order_rejected;

  /// No description provided for @order_status.
  ///
  /// In en, this message translates to:
  /// **'Order Status'**
  String get order_status;

  /// No description provided for @order_tracking.
  ///
  /// In en, this message translates to:
  /// **'Order Tracking'**
  String get order_tracking;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @other_products.
  ///
  /// In en, this message translates to:
  /// **'Other products'**
  String get other_products;

  /// No description provided for @others_you_may_like.
  ///
  /// In en, this message translates to:
  /// **'Others You May Like'**
  String get others_you_may_like;

  /// No description provided for @ouch_hungry.
  ///
  /// In en, this message translates to:
  /// **'Ouch! Hungry'**
  String get ouch_hungry;

  /// No description provided for @our_app_lets_you_focus_on_finding_the_best_local_professionals_from_your_neighbourhood.
  ///
  /// In en, this message translates to:
  /// **'Our app lets you focus on finding the best local professionals from your neighbourhood. '**
  String
      get our_app_lets_you_focus_on_finding_the_best_local_professionals_from_your_neighbourhood;

  /// No description provided for @out_of.
  ///
  /// In en, this message translates to:
  /// **'Out of'**
  String get out_of;

  /// No description provided for @out_of_stock.
  ///
  /// In en, this message translates to:
  /// **'Out of stock'**
  String get out_of_stock;

  /// No description provided for @package_on_the_way.
  ///
  /// In en, this message translates to:
  /// **'Package on the way'**
  String get package_on_the_way;

  /// No description provided for @packages_are_being_packed.
  ///
  /// In en, this message translates to:
  /// **'Packages are being packed'**
  String get packages_are_being_packed;

  /// No description provided for @packaging.
  ///
  /// In en, this message translates to:
  /// **'Packaging'**
  String get packaging;

  /// No description provided for @packed.
  ///
  /// In en, this message translates to:
  /// **'Packed'**
  String get packed;

  /// No description provided for @packed_by_seller.
  ///
  /// In en, this message translates to:
  /// **'Packed by seller'**
  String get packed_by_seller;

  /// No description provided for @pages.
  ///
  /// In en, this message translates to:
  /// **'Pages'**
  String get pages;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @password_new.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get password_new;

  /// No description provided for @password_changed.
  ///
  /// In en, this message translates to:
  /// **'Password changed'**
  String get password_changed;

  /// No description provided for @password_confirmation.
  ///
  /// In en, this message translates to:
  /// **'Confirm New Password'**
  String get password_confirmation;

  /// No description provided for @enter_password_confirmation.
  ///
  /// In en, this message translates to:
  /// **'Enter new password'**
  String get enter_password_confirmation;

  /// No description provided for @password_reset_request_was_sent_successfully_please_check_your_email_to_reset_your_password.
  ///
  /// In en, this message translates to:
  /// **'Password reset request was sent successfully. Please check your email to reset your password'**
  String
      get password_reset_request_was_sent_successfully_please_check_your_email_to_reset_your_password;

  /// No description provided for @password_successfully_reset.
  ///
  /// In en, this message translates to:
  /// **'Password Successfully Reset'**
  String get password_successfully_reset;

  /// No description provided for @past_orders.
  ///
  /// In en, this message translates to:
  /// **'Past Orders'**
  String get past_orders;

  /// No description provided for @pay.
  ///
  /// In en, this message translates to:
  /// **'Pay'**
  String get pay;

  /// No description provided for @pay_by_card.
  ///
  /// In en, this message translates to:
  /// **'Pay by Card'**
  String get pay_by_card;

  /// No description provided for @pay_for_the_products_you_buy_safely_and_easily.
  ///
  /// In en, this message translates to:
  /// **'Pay for the products you buy safely and easily'**
  String get pay_for_the_products_you_buy_safely_and_easily;

  /// No description provided for @pay_for_the_products_you_buy_safely_and_easly.
  ///
  /// In en, this message translates to:
  /// **'Pay for the products! You buy safely and easly'**
  String get pay_for_the_products_you_buy_safely_and_easly;

  /// No description provided for @pay_now.
  ///
  /// In en, this message translates to:
  /// **'Pay Now'**
  String get pay_now;

  /// No description provided for @payment.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get payment;

  /// No description provided for @payment_amount.
  ///
  /// In en, this message translates to:
  /// **'Payment amount'**
  String get payment_amount;

  /// No description provided for @payment_details.
  ///
  /// In en, this message translates to:
  /// **'Payment details'**
  String get payment_details;

  /// No description provided for @payment_information.
  ///
  /// In en, this message translates to:
  /// **'Payment information'**
  String get payment_information;

  /// No description provided for @payment_is_being_verified.
  ///
  /// In en, this message translates to:
  /// **'Payment is being verified'**
  String get payment_is_being_verified;

  /// No description provided for @payment_is_successful_please_wait_until_your_order_arrives_at_home_thank_you_for_shopping.
  ///
  /// In en, this message translates to:
  /// **'Payment is successful please wait until your order arrives at home thank you for shopping'**
  String
      get payment_is_successful_please_wait_until_your_order_arrives_at_home_thank_you_for_shopping;

  /// No description provided for @payment_method.
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get payment_method;

  /// No description provided for @payment_method_has_been_set.
  ///
  /// In en, this message translates to:
  /// **'Payment method has been set'**
  String get payment_method_has_been_set;

  /// No description provided for @payment_method_not_selected.
  ///
  /// In en, this message translates to:
  /// **'Payment method not selected'**
  String get payment_method_not_selected;

  /// No description provided for @payment_method_successfully_applied.
  ///
  /// In en, this message translates to:
  /// **'Payment method successfully applied'**
  String get payment_method_successfully_applied;

  /// No description provided for @payment_methods.
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get payment_methods;

  /// No description provided for @payment_processed.
  ///
  /// In en, this message translates to:
  /// **'Payment processed'**
  String get payment_processed;

  /// No description provided for @payment_status.
  ///
  /// In en, this message translates to:
  /// **'Payment status'**
  String get payment_status;

  /// No description provided for @paypal.
  ///
  /// In en, this message translates to:
  /// **'Paypal'**
  String get paypal;

  /// No description provided for @paypal_account.
  ///
  /// In en, this message translates to:
  /// **'Paypal account'**
  String get paypal_account;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @personal.
  ///
  /// In en, this message translates to:
  /// **'Personal'**
  String get personal;

  /// No description provided for @phone_number.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phone_number;

  /// No description provided for @photos.
  ///
  /// In en, this message translates to:
  /// **'Photos'**
  String get photos;

  /// No description provided for @place_my_order.
  ///
  /// In en, this message translates to:
  /// **'Place My Order'**
  String get place_my_order;

  /// No description provided for @plan_a_trip.
  ///
  /// In en, this message translates to:
  /// **'Plan a Trip'**
  String get plan_a_trip;

  /// No description provided for @play.
  ///
  /// In en, this message translates to:
  /// **'Play'**
  String get play;

  /// No description provided for @please_Enter_your_eMail_Address_Your_will_Receive_a_link_to_Create_a_new_Password_via_email.
  ///
  /// In en, this message translates to:
  /// **'Please Enter your eMail Address. You will Receive a link to Create a new Password via email.'**
  String
      get please_Enter_your_eMail_Address_Your_will_Receive_a_link_to_Create_a_new_Password_via_email;

  /// No description provided for @please_enter_a_value.
  ///
  /// In en, this message translates to:
  /// **'Please enter a value'**
  String get please_enter_a_value;

  /// No description provided for @please_enter_the_4_digit_code_sent_to.
  ///
  /// In en, this message translates to:
  /// **'Please enter the 4 digit code sent to'**
  String get please_enter_the_4_digit_code_sent_to;

  /// No description provided for @please_enter_the_email_address_you_used_at_the_time_of_registration_to_get_the_password_reset_instructions.
  ///
  /// In en, this message translates to:
  /// **'Please enter the email address you used at the time of registration to get the password reset instructions'**
  String
      get please_enter_the_email_address_you_used_at_the_time_of_registration_to_get_the_password_reset_instructions;

  /// No description provided for @please_enter_your_data_to_create_account.
  ///
  /// In en, this message translates to:
  /// **'Please enter your data to create account'**
  String get please_enter_your_data_to_create_account;

  /// No description provided for @please_enter_your_email_address.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email address'**
  String get please_enter_your_email_address;

  /// No description provided for @please_enter_your_email_address_to_add_a_PayPal_account_as_a_payment_method.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email address to add a Paypal account as a payment method'**
  String
      get please_enter_your_email_address_to_add_a_PayPal_account_as_a_payment_method;

  /// No description provided for @please_enter_your_email_address_to_receive_a_verification_code.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email address to receive a verification code.'**
  String get please_enter_your_email_address_to_receive_a_verification_code;

  /// No description provided for @please_enter_your_full_address_correctly.
  ///
  /// In en, this message translates to:
  /// **'Please enter your full address correctly'**
  String get please_enter_your_full_address_correctly;

  /// No description provided for @please_enter_your_password.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get please_enter_your_password;

  /// No description provided for @please_enter_your_phone_number.
  ///
  /// In en, this message translates to:
  /// **'Please enter your phone number'**
  String get please_enter_your_phone_number;

  /// No description provided for @please_fill_in_the_confirm_password.
  ///
  /// In en, this message translates to:
  /// **'Enter confirm password'**
  String get please_fill_in_the_confirm_password;

  /// No description provided for @please_fill_in_the_current_password.
  ///
  /// In en, this message translates to:
  /// **'Enter current password'**
  String get please_fill_in_the_current_password;

  /// No description provided for @please_fill_in_the_new_password.
  ///
  /// In en, this message translates to:
  /// **'Please fill in the new password'**
  String get please_fill_in_the_new_password;

  /// No description provided for @please_fill_in_the_recipients_name_and_contact_number.
  ///
  /// In en, this message translates to:
  /// **'Please fill in the recipient\'s name and contact number'**
  String get please_fill_in_the_recipients_name_and_contact_number;

  /// No description provided for @please_fill_your_account.
  ///
  /// In en, this message translates to:
  /// **'Please fill your account'**
  String get please_fill_your_account;

  /// No description provided for @please_leave_a_message.
  ///
  /// In en, this message translates to:
  /// **'Please leave a message'**
  String get please_leave_a_message;

  /// No description provided for @please_select_appointment_date.
  ///
  /// In en, this message translates to:
  /// **'Please select appointment date'**
  String get please_select_appointment_date;

  /// No description provided for @please_select_your_payment_method.
  ///
  /// In en, this message translates to:
  /// **'Please select your payment method'**
  String get please_select_your_payment_method;

  /// No description provided for @please_wait.
  ///
  /// In en, this message translates to:
  /// **'Please wait'**
  String get please_wait;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @novel.
  ///
  /// In en, this message translates to:
  /// **'Novels'**
  String get novel;

  /// No description provided for @health.
  ///
  /// In en, this message translates to:
  /// **'Health'**
  String get health;

  /// No description provided for @business.
  ///
  /// In en, this message translates to:
  /// **'Business'**
  String get business;

  /// No description provided for @science.
  ///
  /// In en, this message translates to:
  /// **'Science'**
  String get science;

  /// No description provided for @popular_discussions.
  ///
  /// In en, this message translates to:
  /// **'Popular Discussions'**
  String get popular_discussions;

  /// No description provided for @popularity.
  ///
  /// In en, this message translates to:
  /// **'Popularity'**
  String get popularity;

  /// No description provided for @portfolio.
  ///
  /// In en, this message translates to:
  /// **'Portfolio'**
  String get portfolio;

  /// No description provided for @press_again_to_exit.
  ///
  /// In en, this message translates to:
  /// **'Press again to Exit'**
  String get press_again_to_exit;

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get price;

  /// No description provided for @price_range.
  ///
  /// In en, this message translates to:
  /// **'Price Range'**
  String get price_range;

  /// No description provided for @price_total.
  ///
  /// In en, this message translates to:
  /// **'Price total'**
  String get price_total;

  /// No description provided for @primary_address.
  ///
  /// In en, this message translates to:
  /// **'Primary address'**
  String get primary_address;

  /// No description provided for @primary_address_has_been_set.
  ///
  /// In en, this message translates to:
  /// **'Primary address has been set'**
  String get primary_address_has_been_set;

  /// No description provided for @privacy_policy.
  ///
  /// In en, this message translates to:
  /// **' Privacy Policy'**
  String get privacy_policy;

  /// No description provided for @process.
  ///
  /// In en, this message translates to:
  /// **'Process'**
  String get process;

  /// No description provided for @processing.
  ///
  /// In en, this message translates to:
  /// **'Processing'**
  String get processing;

  /// No description provided for @product.
  ///
  /// In en, this message translates to:
  /// **'Product'**
  String get product;

  /// No description provided for @product_description.
  ///
  /// In en, this message translates to:
  /// **'Product description'**
  String get product_description;

  /// No description provided for @product_information.
  ///
  /// In en, this message translates to:
  /// **'Product information'**
  String get product_information;

  /// No description provided for @product_is_removed.
  ///
  /// In en, this message translates to:
  /// **'Product is removed'**
  String get product_is_removed;

  /// No description provided for @product_not_available.
  ///
  /// In en, this message translates to:
  /// **'Product not available'**
  String get product_not_available;

  /// No description provided for @product_not_found.
  ///
  /// In en, this message translates to:
  /// **'Product not found'**
  String get product_not_found;

  /// No description provided for @product_ordered.
  ///
  /// In en, this message translates to:
  /// **'Product ordered'**
  String get product_ordered;

  /// No description provided for @product_removed.
  ///
  /// In en, this message translates to:
  /// **'Product removed'**
  String get product_removed;

  /// No description provided for @product_review.
  ///
  /// In en, this message translates to:
  /// **'Product review'**
  String get product_review;

  /// No description provided for @products_found.
  ///
  /// In en, this message translates to:
  /// **'Products found'**
  String get products_found;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @profile_updated.
  ///
  /// In en, this message translates to:
  /// **'Profile updated'**
  String get profile_updated;

  /// No description provided for @promo.
  ///
  /// In en, this message translates to:
  /// **'Promo'**
  String get promo;

  /// No description provided for @promo_code.
  ///
  /// In en, this message translates to:
  /// **'Promo Code'**
  String get promo_code;

  /// No description provided for @property_price.
  ///
  /// In en, this message translates to:
  /// **'Property Price'**
  String get property_price;

  /// No description provided for @property_size.
  ///
  /// In en, this message translates to:
  /// **'Property Size'**
  String get property_size;

  /// No description provided for @property_type.
  ///
  /// In en, this message translates to:
  /// **'Property Type'**
  String get property_type;

  /// No description provided for @province.
  ///
  /// In en, this message translates to:
  /// **'Province'**
  String get province;

  /// No description provided for @purchase_date.
  ///
  /// In en, this message translates to:
  /// **'Purchase date'**
  String get purchase_date;

  /// No description provided for @purchase_this_app.
  ///
  /// In en, this message translates to:
  /// **'Purchase this app'**
  String get purchase_this_app;

  /// No description provided for @qty.
  ///
  /// In en, this message translates to:
  /// **'Qty'**
  String get qty;

  /// No description provided for @rate.
  ///
  /// In en, this message translates to:
  /// **'Rate'**
  String get rate;

  /// No description provided for @rate_the_app.
  ///
  /// In en, this message translates to:
  /// **'Rate the app'**
  String get rate_the_app;

  /// No description provided for @rate_the_product.
  ///
  /// In en, this message translates to:
  /// **'Rate the product'**
  String get rate_the_product;

  /// No description provided for @rated.
  ///
  /// In en, this message translates to:
  /// **'Rated'**
  String get rated;

  /// No description provided for @rating.
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get rating;

  /// No description provided for @read_more.
  ///
  /// In en, this message translates to:
  /// **'Read more'**
  String get read_more;

  /// No description provided for @recent_chats.
  ///
  /// In en, this message translates to:
  /// **'Recent chats'**
  String get recent_chats;

  /// No description provided for @recent_transaction.
  ///
  /// In en, this message translates to:
  /// **'Recent Transaction'**
  String get recent_transaction;

  /// No description provided for @recommended.
  ///
  /// In en, this message translates to:
  /// **'Browse by Genre'**
  String get recommended;

  /// No description provided for @refund_successful.
  ///
  /// In en, this message translates to:
  /// **'Refund successful'**
  String get refund_successful;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Sign up!'**
  String get register;

  /// No description provided for @registered_as.
  ///
  /// In en, this message translates to:
  /// **'Registered as'**
  String get registered_as;

  /// No description provided for @related.
  ///
  /// In en, this message translates to:
  /// **'Related'**
  String get related;

  /// No description provided for @relax_look_great_feel_confident.
  ///
  /// In en, this message translates to:
  /// **'Relax look great feel confident'**
  String get relax_look_great_feel_confident;

  /// No description provided for @reliable_and_fast_delivery.
  ///
  /// In en, this message translates to:
  /// **'Reliable and Fast Delivery'**
  String get reliable_and_fast_delivery;

  /// No description provided for @remember_me.
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get remember_me;

  /// No description provided for @remember_password.
  ///
  /// In en, this message translates to:
  /// **'Remember password'**
  String get remember_password;

  /// No description provided for @reminder_settings.
  ///
  /// In en, this message translates to:
  /// **'Reminder settings'**
  String get reminder_settings;

  /// No description provided for @remove_from_bookmark.
  ///
  /// In en, this message translates to:
  /// **'Remove from Bookmark'**
  String get remove_from_bookmark;

  /// No description provided for @remove_from_favorite.
  ///
  /// In en, this message translates to:
  /// **'Remove from Favorite'**
  String get remove_from_favorite;

  /// No description provided for @remove_from_inbox.
  ///
  /// In en, this message translates to:
  /// **'Remove from Inbox'**
  String get remove_from_inbox;

  /// No description provided for @rent_history.
  ///
  /// In en, this message translates to:
  /// **'Rent History'**
  String get rent_history;

  /// No description provided for @repayment.
  ///
  /// In en, this message translates to:
  /// **'Repayment'**
  String get repayment;

  /// No description provided for @report.
  ///
  /// In en, this message translates to:
  /// **'Report'**
  String get report;

  /// No description provided for @report_on_click.
  ///
  /// In en, this message translates to:
  /// **'Report on click'**
  String get report_on_click;

  /// No description provided for @resend_a_new_code.
  ///
  /// In en, this message translates to:
  /// **'Resend code'**
  String get resend_a_new_code;

  /// No description provided for @resend_a_new_code_on_click.
  ///
  /// In en, this message translates to:
  /// **'Resend a new code on click'**
  String get resend_a_new_code_on_click;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get reset;

  /// No description provided for @reset_password.
  ///
  /// In en, this message translates to:
  /// **'Reset password'**
  String get reset_password;

  /// No description provided for @review.
  ///
  /// In en, this message translates to:
  /// **'Review'**
  String get review;

  /// No description provided for @review_sent.
  ///
  /// In en, this message translates to:
  /// **'Review sent'**
  String get review_sent;

  /// No description provided for @reviews.
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get reviews;

  /// No description provided for @rooms.
  ///
  /// In en, this message translates to:
  /// **'Rooms'**
  String get rooms;

  /// No description provided for @sandal.
  ///
  /// In en, this message translates to:
  /// **'Sandal'**
  String get sandal;

  /// No description provided for @saturday.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get saturday;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @saved.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get saved;

  /// No description provided for @saved_address.
  ///
  /// In en, this message translates to:
  /// **'Saved Address'**
  String get saved_address;

  /// No description provided for @saved_cards.
  ///
  /// In en, this message translates to:
  /// **'Saved Cards'**
  String get saved_cards;

  /// No description provided for @saving.
  ///
  /// In en, this message translates to:
  /// **'Saving'**
  String get saving;

  /// No description provided for @score.
  ///
  /// In en, this message translates to:
  /// **'Score'**
  String get score;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search here'**
  String get search;

  /// No description provided for @search_anything_you_like.
  ///
  /// In en, this message translates to:
  /// **'Search anything you like'**
  String get search_anything_you_like;

  /// No description provided for @search_everything_you_like.
  ///
  /// In en, this message translates to:
  /// **'Search everything you like'**
  String get search_everything_you_like;

  /// No description provided for @search_for_barbershop_name.
  ///
  /// In en, this message translates to:
  /// **'Search for barbershop name'**
  String get search_for_barbershop_name;

  /// No description provided for @search_message.
  ///
  /// In en, this message translates to:
  /// **'Search message'**
  String get search_message;

  /// No description provided for @search_your_favorite_book.
  ///
  /// In en, this message translates to:
  /// **'Search by title or author'**
  String get search_your_favorite_book;

  /// No description provided for @search_your_product.
  ///
  /// In en, this message translates to:
  /// **'Search your product'**
  String get search_your_product;

  /// No description provided for @search_your_property.
  ///
  /// In en, this message translates to:
  /// **'Search your property...'**
  String get search_your_property;

  /// No description provided for @second_hand.
  ///
  /// In en, this message translates to:
  /// **'Second hand'**
  String get second_hand;

  /// No description provided for @seconds.
  ///
  /// In en, this message translates to:
  /// **'seconds'**
  String get seconds;

  /// No description provided for @security.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get security;

  /// No description provided for @see_all.
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get see_all;

  /// No description provided for @see_all_review_clicked.
  ///
  /// In en, this message translates to:
  /// **'See all review clicked'**
  String get see_all_review_clicked;

  /// No description provided for @see_my_orders.
  ///
  /// In en, this message translates to:
  /// **'See my orders'**
  String get see_my_orders;

  /// No description provided for @seems_like_you_have_not_have_a_favorite_book_yet.
  ///
  /// In en, this message translates to:
  /// **'You haven’t saved any favorites yet!'**
  String get seems_like_you_have_not_have_a_favorite_book_yet;

  /// No description provided for @seems_like_you_have_not_have_a_past_order_yet.
  ///
  /// In en, this message translates to:
  /// **'Seems like you have not have a past order yet'**
  String get seems_like_you_have_not_have_a_past_order_yet;

  /// No description provided for @seems_like_you_have_not_have_an_in_progress_order_yet.
  ///
  /// In en, this message translates to:
  /// **'Seems like you have not have an in progress order yet'**
  String get seems_like_you_have_not_have_an_in_progress_order_yet;

  /// No description provided for @seems_like_you_have_not_have_an_order_book_yet.
  ///
  /// In en, this message translates to:
  /// **'Seems like you have not have an order yet'**
  String get seems_like_you_have_not_have_an_order_book_yet;

  /// No description provided for @select_as_primary_address.
  ///
  /// In en, this message translates to:
  /// **'Select as primary address'**
  String get select_as_primary_address;

  /// No description provided for @select_as_primary_address_on_click.
  ///
  /// In en, this message translates to:
  /// **'Select as primary address on click'**
  String get select_as_primary_address_on_click;

  /// No description provided for @select_brand.
  ///
  /// In en, this message translates to:
  /// **'Select brand'**
  String get select_brand;

  /// No description provided for @select_date.
  ///
  /// In en, this message translates to:
  /// **'Select date'**
  String get select_date;

  /// No description provided for @select_different_products_the_freedom_is_yours.
  ///
  /// In en, this message translates to:
  /// **'Select different products! The freedom is yours!'**
  String get select_different_products_the_freedom_is_yours;

  /// No description provided for @select_location.
  ///
  /// In en, this message translates to:
  /// **'Select location'**
  String get select_location;

  /// No description provided for @select_schedule.
  ///
  /// In en, this message translates to:
  /// **'Select schedule'**
  String get select_schedule;

  /// No description provided for @select_your_birthday.
  ///
  /// In en, this message translates to:
  /// **'Select your birthday'**
  String get select_your_birthday;

  /// No description provided for @select_your_payment.
  ///
  /// In en, this message translates to:
  /// **'Select Your Payment Method'**
  String get select_your_payment;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @send_a_message.
  ///
  /// In en, this message translates to:
  /// **'Send a message'**
  String get send_a_message;

  /// No description provided for @send_a_message_on_click.
  ///
  /// In en, this message translates to:
  /// **'Send a message on click'**
  String get send_a_message_on_click;

  /// No description provided for @send_the_code_again.
  ///
  /// In en, this message translates to:
  /// **'Send the code again'**
  String get send_the_code_again;

  /// No description provided for @send_verification.
  ///
  /// In en, this message translates to:
  /// **'Verification'**
  String get send_verification;

  /// No description provided for @sending.
  ///
  /// In en, this message translates to:
  /// **'Sending'**
  String get sending;

  /// No description provided for @sent.
  ///
  /// In en, this message translates to:
  /// **'Sent'**
  String get sent;

  /// No description provided for @service.
  ///
  /// In en, this message translates to:
  /// **'Service'**
  String get service;

  /// No description provided for @service_location.
  ///
  /// In en, this message translates to:
  /// **'Service location'**
  String get service_location;

  /// No description provided for @service_on_days.
  ///
  /// In en, this message translates to:
  /// **'Service on days'**
  String get service_on_days;

  /// No description provided for @services.
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get services;

  /// No description provided for @services_charge.
  ///
  /// In en, this message translates to:
  /// **'Services Charge'**
  String get services_charge;

  /// No description provided for @set_your_password.
  ///
  /// In en, this message translates to:
  /// **'Set Your Password?'**
  String get set_your_password;

  /// No description provided for @setting.
  ///
  /// In en, this message translates to:
  /// **'Setting'**
  String get setting;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @shampoo.
  ///
  /// In en, this message translates to:
  /// **'Shampoo'**
  String get shampoo;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @shaving.
  ///
  /// In en, this message translates to:
  /// **'Shaving'**
  String get shaving;

  /// No description provided for @shipping.
  ///
  /// In en, this message translates to:
  /// **'Shipping'**
  String get shipping;

  /// No description provided for @shipping_address.
  ///
  /// In en, this message translates to:
  /// **'Shipping Address'**
  String get shipping_address;

  /// No description provided for @shipping_code.
  ///
  /// In en, this message translates to:
  /// **'Shipping code'**
  String get shipping_code;

  /// No description provided for @shipping_cost.
  ///
  /// In en, this message translates to:
  /// **'Shipping Cost'**
  String get shipping_cost;

  /// No description provided for @shipping_costs.
  ///
  /// In en, this message translates to:
  /// **'Shipping costs'**
  String get shipping_costs;

  /// No description provided for @shipping_date.
  ///
  /// In en, this message translates to:
  /// **'Shipping Date'**
  String get shipping_date;

  /// No description provided for @shipping_details.
  ///
  /// In en, this message translates to:
  /// **'Shipping details'**
  String get shipping_details;

  /// No description provided for @shipping_fee.
  ///
  /// In en, this message translates to:
  /// **'Shipping Fee'**
  String get shipping_fee;

  /// No description provided for @shipping_id.
  ///
  /// In en, this message translates to:
  /// **'Shipping ID'**
  String get shipping_id;

  /// No description provided for @shipping_service.
  ///
  /// In en, this message translates to:
  /// **'Shipping service'**
  String get shipping_service;

  /// No description provided for @shipping_type.
  ///
  /// In en, this message translates to:
  /// **'Shipping Type'**
  String get shipping_type;

  /// No description provided for @shirt.
  ///
  /// In en, this message translates to:
  /// **'Shirt'**
  String get shirt;

  /// No description provided for @shoes.
  ///
  /// In en, this message translates to:
  /// **'Shoes'**
  String get shoes;

  /// No description provided for @shop.
  ///
  /// In en, this message translates to:
  /// **'Shop'**
  String get shop;

  /// No description provided for @shop_again.
  ///
  /// In en, this message translates to:
  /// **'Shop again'**
  String get shop_again;

  /// No description provided for @shop_details.
  ///
  /// In en, this message translates to:
  /// **'Shop details'**
  String get shop_details;

  /// No description provided for @shop_now.
  ///
  /// In en, this message translates to:
  /// **'Shop Now'**
  String get shop_now;

  /// No description provided for @shopping_again.
  ///
  /// In en, this message translates to:
  /// **'Shopping again'**
  String get shopping_again;

  /// No description provided for @shopping_bag_is_empty.
  ///
  /// In en, this message translates to:
  /// **'Shopping bag is empty'**
  String get shopping_bag_is_empty;

  /// No description provided for @shopping_cart.
  ///
  /// In en, this message translates to:
  /// **'Shopping cart'**
  String get shopping_cart;

  /// No description provided for @shopping_cart_is_empty.
  ///
  /// In en, this message translates to:
  /// **'Shopping cart is empty'**
  String get shopping_cart_is_empty;

  /// No description provided for @shopping_date.
  ///
  /// In en, this message translates to:
  /// **'Shopping date'**
  String get shopping_date;

  /// No description provided for @show.
  ///
  /// In en, this message translates to:
  /// **'Show'**
  String get show;

  /// No description provided for @show_less.
  ///
  /// In en, this message translates to:
  /// **'Show less'**
  String get show_less;

  /// No description provided for @show_more.
  ///
  /// In en, this message translates to:
  /// **'Show more'**
  String get show_more;

  /// No description provided for @sign_in.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get sign_in;

  /// No description provided for @sign_in_to_continue.
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue'**
  String get sign_in_to_continue;

  /// No description provided for @sign_in_with.
  ///
  /// In en, this message translates to:
  /// **'Sign in with'**
  String get sign_in_with;

  /// No description provided for @sign_in_with_email.
  ///
  /// In en, this message translates to:
  /// **'Sign in with email'**
  String get sign_in_with_email;

  /// No description provided for @sign_in_with_google.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Google'**
  String get sign_in_with_google;

  /// No description provided for @sign_in_with_social_networks.
  ///
  /// In en, this message translates to:
  /// **'Sign in with social networks'**
  String get sign_in_with_social_networks;

  /// No description provided for @sign_up.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get sign_up;

  /// No description provided for @sign_up_to_continue.
  ///
  /// In en, this message translates to:
  /// **'Sign up to continue'**
  String get sign_up_to_continue;

  /// No description provided for @signing.
  ///
  /// In en, this message translates to:
  /// **'Signing'**
  String get signing;

  /// No description provided for @similiar_product.
  ///
  /// In en, this message translates to:
  /// **'Similar Product'**
  String get similiar_product;

  /// No description provided for @singlet.
  ///
  /// In en, this message translates to:
  /// **'Singlet'**
  String get singlet;

  /// No description provided for @size.
  ///
  /// In en, this message translates to:
  /// **'Size'**
  String get size;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @skip_I_ll_confirm_later.
  ///
  /// In en, this message translates to:
  /// **'Skip, I will confirm later'**
  String get skip_I_ll_confirm_later;

  /// No description provided for @skip_button_clicked.
  ///
  /// In en, this message translates to:
  /// **'Skip button clicked'**
  String get skip_button_clicked;

  /// No description provided for @skirt.
  ///
  /// In en, this message translates to:
  /// **'Skirt'**
  String get skirt;

  /// No description provided for @sneaker.
  ///
  /// In en, this message translates to:
  /// **'Sneaker'**
  String get sneaker;

  /// No description provided for @social_network.
  ///
  /// In en, this message translates to:
  /// **'Social network'**
  String get social_network;

  /// No description provided for @socks.
  ///
  /// In en, this message translates to:
  /// **'Socks'**
  String get socks;

  /// No description provided for @sold.
  ///
  /// In en, this message translates to:
  /// **'Sold'**
  String get sold;

  /// No description provided for @sort.
  ///
  /// In en, this message translates to:
  /// **'Sort'**
  String get sort;

  /// No description provided for @sort_by.
  ///
  /// In en, this message translates to:
  /// **'Sort by'**
  String get sort_by;

  /// No description provided for @spa.
  ///
  /// In en, this message translates to:
  /// **'Spa'**
  String get spa;

  /// No description provided for @special_for_you.
  ///
  /// In en, this message translates to:
  /// **'Special for you'**
  String get special_for_you;

  /// No description provided for @star.
  ///
  /// In en, this message translates to:
  /// **'Star'**
  String get star;

  /// No description provided for @start_from.
  ///
  /// In en, this message translates to:
  /// **'Start from'**
  String get start_from;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @stock.
  ///
  /// In en, this message translates to:
  /// **'Stock'**
  String get stock;

  /// No description provided for @style_that_fit_your_lifestyle.
  ///
  /// In en, this message translates to:
  /// **'Style that fit your Lifestyle'**
  String get style_that_fit_your_lifestyle;

  /// No description provided for @sub_total.
  ///
  /// In en, this message translates to:
  /// **'Sub Total'**
  String get sub_total;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @successfully.
  ///
  /// In en, this message translates to:
  /// **'Successfully'**
  String get successfully;

  /// No description provided for @successfully_added_to_cart.
  ///
  /// In en, this message translates to:
  /// **'Successfully added to Cart'**
  String get successfully_added_to_cart;

  /// No description provided for @successfully_added_to_favorite.
  ///
  /// In en, this message translates to:
  /// **'Successfully Added to Favorites'**
  String get successfully_added_to_favorite;

  /// No description provided for @successfully_changed_profile.
  ///
  /// In en, this message translates to:
  /// **'Successfully updated profile'**
  String get successfully_changed_profile;

  /// No description provided for @successfully_confirmed_please_wait_for_the_package_to_be_delivered.
  ///
  /// In en, this message translates to:
  /// **'Successfully confirmed. Please wait for the package to be delivered'**
  String get successfully_confirmed_please_wait_for_the_package_to_be_delivered;

  /// No description provided for @successfully_remove_from_favorite.
  ///
  /// In en, this message translates to:
  /// **'Successfully Removed from Favorites'**
  String get successfully_remove_from_favorite;

  /// No description provided for @suit.
  ///
  /// In en, this message translates to:
  /// **'Suit'**
  String get suit;

  /// No description provided for @summaries.
  ///
  /// In en, this message translates to:
  /// **'Books'**
  String get summaries;

  /// No description provided for @summary.
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get summary;

  /// No description provided for @sunday.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get sunday;

  /// No description provided for @super_fast_delivery_right_at_your_door.
  ///
  /// In en, this message translates to:
  /// **'Super fast delivery! Right at your door'**
  String get super_fast_delivery_right_at_your_door;

  /// No description provided for @support.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get support;

  /// No description provided for @t_shirt.
  ///
  /// In en, this message translates to:
  /// **'T-Shirt'**
  String get t_shirt;

  /// No description provided for @tags.
  ///
  /// In en, this message translates to:
  /// **'Tags'**
  String get tags;

  /// No description provided for @tax.
  ///
  /// In en, this message translates to:
  /// **'Tax'**
  String get tax;

  /// No description provided for @terms.
  ///
  /// In en, this message translates to:
  /// **'Terms'**
  String get terms;

  /// No description provided for @terms_and_condition.
  ///
  /// In en, this message translates to:
  /// **'Terms and condition'**
  String get terms_and_condition;

  /// No description provided for @terms_and_conditions.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get terms_and_conditions;

  /// No description provided for @terms_and_conditions_clicked.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions clicked!'**
  String get terms_and_conditions_clicked;

  /// No description provided for @terms_clicked.
  ///
  /// In en, this message translates to:
  /// **'Terms clicked'**
  String get terms_clicked;

  /// No description provided for @thank_you.
  ///
  /// In en, this message translates to:
  /// **'Thank You'**
  String get thank_you;

  /// No description provided for @thank_you_for_shopping_give_an_assessment_to_help_us_keep_growing_and_getting_better.
  ///
  /// In en, this message translates to:
  /// **'Thank you for shopping give an assessment to help us keep growing and getting better'**
  String
      get thank_you_for_shopping_give_an_assessment_to_help_us_keep_growing_and_getting_better;

  /// No description provided for @thank_you_for_shopping_we_will_confirm_your_payment_and_process_your_order_as_quickly_as_possible.
  ///
  /// In en, this message translates to:
  /// **'Thank you for shopping. We will confirm your payment and process your order as quickly as possible.'**
  String
      get thank_you_for_shopping_we_will_confirm_your_payment_and_process_your_order_as_quickly_as_possible;

  /// No description provided for @thank_you_hope_you_like_our_book.
  ///
  /// In en, this message translates to:
  /// **'Thank you! hope you like our book'**
  String get thank_you_hope_you_like_our_book;

  /// No description provided for @thank_you_your_order_will_be_delivered_soon.
  ///
  /// In en, this message translates to:
  /// **'Thank you! Your order will be delivered soon'**
  String get thank_you_your_order_will_be_delivered_soon;

  /// No description provided for @the_order_can_be_paid_by_credit_card_or_in_cash_at_the_time_of_delivery.
  ///
  /// In en, this message translates to:
  /// **'The order can be paid by credit card or in cash at the time of delivery'**
  String
      get the_order_can_be_paid_by_credit_card_or_in_cash_at_the_time_of_delivery;

  /// No description provided for @the_order_has_arrived_at_your_house.
  ///
  /// In en, this message translates to:
  /// **'The order has arrived at your house?'**
  String get the_order_has_arrived_at_your_house;

  /// No description provided for @the_order_will_be_confirmed_and_your_payment_will_be_received.
  ///
  /// In en, this message translates to:
  /// **'The order will be confirmed and your payment will be received.'**
  String get the_order_will_be_confirmed_and_your_payment_will_be_received;

  /// No description provided for @the_package_has_arrived.
  ///
  /// In en, this message translates to:
  /// **'The package has arrived'**
  String get the_package_has_arrived;

  /// No description provided for @the_package_has_arrived_at_your_house_immediately_confirm_your_order.
  ///
  /// In en, this message translates to:
  /// **'The package has arrived at your house immediately confirm your order'**
  String
      get the_package_has_arrived_at_your_house_immediately_confirm_your_order;

  /// No description provided for @the_package_is_being_packed_by_the_seller_please_wait_until_the_seller_sends_your_package.
  ///
  /// In en, this message translates to:
  /// **'The package is being packed by the seller, please wait until the seller sends your package'**
  String
      get the_package_is_being_packed_by_the_seller_please_wait_until_the_seller_sends_your_package;

  /// No description provided for @the_package_is_on_its_way_please_wait_until_your_package_arrives_at_your_home.
  ///
  /// In en, this message translates to:
  /// **'The package is on its way please wait until your package arrives at your home'**
  String
      get the_package_is_on_its_way_please_wait_until_your_package_arrives_at_your_home;

  /// No description provided for @there_are_1000_furniture_products_that_you_can_choose_at_will.
  ///
  /// In en, this message translates to:
  /// **'There are 1000+ furniture products that you can choose at will.'**
  String get there_are_1000_furniture_products_that_you_can_choose_at_will;

  /// No description provided for @this_will_cancel_your_order_and_you_will_not_be_able_to_modify_it_again.
  ///
  /// In en, this message translates to:
  /// **'this will cancel your order, and you will not be able to modify it again.'**
  String
      get this_will_cancel_your_order_and_you_will_not_be_able_to_modify_it_again;

  /// No description provided for @thursday.
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get thursday;

  /// No description provided for @to_continue_first_verify_that_its_you.
  ///
  /// In en, this message translates to:
  /// **'To continue, first verify that it’s you.'**
  String get to_continue_first_verify_that_its_you;

  /// No description provided for @to_make_it_easier_for_you_to_shop_we_provide_customer_service_if_you_have_any_questions.
  ///
  /// In en, this message translates to:
  /// **'To make it easier for you to shop, we provide customer service if you have any questions.'**
  String
      get to_make_it_easier_for_you_to_shop_we_provide_customer_service_if_you_have_any_questions;

  /// No description provided for @top_of_the_week.
  ///
  /// In en, this message translates to:
  /// **'Top of the week'**
  String get top_of_the_week;

  /// No description provided for @top_up.
  ///
  /// In en, this message translates to:
  /// **'Top Up'**
  String get top_up;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @total_item.
  ///
  /// In en, this message translates to:
  /// **'Total item'**
  String get total_item;

  /// No description provided for @total_payment.
  ///
  /// In en, this message translates to:
  /// **'Total payment'**
  String get total_payment;

  /// No description provided for @total_price.
  ///
  /// In en, this message translates to:
  /// **'Total price'**
  String get total_price;

  /// No description provided for @total_time.
  ///
  /// In en, this message translates to:
  /// **'Total time'**
  String get total_time;

  /// No description provided for @track_delivery.
  ///
  /// In en, this message translates to:
  /// **'Track delivery'**
  String get track_delivery;

  /// No description provided for @tracking_order.
  ///
  /// In en, this message translates to:
  /// **'Tracking order'**
  String get tracking_order;

  /// No description provided for @transaction_details.
  ///
  /// In en, this message translates to:
  /// **'Transaction details'**
  String get transaction_details;

  /// No description provided for @transfer.
  ///
  /// In en, this message translates to:
  /// **'Transfer'**
  String get transfer;

  /// No description provided for @travel.
  ///
  /// In en, this message translates to:
  /// **'Travel'**
  String get travel;

  /// No description provided for @trending.
  ///
  /// In en, this message translates to:
  /// **'Trending Now'**
  String get trending;

  /// No description provided for @trusted_and_secure.
  ///
  /// In en, this message translates to:
  /// **'Trusted & Secure'**
  String get trusted_and_secure;

  /// No description provided for @try_another_email_address.
  ///
  /// In en, this message translates to:
  /// **'try another email address'**
  String get try_another_email_address;

  /// No description provided for @tshirt.
  ///
  /// In en, this message translates to:
  /// **'T-Shirt'**
  String get tshirt;

  /// No description provided for @tuesday.
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get tuesday;

  /// No description provided for @two_factor_verification.
  ///
  /// In en, this message translates to:
  /// **'Two Factor Verification'**
  String get two_factor_verification;

  /// No description provided for @type_a_message.
  ///
  /// In en, this message translates to:
  /// **'Type a message'**
  String get type_a_message;

  /// No description provided for @unarchive.
  ///
  /// In en, this message translates to:
  /// **'Unarchive'**
  String get unarchive;

  /// No description provided for @upcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get upcoming;

  /// No description provided for @upload_photos.
  ///
  /// In en, this message translates to:
  /// **'Upload Photos'**
  String get upload_photos;

  /// No description provided for @use.
  ///
  /// In en, this message translates to:
  /// **'Use'**
  String get use;

  /// No description provided for @used.
  ///
  /// In en, this message translates to:
  /// **'Used'**
  String get used;

  /// No description provided for @user_information.
  ///
  /// In en, this message translates to:
  /// **'User information'**
  String get user_information;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @valid_until.
  ///
  /// In en, this message translates to:
  /// **'Valid until'**
  String get valid_until;

  /// No description provided for @verification_code.
  ///
  /// In en, this message translates to:
  /// **'OTP Verification'**
  String get verification_code;

  /// No description provided for @verified.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get verified;

  /// No description provided for @verify_now.
  ///
  /// In en, this message translates to:
  /// **'Verify now'**
  String get verify_now;

  /// No description provided for @verify_your_phone_number.
  ///
  /// In en, this message translates to:
  /// **'Verify your phone number'**
  String get verify_your_phone_number;

  /// No description provided for @vibrate.
  ///
  /// In en, this message translates to:
  /// **'Vibrate'**
  String get vibrate;

  /// No description provided for @video_call_on_click.
  ///
  /// In en, this message translates to:
  /// **'Video call on click'**
  String get video_call_on_click;

  /// No description provided for @view.
  ///
  /// In en, this message translates to:
  /// **'View'**
  String get view;

  /// No description provided for @view_all.
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get view_all;

  /// No description provided for @view_my_order.
  ///
  /// In en, this message translates to:
  /// **'View My Order'**
  String get view_my_order;

  /// No description provided for @village.
  ///
  /// In en, this message translates to:
  /// **'Village'**
  String get village;

  /// No description provided for @visit_store.
  ///
  /// In en, this message translates to:
  /// **'Visit store'**
  String get visit_store;

  /// No description provided for @wait_for_payment.
  ///
  /// In en, this message translates to:
  /// **'Waiting for payment'**
  String get wait_for_payment;

  /// No description provided for @waiting.
  ///
  /// In en, this message translates to:
  /// **'Waiting'**
  String get waiting;

  /// No description provided for @waiting_for_payment.
  ///
  /// In en, this message translates to:
  /// **'Waiting for payment'**
  String get waiting_for_payment;

  /// No description provided for @waiting_for_seller_approval.
  ///
  /// In en, this message translates to:
  /// **'Waiting for seller approval'**
  String get waiting_for_seller_approval;

  /// No description provided for @wallet.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get wallet;

  /// No description provided for @watch.
  ///
  /// In en, this message translates to:
  /// **'Watch'**
  String get watch;

  /// No description provided for @we_have_a_100k_products_choose_your_product_from_our_ecommerce_shop.
  ///
  /// In en, this message translates to:
  /// **'We Have a 100k++ Products Choose Your product from our E-Commerce shop.'**
  String
      get we_have_a_100k_products_choose_your_product_from_our_ecommerce_shop;

  /// No description provided for @we_have_a_100kproducts_choose_your_product_from_our_ecommerce_shop.
  ///
  /// In en, this message translates to:
  /// **'We Have a 100k++ Products Choose Your product from our E-Commerce shop.'**
  String get we_have_a_100kproducts_choose_your_product_from_our_ecommerce_shop;

  /// No description provided for @we_have_more_than_100_thousand_products_choose_a_product_from_the_shuppy.
  ///
  /// In en, this message translates to:
  /// **'We have more than 100 thousand products. Choose a product from the Shup.py'**
  String
      get we_have_more_than_100_thousand_products_choose_a_product_from_the_shuppy;

  /// No description provided for @we_have_sent_a_password_recover_instructions_to_your_email.
  ///
  /// In en, this message translates to:
  /// **'We have sent a password recovery instructions to your email'**
  String get we_have_sent_a_password_recover_instructions_to_your_email;

  /// No description provided for @we_have_sent_a_password_recovery_instruction_to_your_email.
  ///
  /// In en, this message translates to:
  /// **'We have sent a password recovery instruction to your email'**
  String get we_have_sent_a_password_recovery_instruction_to_your_email;

  /// No description provided for @we_have_sent_the_code_verification_to_your_phone_number.
  ///
  /// In en, this message translates to:
  /// **'We have sent an OTP verification code to your mobile number'**
  String get we_have_sent_the_code_verification_to_your_phone_number;

  /// No description provided for @find_and_attend.
  ///
  /// In en, this message translates to:
  /// **'Whether it\'s text or audio, enjoy Ejaz titles at your own pace'**
  String get find_and_attend;

  /// No description provided for @find_and_attend_one.
  ///
  /// In en, this message translates to:
  /// **'Ejaz Club, an interactive space for sharing your ideas'**
  String get find_and_attend_one;

  /// No description provided for @find_and_attend_two.
  ///
  /// In en, this message translates to:
  /// **'Watch for new additions and suggest books you\'d like to see next!'**
  String get find_and_attend_two;

  /// No description provided for @we_provide_best_services_ever.
  ///
  /// In en, this message translates to:
  /// **'We Provide Best Services Ever'**
  String get we_provide_best_services_ever;

  /// No description provided for @we_recommend_stories_and_videos_based_on_your_interests_and_our_editors_picks.
  ///
  /// In en, this message translates to:
  /// **'We recommend stories and videos based on your interests and our editor’s picks. '**
  String
      get we_recommend_stories_and_videos_based_on_your_interests_and_our_editors_picks;

  /// No description provided for @we_will_deliver_your_orders_with_the_fastest_and_safest_shipping_way.
  ///
  /// In en, this message translates to:
  /// **'We will deliver your orders with the fastest and safest shipping way'**
  String
      get we_will_deliver_your_orders_with_the_fastest_and_safest_shipping_way;

  /// No description provided for @we_will_help_find_order_and_buy_barbershop_products_and_services_at_your_location.
  ///
  /// In en, this message translates to:
  /// **'We will help find order and buy barbershop products and services at your location'**
  String
      get we_will_help_find_order_and_buy_barbershop_products_and_services_at_your_location;

  /// No description provided for @we_will_send_a_OTP_Code_for_verify_phone_numbers_its_you.
  ///
  /// In en, this message translates to:
  /// **'We will send a OTP Code for verify phone numbers i\'ts you'**
  String get we_will_send_a_OTP_Code_for_verify_phone_numbers_its_you;

  /// No description provided for @we_will_serve_you_well_so_that_you_remain_handsome_and_stylish.
  ///
  /// In en, this message translates to:
  /// **'We will serve you well so that you remain handsome and stylish'**
  String get we_will_serve_you_well_so_that_you_remain_handsome_and_stylish;

  /// No description provided for @website.
  ///
  /// In en, this message translates to:
  /// **'Website'**
  String get website;

  /// No description provided for @website_not_available.
  ///
  /// In en, this message translates to:
  /// **'Website not available'**
  String get website_not_available;

  /// No description provided for @wednesday.
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get wednesday;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @welcome_back.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get welcome_back;

  /// No description provided for @welcome_to.
  ///
  /// In en, this message translates to:
  /// **'Welcome to'**
  String get welcome_to;

  /// No description provided for @welcome_to_back.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Back'**
  String get welcome_to_back;

  /// No description provided for @welcome_to_barbara.
  ///
  /// In en, this message translates to:
  /// **'Welcome to barbara'**
  String get welcome_to_barbara;

  /// No description provided for @welcome_to_belila.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Belila'**
  String get welcome_to_belila;

  /// No description provided for @welcome_to_shuppy.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Shup.py'**
  String get welcome_to_shuppy;

  /// No description provided for @when_to_buy.
  ///
  /// In en, this message translates to:
  /// **'When to Buy'**
  String get when_to_buy;

  /// No description provided for @when_you_order_we_will_hook_you_up_with_exclusive_coupons_specials_and_rewards.
  ///
  /// In en, this message translates to:
  /// **'When you order, we will hook you up with exclusive coupons, specials and rewards.'**
  String
      get when_you_order_we_will_hook_you_up_with_exclusive_coupons_specials_and_rewards;

  /// No description provided for @which_you_might_like.
  ///
  /// In en, this message translates to:
  /// **'Which you might like'**
  String get which_you_might_like;

  /// No description provided for @woman_bag.
  ///
  /// In en, this message translates to:
  /// **'Woman Bag'**
  String get woman_bag;

  /// No description provided for @woman_pants.
  ///
  /// In en, this message translates to:
  /// **'Woman Pants'**
  String get woman_pants;

  /// No description provided for @woman_shoes.
  ///
  /// In en, this message translates to:
  /// **'Woman Shoes'**
  String get woman_shoes;

  /// No description provided for @woman_tshirt.
  ///
  /// In en, this message translates to:
  /// **'Woman T-Shirt'**
  String get woman_tshirt;

  /// No description provided for @women.
  ///
  /// In en, this message translates to:
  /// **'Women'**
  String get women;

  /// No description provided for @write_a_message.
  ///
  /// In en, this message translates to:
  /// **'Write a message'**
  String get write_a_message;

  /// No description provided for @write_your_review.
  ///
  /// In en, this message translates to:
  /// **'Write your review'**
  String get write_your_review;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @yes_cancel.
  ///
  /// In en, this message translates to:
  /// **'Yes, cancel'**
  String get yes_cancel;

  /// No description provided for @yes_sure.
  ///
  /// In en, this message translates to:
  /// **'Yes, sure'**
  String get yes_sure;

  /// No description provided for @you_can_pay_on_the_spot.
  ///
  /// In en, this message translates to:
  /// **'You can pay on the spot'**
  String get you_can_pay_on_the_spot;

  /// No description provided for @you_can_select_the_date_and_also_We_can_help_you_by_suggesting_you_to_set_a_good_schedule.
  ///
  /// In en, this message translates to:
  /// **'You can select the date and also We can help you by suggesting you to set a good schedule'**
  String
      get you_can_select_the_date_and_also_We_can_help_you_by_suggesting_you_to_set_a_good_schedule;

  /// No description provided for @you_can_view_the_appointment_booking_info_in_the_appointment_section.
  ///
  /// In en, this message translates to:
  /// **'You can view the appointment booking info in the appointment section'**
  String
      get you_can_view_the_appointment_booking_info_in_the_appointment_section;

  /// No description provided for @you_have_successfully_reset_your_password_Check_your_email_to_create_a_new_password.
  ///
  /// In en, this message translates to:
  /// **'You have successfully reset your password. Check your email to create a new password.'**
  String
      get you_have_successfully_reset_your_password_Check_your_email_to_create_a_new_password;

  /// No description provided for @you_ve_got_nothing.
  ///
  /// In en, this message translates to:
  /// **'You\'ve got nothing'**
  String get you_ve_got_nothing;

  /// No description provided for @you_will_be_returned_to_the_sign_in_screen.
  ///
  /// In en, this message translates to:
  /// **'You will be returned to the Sign in screen.'**
  String get you_will_be_returned_to_the_sign_in_screen;

  /// No description provided for @your_Order_is_Completed_Please_Check_the_Delivery_Status.
  ///
  /// In en, this message translates to:
  /// **'Your Order is Completed.\nPlease Check the Delivery Status'**
  String get your_Order_is_Completed_Please_Check_the_Delivery_Status;

  /// No description provided for @your_address.
  ///
  /// In en, this message translates to:
  /// **'Your address'**
  String get your_address;

  /// No description provided for @your_appointment_booking_is_successfully.
  ///
  /// In en, this message translates to:
  /// **'Your appointment booking is successfully'**
  String get your_appointment_booking_is_successfully;

  /// No description provided for @your_appointment_has_been_cancelled.
  ///
  /// In en, this message translates to:
  /// **'Your appointment has been cancelled'**
  String get your_appointment_has_been_cancelled;

  /// No description provided for @your_favorite_book.
  ///
  /// In en, this message translates to:
  /// **'Ejaz Favorites'**
  String get your_favorite_book;

  /// No description provided for @your_download_book.
  ///
  /// In en, this message translates to:
  /// **'Ejaz Downloads'**
  String get your_download_book;

  /// No description provided for @your_favorite_list_is_empty_lets_find_interesting_products_and_add_them_to_favorites.
  ///
  /// In en, this message translates to:
  /// **'Your favorite list is empty let\'s find interesting products_and_add_them to favorites.'**
  String
      get your_favorite_list_is_empty_lets_find_interesting_products_and_add_them_to_favorites;

  /// No description provided for @your_location.
  ///
  /// In en, this message translates to:
  /// **'Your location'**
  String get your_location;

  /// No description provided for @your_new_password_must_be_different_from_previous_used_passwords.
  ///
  /// In en, this message translates to:
  /// **'Your new password must be different from previous used passwords'**
  String get your_new_password_must_be_different_from_previous_used_passwords;

  /// No description provided for @your_new_password_must_be_different_from_previously_used_passwords.
  ///
  /// In en, this message translates to:
  /// **'Your new password must be different from previously used passwords'**
  String get your_new_password_must_be_different_from_previously_used_passwords;

  /// No description provided for @your_order_has_been_cancelled.
  ///
  /// In en, this message translates to:
  /// **'Your order has been cancelled'**
  String get your_order_has_been_cancelled;

  /// No description provided for @your_order_history_is_empty.
  ///
  /// In en, this message translates to:
  /// **'Your order history is empty'**
  String get your_order_history_is_empty;

  /// No description provided for @your_order_is_complete.
  ///
  /// In en, this message translates to:
  /// **'Your order is complete!'**
  String get your_order_is_complete;

  /// No description provided for @your_order_will_be_delivered_soon_thank_you_for_shopping.
  ///
  /// In en, this message translates to:
  /// **'Your order will be delivered soon thank you for shopping'**
  String get your_order_will_be_delivered_soon_thank_you_for_shopping;

  /// No description provided for @your_orders.
  ///
  /// In en, this message translates to:
  /// **'Your Orders'**
  String get your_orders;

  /// No description provided for @your_package_has_been_placedwe_are_waiting_for_payment_to_continue_the_next_process.
  ///
  /// In en, this message translates to:
  /// **'Your package has been placedwe are waiting for payment to continue the next process'**
  String
      get your_package_has_been_placedwe_are_waiting_for_payment_to_continue_the_next_process;

  /// No description provided for @your_password_has_been_changed_please_check_your_email_inbox.
  ///
  /// In en, this message translates to:
  /// **'Your password has been changed please check your email inbox'**
  String get your_password_has_been_changed_please_check_your_email_inbox;

  /// No description provided for @your_payment_is_successfull.
  ///
  /// In en, this message translates to:
  /// **'Your payment is successfull'**
  String get your_payment_is_successfull;

  /// No description provided for @your_product_is_delivered_to_your_home_fast_and_secure.
  ///
  /// In en, this message translates to:
  /// **'Your product is delivered to your home fast and secure'**
  String get your_product_is_delivered_to_your_home_fast_and_secure;

  /// No description provided for @your_successfully_made_a_payment_enjoy_your_room.
  ///
  /// In en, this message translates to:
  /// **'Your successfully made a payment,  Enjoy your room !'**
  String get your_successfully_made_a_payment_enjoy_your_room;

  /// No description provided for @zip_code.
  ///
  /// In en, this message translates to:
  /// **'Zip Code'**
  String get zip_code;

  /// No description provided for @descrition_navigation_language.
  ///
  /// In en, this message translates to:
  /// **'This won’t affect the original language of the books'**
  String get descrition_navigation_language;

  /// No description provided for @lets_getstrat.
  ///
  /// In en, this message translates to:
  /// **'Let\'s go!'**
  String get lets_getstrat;

  /// No description provided for @sign_in_or_login.
  ///
  /// In en, this message translates to:
  /// **'Sign up or log in to begin your literary adventure!'**
  String get sign_in_or_login;

  /// No description provided for @continue_with_email.
  ///
  /// In en, this message translates to:
  /// **'Continue With Email'**
  String get continue_with_email;

  /// No description provided for @continue_with_google.
  ///
  /// In en, this message translates to:
  /// **'Continue With Google'**
  String get continue_with_google;

  /// No description provided for @continue_with_apple.
  ///
  /// In en, this message translates to:
  /// **'Continue With Apple'**
  String get continue_with_apple;

  /// No description provided for @apple_sign_in_tapped.
  ///
  /// In en, this message translates to:
  /// **'Apple Sign in tapped'**
  String get apple_sign_in_tapped;

  /// No description provided for @log_in_button.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get log_in_button;

  /// No description provided for @welcom_back.
  ///
  /// In en, this message translates to:
  /// **'Welcome back, you’ve been missed!'**
  String get welcom_back;

  /// No description provided for @by_sign_in_i_accept.
  ///
  /// In en, this message translates to:
  /// **'By signing in, I accept the '**
  String get by_sign_in_i_accept;

  /// No description provided for @terms_of_Service.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get terms_of_Service;

  /// No description provided for @and_community_guidelines_and_have_read.
  ///
  /// In en, this message translates to:
  /// **'and have read the'**
  String get and_community_guidelines_and_have_read;

  /// No description provided for @privacy_policy_two.
  ///
  /// In en, this message translates to:
  /// **' Privacy Policy'**
  String get privacy_policy_two;

  /// No description provided for @mobile_nu.
  ///
  /// In en, this message translates to:
  /// **'Mobile Nu'**
  String get mobile_nu;

  /// No description provided for @emailreset.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailreset;

  /// No description provided for @select_of_the_following.
  ///
  /// In en, this message translates to:
  /// **'Select one of the following methods to reset your password'**
  String get select_of_the_following;

  /// No description provided for @formation_to_us_then.
  ///
  /// In en, this message translates to:
  /// **''**
  String get formation_to_us_then;

  /// No description provided for @formation_to_us_then_two.
  ///
  /// In en, this message translates to:
  /// **''**
  String get formation_to_us_then_two;

  /// No description provided for @today_is_a_new_day_for_knowledge.
  ///
  /// In en, this message translates to:
  /// **'Check out what\'s new with Ejaz!'**
  String get today_is_a_new_day_for_knowledge;

  /// No description provided for @continue_reading.
  ///
  /// In en, this message translates to:
  /// **'New to Ejaz'**
  String get continue_reading;

  /// No description provided for @download_books.
  ///
  /// In en, this message translates to:
  /// **'Download Books'**
  String get download_books;

  /// No description provided for @upgrade_premium_plan.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Premium Plan'**
  String get upgrade_premium_plan;

  /// No description provided for @account_setting.
  ///
  /// In en, this message translates to:
  /// **'ACCOUNT SETTINGS'**
  String get account_setting;

  /// No description provided for @application.
  ///
  /// In en, this message translates to:
  /// **'APPLICATION'**
  String get application;

  /// No description provided for @publishbook.
  ///
  /// In en, this message translates to:
  /// **'Publisher :'**
  String get publishbook;

  /// No description provided for @numberisbn.
  ///
  /// In en, this message translates to:
  /// **'ISBN :'**
  String get numberisbn;

  /// No description provided for @recently_added.
  ///
  /// In en, this message translates to:
  /// **'Recently Added'**
  String get recently_added;

  /// No description provided for @become_menber.
  ///
  /// In en, this message translates to:
  /// **'Become a member Now'**
  String get become_menber;

  /// No description provided for @your_text_summary.
  ///
  /// In en, this message translates to:
  /// **'Your Text Summary for 24 hours'**
  String get your_text_summary;

  /// No description provided for @upgrade_now.
  ///
  /// In en, this message translates to:
  /// **'Upgrade your account now'**
  String get upgrade_now;

  /// No description provided for @top_authors.
  ///
  /// In en, this message translates to:
  /// **'Top Authors'**
  String get top_authors;

  /// No description provided for @gift_ejaz_for.
  ///
  /// In en, this message translates to:
  /// **'Gift Ejaz for your beloved'**
  String get gift_ejaz_for;

  /// No description provided for @you_can_gift_ejaz.
  ///
  /// In en, this message translates to:
  /// **'Gift Ejaz subscription'**
  String get you_can_gift_ejaz;

  /// No description provided for @gift_ejaz.
  ///
  /// In en, this message translates to:
  /// **'Gift Ejaz'**
  String get gift_ejaz;

  /// No description provided for @quote_of_day.
  ///
  /// In en, this message translates to:
  /// **'Can\'t find what you\'re looking for?'**
  String get quote_of_day;

  /// No description provided for @the_true_sign.
  ///
  /// In en, this message translates to:
  /// **'Let us know what to add next!'**
  String get the_true_sign;

  /// No description provided for @popular_interested.
  ///
  /// In en, this message translates to:
  /// **'Popular interests'**
  String get popular_interested;

  /// No description provided for @view_comment.
  ///
  /// In en, this message translates to:
  /// **'View Comment'**
  String get view_comment;

  /// No description provided for @lang_en.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get lang_en;

  /// No description provided for @lang_ar.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get lang_ar;

  /// No description provided for @select_catetegory.
  ///
  /// In en, this message translates to:
  /// **'Select your interests'**
  String get select_catetegory;

  /// No description provided for @choose_witch_you_have.
  ///
  /// In en, this message translates to:
  /// **'Choose from the below to get specialized recommendations'**
  String get choose_witch_you_have;

  /// No description provided for @summarie_lang.
  ///
  /// In en, this message translates to:
  /// **'Books Languages'**
  String get summarie_lang;

  /// No description provided for @choose_witch_you_have_interest.
  ///
  /// In en, this message translates to:
  /// **'Select the languages you want to read in and listen to'**
  String get choose_witch_you_have_interest;

  /// No description provided for @select_dark_light.
  ///
  /// In en, this message translates to:
  /// **'Select viewing mode'**
  String get select_dark_light;

  /// No description provided for @choose_dark_mode.
  ///
  /// In en, this message translates to:
  /// **'Toggle the switch to go from light to dark mode'**
  String get choose_dark_mode;

  /// No description provided for @turn_on.
  ///
  /// In en, this message translates to:
  /// **' Dark Mode'**
  String get turn_on;

  /// No description provided for @choose_avatar.
  ///
  /// In en, this message translates to:
  /// **'Upload an avatar'**
  String get choose_avatar;

  /// No description provided for @select_profile_photo.
  ///
  /// In en, this message translates to:
  /// **'This image will be publicly visible on Ejaz'**
  String get select_profile_photo;

  /// No description provided for @preference.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get preference;

  /// No description provided for @suggetion.
  ///
  /// In en, this message translates to:
  /// **'Suggest now'**
  String get suggetion;

  /// No description provided for @english_books.
  ///
  /// In en, this message translates to:
  /// **'English Books'**
  String get english_books;

  /// No description provided for @young_adults.
  ///
  /// In en, this message translates to:
  /// **'Young Adults'**
  String get young_adults;

  /// No description provided for @monthly_subscription.
  ///
  /// In en, this message translates to:
  /// **'Monthly subscription'**
  String get monthly_subscription;

  /// No description provided for @yearly_subscription.
  ///
  /// In en, this message translates to:
  /// **'Yearly subscription'**
  String get yearly_subscription;

  /// No description provided for @select_your_plan_subscription.
  ///
  /// In en, this message translates to:
  /// **'Choose a Premium Plan'**
  String get select_your_plan_subscription;

  /// No description provided for @get_prenuim.
  ///
  /// In en, this message translates to:
  /// **'Get premium features and unlimited access'**
  String get get_prenuim;

  /// No description provided for @please_select_plan_subsc.
  ///
  /// In en, this message translates to:
  /// **'Please Select Your Plan Subscription'**
  String get please_select_plan_subsc;

  /// No description provided for @alert.
  ///
  /// In en, this message translates to:
  /// **'Alert'**
  String get alert;

  /// No description provided for @introduction.
  ///
  /// In en, this message translates to:
  /// **'Introduction'**
  String get introduction;

  /// No description provided for @story.
  ///
  /// In en, this message translates to:
  /// **'The Story'**
  String get story;

  /// No description provided for @characters.
  ///
  /// In en, this message translates to:
  /// **'Characters'**
  String get characters;

  /// No description provided for @free_account.
  ///
  /// In en, this message translates to:
  /// **'Free Account'**
  String get free_account;

  /// No description provided for @upgrad_account.
  ///
  /// In en, this message translates to:
  /// **'Account Upgraded'**
  String get upgrad_account;

  /// No description provided for @sex.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get sex;

  /// No description provided for @become_member.
  ///
  /// In en, this message translates to:
  /// **'Become a member'**
  String get become_member;

  /// No description provided for @upgrade_now_account.
  ///
  /// In en, this message translates to:
  /// **'Upgrade your account Now'**
  String get upgrade_now_account;

  /// No description provided for @takeaway.
  ///
  /// In en, this message translates to:
  /// **'Takeaway'**
  String get takeaway;

  /// No description provided for @audio.
  ///
  /// In en, this message translates to:
  /// **'Audio'**
  String get audio;

  /// No description provided for @ejazclub.
  ///
  /// In en, this message translates to:
  /// **'Ejaz Club'**
  String get ejazclub;

  /// No description provided for @setep1.
  ///
  /// In en, this message translates to:
  /// **'Step 1/4'**
  String get setep1;

  /// No description provided for @setep2.
  ///
  /// In en, this message translates to:
  /// **'Step 2/4'**
  String get setep2;

  /// No description provided for @setep3.
  ///
  /// In en, this message translates to:
  /// **'Step 3/4'**
  String get setep3;

  /// No description provided for @finish.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get finish;

  /// No description provided for @books.
  ///
  /// In en, this message translates to:
  /// **'Books'**
  String get books;

  /// No description provided for @collections.
  ///
  /// In en, this message translates to:
  /// **'Collections'**
  String get collections;

  /// No description provided for @bio.
  ///
  /// In en, this message translates to:
  /// **'Bio'**
  String get bio;

  /// No description provided for @country.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get country;

  /// No description provided for @no_notification.
  ///
  /// In en, this message translates to:
  /// **'New notifications will appear here'**
  String get no_notification;

  /// No description provided for @no_notification_yet.
  ///
  /// In en, this message translates to:
  /// **'No Notifications'**
  String get no_notification_yet;

  /// No description provided for @take_title.
  ///
  /// In en, this message translates to:
  /// **'No Takeaway'**
  String get take_title;

  /// No description provided for @take_subtile.
  ///
  /// In en, this message translates to:
  /// **'No takeaway available for this book'**
  String get take_subtile;

  /// No description provided for @exprire_code.
  ///
  /// In en, this message translates to:
  /// **'Your OTP Password will expire in'**
  String get exprire_code;

  /// No description provided for @create_newList.
  ///
  /// In en, this message translates to:
  /// **'Create new playlist'**
  String get create_newList;

  /// No description provided for @new_play_list_yet.
  ///
  /// In en, this message translates to:
  /// **'New playlists will appear here'**
  String get new_play_list_yet;

  /// No description provided for @no_play_audio.
  ///
  /// In en, this message translates to:
  /// **'No playlist'**
  String get no_play_audio;

  /// No description provided for @booktitle.
  ///
  /// In en, this message translates to:
  /// **'Book Tile'**
  String get booktitle;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabic;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @author.
  ///
  /// In en, this message translates to:
  /// **'Author'**
  String get author;

  /// No description provided for @isbn.
  ///
  /// In en, this message translates to:
  /// **'ISBN'**
  String get isbn;

  /// No description provided for @editor.
  ///
  /// In en, this message translates to:
  /// **'Editor'**
  String get editor;

  /// No description provided for @comments.
  ///
  /// In en, this message translates to:
  /// **'Comments'**
  String get comments;

  /// No description provided for @searchauthors.
  ///
  /// In en, this message translates to:
  /// **'Search Authors'**
  String get searchauthors;

  /// No description provided for @addnewplayList.
  ///
  /// In en, this message translates to:
  /// **'Add new playlist'**
  String get addnewplayList;

  /// No description provided for @newplaylist.
  ///
  /// In en, this message translates to:
  /// **'New Playlist'**
  String get newplaylist;

  /// No description provided for @myplaylist.
  ///
  /// In en, this message translates to:
  /// **'My playlist'**
  String get myplaylist;

  /// No description provided for @playlisttitle.
  ///
  /// In en, this message translates to:
  /// **'Name of playlist'**
  String get playlisttitle;

  /// No description provided for @create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create;

  /// No description provided for @cancels.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancels;

  /// No description provided for @playlist.
  ///
  /// In en, this message translates to:
  /// **'Playlist'**
  String get playlist;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @donee.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get donee;

  /// No description provided for @note.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get note;

  /// No description provided for @typesubscription.
  ///
  /// In en, this message translates to:
  /// **'Type of subscription'**
  String get typesubscription;

  /// No description provided for @fullname.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullname;

  /// No description provided for @others.
  ///
  /// In en, this message translates to:
  /// **'Others'**
  String get others;

  /// No description provided for @no_book.
  ///
  /// In en, this message translates to:
  /// **'No books downloaded'**
  String get no_book;

  /// No description provided for @download_books_willapear_here.
  ///
  /// In en, this message translates to:
  /// **'Downloaded books will appear here'**
  String get download_books_willapear_here;

  /// No description provided for @bowse_ejaz.
  ///
  /// In en, this message translates to:
  /// **'Browse Ejaz'**
  String get bowse_ejaz;

  /// No description provided for @skib_sinup.
  ///
  /// In en, this message translates to:
  /// **'Skip sign up'**
  String get skib_sinup;

  /// No description provided for @messagetoguestuser.
  ///
  /// In en, this message translates to:
  /// **'In order to use this feature you need to sign up'**
  String get messagetoguestuser;

  /// No description provided for @textappear.
  ///
  /// In en, this message translates to:
  /// **'Text will appear here!'**
  String get textappear;

  /// No description provided for @newpost.
  ///
  /// In en, this message translates to:
  /// **'New Post'**
  String get newpost;

  /// No description provided for @text_post.
  ///
  /// In en, this message translates to:
  /// **'What\'s on your Mind?'**
  String get text_post;

  /// No description provided for @post.
  ///
  /// In en, this message translates to:
  /// **'Add Post'**
  String get post;

  /// No description provided for @chatai.
  ///
  /// In en, this message translates to:
  /// **'Ejaz Books Scanner'**
  String get chatai;

  /// No description provided for @chatai_by_photo.
  ///
  /// In en, this message translates to:
  /// **'Obtain a quick summary'**
  String get chatai_by_photo;

  /// No description provided for @add_photo.
  ///
  /// In en, this message translates to:
  /// **'Add a book Cover'**
  String get add_photo;

  /// No description provided for @select_photo.
  ///
  /// In en, this message translates to:
  /// **'Upload a book Cover'**
  String get select_photo;

  /// No description provided for @chatai_ejaz.
  ///
  /// In en, this message translates to:
  /// **'Ejaz reader'**
  String get chatai_ejaz;

  /// No description provided for @stastic.
  ///
  /// In en, this message translates to:
  /// **'Reading Statistics'**
  String get stastic;

  /// No description provided for @booktrack.
  ///
  /// In en, this message translates to:
  /// **'Books Track'**
  String get booktrack;

  /// No description provided for @cannotemail.
  ///
  /// In en, this message translates to:
  /// **'You cannot currently change your password using email'**
  String get cannotemail;

  /// No description provided for @passwordwrong.
  ///
  /// In en, this message translates to:
  /// **'Wrong Password or Email'**
  String get passwordwrong;

  /// No description provided for @deleteplaylist.
  ///
  /// In en, this message translates to:
  /// **'Are you sure want to delete the playlist?'**
  String get deleteplaylist;

  /// No description provided for @ejazChat.
  ///
  /// In en, this message translates to:
  /// **'Ejaz Chat'**
  String get ejazChat;

  /// No description provided for @allChat.
  ///
  /// In en, this message translates to:
  /// **'All Chat'**
  String get allChat;

  /// No description provided for @unreadChat.
  ///
  /// In en, this message translates to:
  /// **'Unread Chat'**
  String get unreadChat;

  /// No description provided for @groupChat.
  ///
  /// In en, this message translates to:
  /// **'Group Chat'**
  String get groupChat;

  /// No description provided for @searchChat.
  ///
  /// In en, this message translates to:
  /// **'Search Chat'**
  String get searchChat;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @typeChatHere.
  ///
  /// In en, this message translates to:
  /// **'Type Chat Here...'**
  String get typeChatHere;

  /// No description provided for @searchuser.
  ///
  /// In en, this message translates to:
  /// **'Search Chat'**
  String get searchuser;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
