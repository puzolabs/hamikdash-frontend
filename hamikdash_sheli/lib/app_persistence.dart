
import 'package:hamikdash_sheli/app_state.dart';
import 'package:hamikdash_sheli/dal/database_provider.dart';
import 'package:hamikdash_sheli/dal/visits_repository.dart';

class AppPersistence {
  DatabaseProvider dp = DatabaseProvider();
  VisitsRepository? currentVisitsRepository;

  Future load() async {
    await dp.init();
    
    currentVisitsRepository = VisitsRepository(dp, "Visits");
    appState.visitList = await currentVisitsRepository!.getAll();
  }

  Future close() async {
    await dp.close();
  }
}

AppPersistence appPersistence = AppPersistence();
