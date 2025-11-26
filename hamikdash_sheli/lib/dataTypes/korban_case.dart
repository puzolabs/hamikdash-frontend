
import 'package:hamikdash_sheli/dataTypes/korban.dart';
import 'package:hamikdash_sheli/dataTypes/korbans_option.dart';

// 7 sections
enum Sections {
  none,
  happyEvent,
  nedarimUndavot,
  nazir, // in the middle since one event is happy and the other one is part khet part avon
  caparatHataim,
  caparatAvonot,
  sadEvent,
  swear,
  temple,
}

enum CaseCodes {
  none,
  olaNedava,
  olaNeder,
  bitulAse,
  lavHanitakLeAse,
  hirhur,
  shogeg,
  shvuatSheker,
  shvuatShekerBeShogeg,
  tameLamikdash,
  tameKodashim,
  elilim,
  tameLamikdashBeShogeg,
  tameKodashimBeShogeg,
  ganav,
  loShilamti,
  shekerBePikadon,
  shekerBeMetzia,
  hekdesh,
  nazirTame,
  mezoraTahor,
  mesupak,
  nazir,
  shlamimNedava,
  shlamimNeder,
  bicurim,
  toda,
  todaNedava,
  todaNeder,
  bekhor,
  maaser,
  yoledet,
  mezoraTahorSofi,
  zav,
  ger,
  minhaNedava,
  minhaNeder,
  nesahimNedava,
  nesahimNeder
}

class KorbanCase
{
  Sections section;
  CaseCodes code;
  String title;
  String details;
  String image;
  List<Korban>? korbanot;
  List<KorbansOption>? korbanotOptions;

  KorbanCase({this.section = Sections.none, this.code = CaseCodes.none, this.title = "", this.details = "", this.image = "", this.korbanot, this.korbanotOptions });

  bool get isSingleOptionKorbanCase => korbanot != null && korbanotOptions == null;
  bool get isMultiOptionsKorbanCase => korbanot == null && korbanotOptions != null;
  bool get isComplexKorbanCase => korbanot != null && korbanotOptions != null ;

  factory KorbanCase.fromJson(Map<String, dynamic> map) {
    String section = map["section"];
    String code = map["code"];
    String title = map["title"];
    String details = map["details"] ?? "";
    String image = map["image"];
    var korbanot = map["korbanot"];
    var korbanotOptions = map["korbanotOptions"];

    List<Korban>? list = korbanot
      ?.map<Korban>((korban) => Korban.fromJson(korban))
      .toList();

    List<KorbansOption>? optionsList = korbanotOptions
      ?.map<KorbansOption>((option) => KorbansOption.fromJson(option))
      .toList();

    return KorbanCase(section: Sections.values.byName(section), code: CaseCodes.values.byName(code), title: title, details: details, image: image, korbanot: list, korbanotOptions: optionsList);
  }
}
