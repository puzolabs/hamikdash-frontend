
enum KorbamTypes
{
  none,
  hatat,
  ola,
  shlamim,
  asham
}

class Korban
{
  String type;
  String requirements = "";

  Korban({this.type = "", this.requirements = ""});
}

class KorbanCase
{
  String title;
  List<Korban> korbanot;

  KorbanCase({this.title = "", required this.korbanot });
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

    return [case1, case2];
  }
}
