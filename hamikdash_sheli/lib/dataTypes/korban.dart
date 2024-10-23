
enum KorbanTypes
{
  none,
  ola,
  shlamim,
  minha,
  nesahim,
  hatat,
  asham,
  lehem,
  maza,
  bicurim,
  bekhor,
  maasar,
  hazaot,
  taharatMezora,
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
      "לחם": KorbanTypes.lehem,
      "מצה": KorbanTypes.maza,
      "ביכורים": KorbanTypes.bicurim,
      "בכור": KorbanTypes.bekhor,
      "מעשר": KorbanTypes.maasar,
      "הזאות": KorbanTypes.hazaot,
      "טהרת מצורע": KorbanTypes.taharatMezora,
  };

    return Korban(type: types[type]!, requirements: requirements, eatInfo: eatInfo);
  }
}
