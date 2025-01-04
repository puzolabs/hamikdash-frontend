import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hamikdash_sheli/dal/database_provider.dart';
import 'package:hamikdash_sheli/dal/visits_repository.dart';
import 'package:hamikdash_sheli/dataTypes/korban_case.dart';
import 'package:hamikdash_sheli/dataTypes/korbans_option.dart';
import 'package:hamikdash_sheli/dataTypes/visit.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets("test saving and reading from database", (widgetTester) async {
      DatabaseProvider dp = DatabaseProvider();
      await dp.init();
      VisitsRepository vr = VisitsRepository(dp);

      Visit visit = Visit()
        ..caseCode = CaseCodes.bicurim
        ..optionCode = OptionCodes.thirdOption
        ..dateTime = DateTime(2025, 1, 3, 1, 23)
        ..uid = 'calId';

      await vr.insert(visit);

      expect(visit.id, isNotNull);
      expect(visit.id, greaterThan(0));

      var visit2 = await vr.get(visit.id);

      expect(visit2.caseCode, equals(CaseCodes.bicurim));
      expect(visit2.optionCode, equals(OptionCodes.thirdOption));
      expect(visit2.dateTime, equals(DateTime(2025, 1, 3, 1, 23)));
      expect(visit2.uid, equals('calId'));

      await dp.close();
    });
  });
}