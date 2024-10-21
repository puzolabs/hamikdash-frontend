
enum KorbanTypes
{
  none,
  ola,
  shlamim,
  minha,
  nesahim,
  hatat,
  asham,
}

class EatInfo
{
  String what;
  String who;
  String where;
  String when;

  EatInfo({this.what = "", this.who = "", this.where = "", this.when = ""});

  factory EatInfo.fromJson(Map<String, dynamic> map) {
    String what = map["what"];
    String who = map["who"];
    String where = map["where"];
    String when = map["when"];
    return EatInfo(what: what, who: who, where: where, when: when);
  }
}

class Korban
{
  KorbanTypes type;
  String requirements = "";
  EatInfo? eatInfo;

  Korban({this.type = KorbanTypes.none, this.requirements = "", this.eatInfo});

  factory Korban.fromJson(Map<String, dynamic> map) {
    String type = map["type"];
    String requirements = map["requirements"];
    EatInfo? eatInfo = map["eat"] == null ? null : EatInfo.fromJson(map["eat"]);

    Map<String, KorbanTypes> types = {
      "עולה": KorbanTypes.ola,
      "שלמים": KorbanTypes.shlamim,
      "מנחה": KorbanTypes.minha,
      "נסכים": KorbanTypes.nesahim,
      "חטאת": KorbanTypes.hatat,
      "אשם": KorbanTypes.asham,
  };

    return Korban(type: types[type]!, requirements: requirements, eatInfo: eatInfo);
  }
}

class KorbansOption
{
  String name;
  List<Korban> korbans;

  KorbansOption({required this.name, required this.korbans});

  factory KorbansOption.fromJson(Map<String, dynamic> map) {
    String title = map["title"];
    var korbanot = map["korbanot"];

    List<Korban> list = korbanot
      .map<Korban>((korban) => Korban.fromJson(korban))
      .toList();
    
    return KorbansOption(name: title, korbans: list);
  }
}

class KorbanCase
{
  String title;
  List<Korban>? korbanot;
  List<KorbansOption>? korbanotOptions;

  KorbanCase({this.title = "", this.korbanot, this.korbanotOptions });

  bool get isSingleOptionKorbanCase => korbanot != null && korbanotOptions == null;
  bool get isMultiOptionsKorbanCase => korbanot == null && korbanotOptions != null;
  bool get isComplexKorbanCase => korbanot != null && korbanotOptions != null ;
}

class KorbanCasesFactory
{
  List<KorbanCase> create()
  {
    final case1 = KorbanCase(
      title: "הרהרתי הרהורי עבירה",
      korbanot: [
        Korban(
          type: KorbanTypes.hatat,
          requirements: "כבש"
        ),
        Korban(
          type: KorbanTypes.ola,
          requirements: "עז"
        ),
      ]
    );

    final case2 = KorbanCase(
      title: "ביטלתי מצוות עשה",
      korbanot: [
        Korban(
          type: KorbanTypes.shlamim,
          requirements: "כבשה"
        ),
        Korban(
          type: KorbanTypes.asham,
          requirements: "עיזה"
        ),
      ]
    );

    final case3 = KorbanCase(
      title: "עולה ויורד",
      korbanotOptions: [
        KorbansOption(
          name: "אפשרות ראשונה",
          korbans: [
            Korban(
              type: KorbanTypes.shlamim,
              requirements: "כבשה",
              eatInfo: EatInfo(what: "זרוע", who: "בעלים", where: "ירושלים", when: "יום ולילה")
            ),
            Korban(
              type: KorbanTypes.asham,
              requirements: "עיזה"
            ),
          ]
        ),
        KorbansOption(
          name: "אפשרות שניה",
          korbans: [
            Korban(
              type: KorbanTypes.minha,
              requirements: "סולת"
            ),
            Korban(
              type: KorbanTypes.nesahim,
              requirements: "יין"
            ),
          ]
        )
      ],
    );

    final case4 = KorbanCase(
      title: "תודה",
      korbanot: [
        Korban(
          type: KorbanTypes.shlamim,
          requirements: "כבשה"
        ),
        Korban(
          type: KorbanTypes.asham,
          requirements: "עיזה"
        ),
      ],
      korbanotOptions: [
        KorbansOption(
          name: "אפשרות ראשונה",
          korbans: [
            Korban(
              type: KorbanTypes.shlamim,
              requirements: "כבשה",
              eatInfo: EatInfo(what: "זרוע", who: "בעלים", where: "ירושלים", when: "יום ולילה")
            ),
            Korban(
              type: KorbanTypes.asham,
              requirements: "עיזה"
            ),
          ]
        ),
        KorbansOption(
          name: "אפשרות שניה",
          korbans: [
            Korban(
              type: KorbanTypes.minha,
              requirements: "סולת"
            ),
            Korban(
              type: KorbanTypes.nesahim,
              requirements: "יין"
            ),
          ]
        )
      ],
    );

    return [case1, case2, case3, case4];
  }
}

enum ComingOption
{
  prepareAllForMe,
  bringingAllWithMe,
}

enum Status
{
  pending,
  inProgress,
  done
}

class Visit
{
  String title = "";
  List<Korban>? korbans;
  ComingOption comingOption = ComingOption.prepareAllForMe;
  DateTime? dateTime;
  int? paymentAmount;
  Status status = Status.pending;
  String uid = "";
}

Visit? currentVisit;
List<Visit> visitList = <Visit>[];
