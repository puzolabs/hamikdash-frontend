import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:hamikdash_sheli/korban.dart';

void main() {
  testWidgets('test building Korban', (WidgetTester tester) async {
    
    String json = """
		{
			"type": "שלמים",
			"requirements": "איל",
			"eat": {
				"what": "הבשר חוץ מהאימורים, האליה, החזה, שוק ימין וזרוע ימין",
				"who": "הבעלים וכל אדם טהור",
				"where": "ירושלים",
				"when": "ביום ההקרבה ובלילה שלאחריו עד חצות"
			}
		}
    """;

    var map = jsonDecode(json) as Map<String, dynamic>;

    Korban korban = Korban.fromJson(map);

    expect(korban.type, KorbanTypes.shlamim);
    expect(korban.requirements, "איל");
    expect(korban.eatInfo?.what, "הבשר חוץ מהאימורים, האליה, החזה, שוק ימין וזרוע ימין");
    expect(korban.eatInfo?.who, "הבעלים וכל אדם טהור");
    expect(korban.eatInfo?.where, "ירושלים");
    expect(korban.eatInfo?.when, "ביום ההקרבה ובלילה שלאחריו עד חצות");
  });

  testWidgets('test building KorbansOption', (WidgetTester tester) async {
    
    String json = """
    {
        "title": "אפשרות ראשונה",
        "korbanot": [
            {
                "type": "עולה",
                "requirements": "כבש"
            },
            {
                "type": "מנחה",
                "requirements": "עשרון סולת ורביעית ההין שמן"
            },
            {
                "type": "נסכים",
                "requirements": "רביעית ההין יין"
            },
            {
                "type": "חטאת",
                "requirements": "תור זכר / תור נקבה / בן יונה זכר / בן יונה נקבה"
            }
        ]
    }
    """;

    var map = jsonDecode(json) as Map<String, dynamic>;

    KorbansOption korbansOption = KorbansOption.fromJson(map);

    expect(korbansOption.name, "אפשרות ראשונה");
    expect(korbansOption.korbans.length, 4);
    expect(korbansOption.korbans[0].type, KorbanTypes.ola);
    expect(korbansOption.korbans[0].requirements, "כבש");
    expect(korbansOption.korbans[1].type, KorbanTypes.minha);
    expect(korbansOption.korbans[1].requirements, "עשרון סולת ורביעית ההין שמן");
    expect(korbansOption.korbans[2].type, KorbanTypes.nesahim);
    expect(korbansOption.korbans[2].requirements, "רביעית ההין יין");
    expect(korbansOption.korbans[3].type, KorbanTypes.hatat);
    expect(korbansOption.korbans[3].requirements, "תור זכר / תור נקבה / בן יונה זכר / בן יונה נקבה");
  });

  testWidgets('test building KorbanCase', (WidgetTester tester) async {
    
    String json = """
    {
      "code": "",
      "title": "אני נזיר/ה ומלאו ימי נזירותי",
      "korbanot": [
        {
          "type": "מנחה",
          "requirements": "עשרון סולת ורביעית ההין שמן"
        },
        {
          "type": "שלמים",
          "requirements": "איל",
          "eat": {
            "what": "הבשר חוץ מהאימורים, האליה, החזה, שוק ימין וזרוע ימין",
            "who": "הבעלים וכל אדם טהור",
            "where": "ירושלים",
            "when": "ביום ההקרבה ובלילה שלאחריו עד חצות"
          }
        }
      ],
      "korbanotOptions": [
        {
          "title": "אפשרות ראשונה",
          "korbanot": [
            {
                "type": "עולה",
                "requirements": "כבש"
            },
            {
                "type": "מנחה",
                "requirements": "עשרון סולת ורביעית ההין שמן"
            },
            {
                "type": "נסכים",
                "requirements": "רביעית ההין יין"
            },
            {
                "type": "חטאת",
                "requirements": "תור זכר / תור נקבה / בן יונה זכר / בן יונה נקבה"
            }
          ]
        }
      ]
    }
    """;

    var map = jsonDecode(json) as Map<String, dynamic>;

    KorbanCase korbanCase = KorbanCase.fromJson(map);

    expect(korbanCase.title, "אני נזיר/ה ומלאו ימי נזירותי");
    expect(korbanCase.korbanot?.length, 2);
    expect(korbanCase.korbanot?[0].type, KorbanTypes.minha);
    expect(korbanCase.korbanot?[0].requirements, "עשרון סולת ורביעית ההין שמן");
    expect(korbanCase.korbanot?[0].eatInfo, null);
    expect(korbanCase.korbanot?[1].type, KorbanTypes.shlamim);
    expect(korbanCase.korbanot?[1].requirements, "איל");
    expect(korbanCase.korbanot?[1].eatInfo?.what, "הבשר חוץ מהאימורים, האליה, החזה, שוק ימין וזרוע ימין");
    expect(korbanCase.korbanot?[1].eatInfo?.who, "הבעלים וכל אדם טהור");
    expect(korbanCase.korbanot?[1].eatInfo?.where, "ירושלים");
    expect(korbanCase.korbanot?[1].eatInfo?.when, "ביום ההקרבה ובלילה שלאחריו עד חצות");
    expect(korbanCase.korbanotOptions?.length, 1);
    expect(korbanCase.korbanotOptions?[0].name, "אפשרות ראשונה");
    expect(korbanCase.korbanotOptions?[0].korbans.length, 4);
    expect(korbanCase.korbanotOptions?[0].korbans[0].type, KorbanTypes.ola);
    expect(korbanCase.korbanotOptions?[0].korbans[0].requirements, "כבש");
    expect(korbanCase.korbanotOptions?[0].korbans[1].type, KorbanTypes.minha);
    expect(korbanCase.korbanotOptions?[0].korbans[1].requirements, "עשרון סולת ורביעית ההין שמן");
    expect(korbanCase.korbanotOptions?[0].korbans[2].type, KorbanTypes.nesahim);
    expect(korbanCase.korbanotOptions?[0].korbans[2].requirements, "רביעית ההין יין");
    expect(korbanCase.korbanotOptions?[0].korbans[3].type, KorbanTypes.hatat);
    expect(korbanCase.korbanotOptions?[0].korbans[3].requirements, "תור זכר / תור נקבה / בן יונה זכר / בן יונה נקבה");
  });
}
