import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hamikdash_sheli/app_globals.dart';
import 'package:hamikdash_sheli/dal/database_provider.dart';
import 'package:hamikdash_sheli/dal/visits_initializer.dart';
import 'package:hamikdash_sheli/dal/visits_repository.dart';
import 'package:hamikdash_sheli/dataTypes/korban_case.dart';
import 'package:hamikdash_sheli/dataTypes/korbans_option.dart';
import 'package:hamikdash_sheli/dataTypes/visit.dart';
import 'package:integration_test/integration_test.dart';
import 'package:timezone/data/latest_10y.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  
  tz.initializeTimeZones();
  app_globals.jerusalem = tz.getLocation('Asia/Jerusalem');

  group('visits initializer tests', () {
    testWidgets("test moving completed visits to completed db", (widgetTester) async {
      DatabaseProvider dp = DatabaseProvider();
      await dp.init('bet-hamikdash-test.db');
      VisitsRepository vr = VisitsRepository(dp, "Visits");
      VisitsRepository cvr = VisitsRepository(dp, "CompletedVisits");
      vr.deleteAll();
      cvr.deleteAll();

      //past
      Visit visit1 = Visit()
        ..caseCode = CaseCodes.bicurim
        ..optionCode = OptionCodes.thirdOption
        ..dateTime = DateTime.now().toUtc().add(const Duration(days: -1))
        ..uid = 'calId1';

      await vr.insert(visit1);

      //past
      Visit visit2 = Visit()
        ..caseCode = CaseCodes.bicurim
        ..optionCode = OptionCodes.thirdOption
        ..dateTime = DateTime.now().toUtc().add(const Duration(hours: -12))
        ..uid = 'calId2';

      await vr.insert(visit2);

      //future
      Visit visit3 = Visit()
        ..caseCode = CaseCodes.bicurim
        ..optionCode = OptionCodes.thirdOption
        ..dateTime = DateTime.now().toUtc().add(const Duration(hours: 12))
        ..uid = 'calId3';

      await vr.insert(visit3);

      //future
      Visit visit4 = Visit()
        ..caseCode = CaseCodes.bicurim
        ..optionCode = OptionCodes.thirdOption
        ..dateTime = DateTime.now().toUtc().add(const Duration(hours: 6))
        ..uid = 'calId4';

      await vr.insert(visit4);

      //completed
      Visit visit5 = Visit()
        ..caseCode = CaseCodes.bicurim
        ..optionCode = OptionCodes.thirdOption
        ..dateTime = DateTime.now().toUtc().add(const Duration(days: -2))
        ..uid = 'calId5';

      await cvr.insert(visit5);

      
      VisitsInitializer vi = VisitsInitializer();
      await vi.initVisitLists(vr, cvr);

      // test that sorting by date works
      expect(vi.visitList.length, equals(2));
      expect(vi.visitList[0].uid, equals('calId4'));
      expect(vi.visitList[1].uid, equals('calId3'));

      expect(vi.completedList.length, equals(3));
      expect(vi.completedList[0].uid, equals('calId5'));
      expect(vi.completedList[1].uid, equals('calId1'));
      expect(vi.completedList[2].uid, equals('calId2'));

      await dp.close();
    });
   });
}