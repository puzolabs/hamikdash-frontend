import 'package:hamikdash_sheli/dal/visits_repository.dart';
import 'package:hamikdash_sheli/dataTypes/visit.dart';
import 'package:hamikdash_sheli/utills/date_time_utils.dart';

class VisitsInitializer {
  List<Visit> visitList = <Visit>[];
  List<Visit> completedList = <Visit>[];

  Future initVisitLists(VisitsRepository currentVisitsRepository, VisitsRepository completedVisitsRepository) async {
    var allVisits = await currentVisitsRepository.getAll();

    await _handleCompletedVisits(allVisits, currentVisitsRepository, completedVisitsRepository);

    _sort(allVisits);

    visitList = allVisits;

    //after moving all new completed visits to its own repository - read them all
    completedList = await completedVisitsRepository.getAll();
    completedList.forEach((visit) => visit.status = Status.done);

    _sort(completedList);
  }

  Future _handleCompletedVisits(List<Visit> allVisits, VisitsRepository currentVisitsRepository, VisitsRepository completedVisitsRepository) async {
    var newCompletedVisits = allVisits
      .where((visit) => isTimePassedInJerusalem(visit.dateTime!))
      .toList();
    allVisits.removeWhere((item) => newCompletedVisits.contains(item));
    await _moveToCompletedVisitsRepository(newCompletedVisits, currentVisitsRepository, completedVisitsRepository);
  }

  Future _moveToCompletedVisitsRepository(List<Visit> completedVisits, VisitsRepository currentVisitsRepository, VisitsRepository completedVisitsRepository) async {
    for (var cv in completedVisits) {
      cv.status = Status.done;
      //todo: ______________ use transaction __________
      await completedVisitsRepository!.insert(cv);
      await currentVisitsRepository!.delete(cv.id);
     }
  }

  void _sort(List<Visit> list) {
    list.sort((v1, v2) {
      return v1.dateTime!.isBefore(v2.dateTime!)
        ? -1
        : v1.dateTime!.isAfter(v2.dateTime!)
          ? 1
          : 0;
    });
  }
}