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
}
