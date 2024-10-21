
import 'package:hamikdash_sheli/dataTypes/korban.dart';
import 'package:hamikdash_sheli/dataTypes/korban_case.dart';
import 'package:hamikdash_sheli/dataTypes/korbans_option.dart';

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