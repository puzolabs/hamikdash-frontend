
enum KorbamTypes
{
  none,
  hatat,
  ola,
  shlamim,
  asham
}

class EatInfo
{
  String what;
  String who;
  String where;
  String when;

  EatInfo({this.what = "", this.who = "", this.where = "", this.when = ""});
}

class Korban
{
  String type;
  String requirements = "";
  EatInfo? eatInfo;

  Korban({this.type = "", this.requirements = "", this.eatInfo});
}

class KorbansOption
{
  String name;
  List<Korban> korbans;

  KorbansOption({required this.name, required this.korbans});
}

class KorbanCase
{
  String title;
  List<Korban>? korbanot;
  List<KorbansOption>? korbanotOptions;

  KorbanCase({this.title = "", this.korbanot, this.korbanotOptions });
}

class KorbanCasesFactory
{
  List<KorbanCase> create()
  {
    final case1 = KorbanCase(
      title: "הרהרתי הרהורי עבירה",
      korbanot: [
        Korban(
          type: "חטאת",
          requirements: "כבש"
        ),
        Korban(
          type: "עולה",
          requirements: "עז"
        ),
      ]
    );

    final case2 = KorbanCase(
      title: "ביטלתי מצוות עשה",
      korbanot: [
        Korban(
          type: "שלמים",
          requirements: "כבשה"
        ),
        Korban(
          type: "אשם",
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
              type: "שלמים",
              requirements: "כבשה",
              eatInfo: EatInfo(what: "זרוע", who: "בעלים", where: "ירושלים", when: "יום ולילה")
            ),
            Korban(
              type: "אשם",
              requirements: "עיזה"
            ),
          ]
        ),
        KorbansOption(
          name: "אפשרות שניה",
          korbans: [
            Korban(
              type: "מנחה",
              requirements: "סולת"
            ),
            Korban(
              type: "נסכים",
              requirements: "יין"
            ),
          ]
        )
      ],
    );

    return [case1, case2, case3];
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
  DateTime dateTime = DateTime.now().toUtc();
  int? paymentAmount;
  Status status = Status.pending;
}

Visit? currentVisit;
List<Visit> visitList = <Visit>[];
