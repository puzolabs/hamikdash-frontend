
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
              requirements: "כבשה"
            ),
            Korban(
              type: "אשם",
              requirements: "עיזה"
            ),
          ]
        )
      ],
    );

    return [case1, case2, case3];
  }
}
