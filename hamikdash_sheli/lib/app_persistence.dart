
import 'package:hamikdash_sheli/app_state.dart';
import 'package:hamikdash_sheli/dal/database_provider.dart';
import 'package:hamikdash_sheli/dal/visits_repository.dart';

class AppPersistence {
  DatabaseProvider dp = DatabaseProvider();
  VisitsRepository? currentVisits;

  Future load() async {
    await dp.init();
    
    currentVisits = VisitsRepository(dp, "Visits");
    appState.visitList = await currentVisits!.getAll();
  }

  Future close() async {
    await dp.close();
  }
}

AppPersistence appPersistence = AppPersistence();
