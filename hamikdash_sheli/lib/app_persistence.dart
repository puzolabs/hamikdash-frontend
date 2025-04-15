import 'package:hamikdash_sheli/app_state.dart';
import 'package:hamikdash_sheli/dal/database_provider.dart';
import 'package:hamikdash_sheli/dal/visits_initializer.dart';
import 'package:hamikdash_sheli/dal/visits_repository.dart';

class AppPersistence {
  DatabaseProvider dp = DatabaseProvider();
  VisitsRepository? currentVisitsRepository;
  VisitsRepository? completedVisitsRepository;

  Future load() async {
    await dp.init('bet-hamikdash.db');
    
    currentVisitsRepository = VisitsRepository(dp, "Visits");
    completedVisitsRepository = VisitsRepository(dp, "CompletedVisits");
  }

  Future initVisitLists() async {
    VisitsInitializer vi = VisitsInitializer();
    await vi.initVisitLists(currentVisitsRepository!, completedVisitsRepository!);

    appState.visitList = vi.visitList;
    appState.completedList = vi.completedList;
  }

  Future close() async {
    await dp.close();
  }
}

AppPersistence appPersistence = AppPersistence();
