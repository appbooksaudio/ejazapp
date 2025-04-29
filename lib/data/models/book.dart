// import 'package:hive/hive.dart';

// part 'book.g.dart';

// @HiveType(typeId: 1)
// class Book extends HiveObject {
//   @HiveField(0)
//   late final String? bk_ID;
//   @HiveField(1)
//   final String? bk_Code;
//   @HiveField(2)
//   final String? bk_Name;
//   @HiveField(3)
//   final String? bk_Name_Ar;
//   @HiveField(4)
//   final String? bk_Introduction;
//   @HiveField(5)
//   final String? bk_Introduction_Ar;
//   @HiveField(6)
//   final String? bk_Summary;
//   @HiveField(7)
//   final String? bk_Summary_Ar;
//   @HiveField(8)
//   final String? bk_Characters;
//   @HiveField(9)
//   final String? bk_Characters_Ar;
//   @HiveField(10)
//   final String? bk_Desc;
//   @HiveField(11)
//   final String? bk_Desc_Ar;
//   @HiveField(12)
//   final String? bk_Language;
//   @HiveField(13)
//   final String? bk_Language_Ar;
//   @HiveField(14)
//   final bool? bk_Active;
//   @HiveField(15)
//   final String? bk_CreatedOn;
//   @HiveField(16)
//   final String? bk_Modifier;
//   @HiveField(17)
//   final bool? bk_trial;
//   @HiveField(18)
//   final String imagePath;
//   @HiveField(19)
//   final String audioEn;
//   @HiveField(20)
//   final String audioAr;
//   @HiveField(21)
//   final List<dynamic> categories;
//   @HiveField(22)
//   final List<dynamic> genres;
//   @HiveField(23)
//   final List<dynamic> publishers;
//   @HiveField(24)
//   final List<dynamic> thematicAreas;
//   @HiveField(25)
//   final List<dynamic> authors;
//   @HiveField(26)
//   final List<dynamic> tags;
//   @HiveField(27)
//   final int? price;
//   @HiveField(28)
//   final int quantity;
//   @HiveField(29)
//   final String? iconCategory;
//   @HiveField(30)
//   final String? authoicon;

//   Book({
//     this.bk_ID,
//     this.bk_Code,
//     this.bk_Name,
//     this.bk_Name_Ar,
//     this.bk_Introduction,
//     this.bk_Introduction_Ar,
//     this.bk_Summary,
//     this.bk_Summary_Ar,
//     this.bk_Characters,
//     this.bk_Characters_Ar,
//     this.bk_Desc,
//     this.bk_Desc_Ar,
//     this.bk_Language,
//     this.bk_Language_Ar,
//     this.bk_Active,
//     this.bk_CreatedOn,
//     this.bk_Modifier,
//     this.bk_trial,
//     required this.categories,
//     required this.genres,
//     required this.publishers,
//     required this.thematicAreas,
//     required this.authors,
//     required this.tags,
//     required this.imagePath,
//     required this.audioEn,
//     required this.audioAr,
//     this.price,
//     this.quantity = 1,
//     this.iconCategory,
//     this.authoicon,
//   });

//   get title => null;
// }

// List<Book> mockBookList = [];
// List<Book> collectionListById = [];
import 'package:ejazapp/helpers/constants.dart';
import 'package:hive/hive.dart';

part 'book.g.dart';

@HiveType(typeId: 1)
class Book extends HiveObject {
  @HiveField(0)
  final String? bk_ID;
  @HiveField(1)
  final String? bk_Code;
  @HiveField(2)
  final String? bk_Name;
  @HiveField(3)
  final String? bk_Name_Ar;
  @HiveField(4)
  final String? bk_Introduction;
  @HiveField(5)
  final String? bk_Introduction_Ar;
  @HiveField(6)
  final String? bk_Summary;
  @HiveField(7)
  final String? bk_Summary_Ar;
  @HiveField(8)
  final String? bk_Characters;
  @HiveField(9)
  final String? bk_Characters_Ar;
  @HiveField(10)
  final String? bk_Desc;
  @HiveField(11)
  final String? bk_Desc_Ar;
  @HiveField(12)
  final String? bk_Language;
  @HiveField(13)
  final String? bk_Language_Ar;
  @HiveField(14)
  final bool? bk_Active;
  @HiveField(15)
  final String? bk_CreatedOn;
  @HiveField(16)
  final String? bk_Modifier;
  @HiveField(17)
  final bool? bk_trial;
  @HiveField(18)
  final String imagePath;
  @HiveField(19)
  final String audioEn;
  @HiveField(20)
  final String audioAr;
  @HiveField(21)
  final List<dynamic> categories;
  @HiveField(22)
  final List<dynamic> genres;
  @HiveField(23)
  final List<dynamic> publishers;
  @HiveField(24)
  final List<dynamic> thematicAreas;
  @HiveField(25)
  final List<dynamic> authors;
  @HiveField(26)
  final List<dynamic> tags;
  @HiveField(27)
  final int? price;
  @HiveField(28)
  final int quantity;
  @HiveField(29)
  final String? iconCategory;
  @HiveField(30)
  final String? authoicon;
  @HiveField(31)
  final String? bk_Title;
  @HiveField(32)
  final String? bk_Title_Ar;
   @HiveField(33)
  final String? url;

  Book({
    this.bk_ID,
    this.bk_Code,
    this.bk_Name,
    this.bk_Name_Ar,
    this.bk_Title,
    this.bk_Title_Ar,
    this.url,
    this.bk_Introduction,
    this.bk_Introduction_Ar,
    this.bk_Summary,
    this.bk_Summary_Ar,
    this.bk_Characters,
    this.bk_Characters_Ar,
    this.bk_Desc,
    this.bk_Desc_Ar,
    this.bk_Language,
    this.bk_Language_Ar,
    this.bk_Active,
    this.bk_CreatedOn,
    this.bk_Modifier,
    this.bk_trial,
    required this.categories,
    required this.genres,
    required this.publishers,
    required this.thematicAreas,
    required this.authors,
    required this.tags,
    required this.imagePath,
    required this.audioEn,
    required this.audioAr,
    this.price,
    this.quantity = 1,
    this.iconCategory,
    this.authoicon,
  });

  // 🛠 Convert JSON to Book Object
  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      bk_ID: json['bk_ID'] as String?,
      bk_Code: json['bk_Code'] as String?,
      url: json['url'] as String?,
      bk_Name: json['bk_Name'] == 'N/A'
          ? json['bk_Name_Ar'] as String?
          : json['bk_Name'] as String?,
      bk_Name_Ar: json['bk_Name_Ar'] as String?,
      bk_Title: json['bk_Title'] == 'N/A'
          ? json['bk_Title_Ar'] as String?
          : json['bk_Title'] as String?,
      bk_Title_Ar: json['bk_Title_Ar'] as String?,
      bk_Introduction: json['bk_Introduction'] == 'N/A'
          ? json['bk_Introduction_Ar'] as String?
          : json['bk_Introduction'] as String?,
      bk_Introduction_Ar: json['bk_Introduction_Ar'] as String?,
      bk_Summary: json['bk_Summary'] == 'N/A'
          ? json['bk_Summary_Ar'] as String?
          : json['bk_Summary'] as String?,
      bk_Summary_Ar: json['bk_Summary_Ar'] as String?,
      bk_Characters: json['bk_Characters'] == 'N/A'
          ? json['bk_Characters_Ar'] as String?
          : json['bk_Characters'] as String?,
      bk_Characters_Ar: json['bk_Characters_Ar'] as String?,
      bk_Desc: json['bk_Desc'] == 'N/A'
          ? json['bk_Desc_Ar'] as String?
          : json['bk_Desc'] as String?,
      bk_Desc_Ar: json['bk_Desc_Ar'] as String?,
      bk_Language: json['bk_Language'] == 'N/A'
          ? json['bk_Language_Ar'] as String?
          : json['bk_Language'] as String?,
      bk_Language_Ar: json['bk_Language_Ar'] as String?,
      bk_Active: json['bk_Active'] as bool?,
      bk_CreatedOn: json['bk_CreatedOn'] as String?,
      bk_Modifier: json['bk_Modifier'] as String?,
      bk_trial: json['bk_Trial'] as bool?,
      imagePath: json['media'] != null && (json['media'] as List).isNotEmpty
          ? json['media'][0]['md_URL'] as String
          : "5337aa5b-949b-4dd2-8563-08db749b866d",
      audioEn: json['md_AudioEn_URL'] != null
          ? json['md_AudioEn_URL'] as String
          : Const.UrlAu,
      audioAr: json['md_AudioAr_URL'] != null
          ? json['md_AudioAr_URL'] as String
          : Const.UrlAu,
      categories: json['categories'] as List<dynamic>? ?? [],
      genres: json['genres'] as List<dynamic>? ?? [],
      publishers: json['publishers'] as List<dynamic>? ?? [],
      thematicAreas: json['thematicAreas'] as List<dynamic>? ?? [],
      authors: json['authors'] as List<dynamic>? ?? [],
      tags: json['tags'] as List<dynamic>? ?? [],
      price: json['price'] as int?,
      quantity: 1, // Default value
      iconCategory: json['iconCategory'] as String?,
      authoicon: json['authoicon'] as String?,
    );
  }

  // 🛠 Convert Book Object to JSON (for saving to Hive or sending to API)
  Map<String, dynamic> toJson() {
    return {
      'bk_ID': bk_ID,
      'bk_Code': bk_Code,
      'bk_Name': bk_Name,
      'url': url,
      'bk_Name_Ar': bk_Name_Ar,
      'bk_Title': bk_Title,
      'bk_Title_Ar': bk_Title_Ar,
      'bk_Introduction': bk_Introduction,
      'bk_Introduction_Ar': bk_Introduction_Ar,
      'bk_Summary': bk_Summary,
      'bk_Summary_Ar': bk_Summary_Ar,
      'bk_Characters': bk_Characters,
      'bk_Characters_Ar': bk_Characters_Ar,
      'bk_Desc': bk_Desc,
      'bk_Desc_Ar': bk_Desc_Ar,
      'bk_Language': bk_Language,
      'bk_Language_Ar': bk_Language_Ar,
      'bk_Active': bk_Active,
      'bk_CreatedOn': bk_CreatedOn,
      'bk_Modifier': bk_Modifier,
      'bk_trial': bk_trial,
      'imagePath': imagePath,
      'audioEn': audioEn,
      'audioAr': audioAr,
      'categories': categories,
      'genres': genres,
      'publishers': publishers,
      'thematicAreas': thematicAreas,
      'authors': authors,
      'tags': tags,
      'price': price,
      'quantity': quantity,
      'iconCategory': iconCategory,
      'authoicon': authoicon,
    };
  }
}

List<Book> mockBookList = [];
List<Book> collectionListById = [];
List<Book> LastBooks = [];
List<Book> getbooksbypublishers = [];
