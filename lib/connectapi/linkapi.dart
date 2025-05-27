class AppLink {
  ///Gemeni API KEY ="AIzaSyA4NZiRhArE_1oOa2ACEWQeEUJGZ94okWo"
  //Test
  static const String test = 'https://jsonplaceholder.typicode.com/posts';
// server App
  static const String server = 'https://getejaz.com/api/ejaz/v1';

  static const String imageststatic =
      'https://getejaz.com/api/ejaz/v1/Book/getBooks';//https://ejaz-api.azurewebsites.net  (Azure server with credential --whsini@hbku.edu.qa--)

//========================== Image ============================
  static const String imagestCategories = '$imageststatic/categories';
  static const String imagestItems = '$imageststatic/items';
// =============================================================
//function update token
  static const String updatetoken = '$server/Account/updateFirebaseToken';
//function checklogin
  static const String checklogin = '$server/Account/isUserExist';
  static const String login = '$server/Account/OAuthFree';
  static const String signup = '$server/Account/registerOAuthFree';
  static const String updatepassword = '$server/Account/UpdatePassword';
  static const String forgetpassword = '$server/Account/updateForgotPassword';
  static const String getbook =
      '$server/Book/getBooks/?status=active&'; //?search=&status=active&pageSize=50&orderBy=Title&orderAs=DESC
  static const String category = '$server/Category/getCategories';
  static const String authors = '$server/Author/getAuthors';
  static const String authorsbycollection = '$server/BookCollection/getBookCollectionsByAuthor';
  //**************** Api link for getsubscritipn ******************/
  static const String getsubscritipn = '$server/Subscription/getSubscriptions';
  static const String getejazcollection =
      '$server/BookCollection/getBookCollections';
  static const String getejazcollectionById =
      '$server/BookCollection/getBookCollection/';
  //**************** Api link for updateprofile ******************/
  static const String updateprofile = '$server/Profile/updateProfile';
  //**************** Api link for doPayment ******************/
  static const String paymentdo = '$server/Payment/doPayment';
   //**************** Api link for GiftEjaz ******************/
  static const String giftejaz = '$server/Payment/giftPayment';
  //**************** Api link for Banner/getBanners ******************/
  static const String banner = '$server/Banner/getBanners';
 //**************** Api link for Banner/getBanners ******************/
  static const String suggest = '$server/Book/suggestBook';
  static const String getCategories = '$server/Category/getCategories/?PageSize=50&OrderBy=Title&OrderAs=DESC';
//  static const String getbook =
  //   'https://gist.githubusercontent.com/JohannesMilke/d53fbbe9a1b7e7ca2645db13b995dc6f/raw/eace0e20f86cdde3352b2d92f699b6e9dedd8c70/books.json';
 //**************** Api link for PaymentAppleGoogle ******************/
 static const String PaymentAppleGooglleTest = 'https://apitest.cybersource.com/pts/v2/payments/';
 static const String PaymentAppleGooglleProduction = 'https://api.cybersource.com/pts/v2/payments/';
 static const String getbooksbypublishers = '$server/Book/getBookByPublisher';
  static const String getbooksbyauthors = '$server/Book/getBookByAuthor';
  static const DEFAULT_TOKEN =
      "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6ImVqYXphcHA1OEBnbWFpbC5jb20iLCJuYW1laWQiOiI5NDllM2VkNy02YjBhLTQ3ZDItODNlOC00ZWU0MjA4OWQ4OGMiLCJlbWFpbCI6ImVqYXphcHA1OEBnbWFpbC5jb20iLCJuYmYiOjE3NDE3NTk1NTEsImV4cCI6MTc0NDM1MTU1MSwiaWF0IjoxNzQxNzU5NTUxfQ.cR0Yb5xYeoVxjRhO4W13MziuzWJ1vlbP6I3hgL5iZeuTiKfV50calIXVjoDQHw1S-5Zr28r5n85pBZtjaidEQQ";
  static const Refresh_TOKEN ="eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IkVqYXpEZXZlbG9wZXJzaXVkIiwibmFtZWlkIjoiYzk2MWRhZDktNmQxOS00ZmE0LWFjNDktNDZlYTQ0NTEwZjg2IiwiZW1haWwiOiJlamF6LjAxLmRldmVsb3BlZnJ0eXRAZ21haWwuY29tIiwibmJmIjoxNzQyOTc2ODkxLCJleHAiOjE3NDU1Njg4OTEsImlhdCI6MTc0Mjk3Njg5MX0.xfyL2X7OxTjXRH-IpN09Yy3qv8UZUjOGSOEnQavH5Ja02bpYqW18kqDkEgInXYiE5qvcuppY7dGWwFRMsb_wYw";




}
