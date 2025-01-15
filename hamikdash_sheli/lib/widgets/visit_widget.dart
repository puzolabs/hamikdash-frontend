
import 'package:flutter/material.dart';
import 'package:hamikdash_sheli/dataTypes/event_data.dart';
import 'package:hamikdash_sheli/dataTypes/visit.dart';
import 'package:hamikdash_sheli/services/visit_data_retriever.dart';
import 'package:hamikdash_sheli/utills/list_enhancements.dart';
import 'package:intl/intl.dart' as intl;
import 'package:hamikdash_sheli/widgets/korbans_widget.dart';

class VisitWidget extends StatelessWidget {
  const VisitWidget({
    super.key,
    required this.visit,
  });

  final Visit visit;

  DateTime _getEndTime() {
    var eventData =
      eventMap.findFirst((element) => element.caseCode == visit.caseCode && element.optionCode == visit.optionCode) ??
      eventMap.findFirst((element) => element.caseCode == visit.caseCode);
    
    if(eventData == null) {
      //since this situation should never happen, log this to remote monitoring service and alert it
      return visit.dateTime!.add(const Duration(minutes: 15));
    }

    return visit.dateTime!.add(eventData.duration);
  }

  @override
  Widget build(BuildContext context) {
    VisitDataRetriever vdr = VisitDataRetriever(visit:visit);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              margin: const EdgeInsets.only(right: 25, top:25),
              child: const Text('🗒️ נושא' ,
                style: TextStyle(fontSize: 18)
              )
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              margin: const EdgeInsets.only(right: 25, bottom: 25),
              child: Text(vdr.getTitle(),
                style: const TextStyle(fontSize: 28)
              ),
            ),
          ),
          KorbansWidget(korbanot: vdr.getKorbans()!),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              margin: const EdgeInsets.only(right: 25, top: 25),
              child: const Text('📅 תאריך' ,
                style: TextStyle(fontSize: 18)
              )
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              margin: const EdgeInsets.only(right: 25),
              child: Text(intl.DateFormat('EEEE, MMM d, yyyy').format(visit.dateTime!),
                style: const TextStyle(fontSize: 28)
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              margin: const EdgeInsets.only(right: 25, top: 25),
              child: const Text('🕜 שעה' ,
                style: TextStyle(fontSize: 18)
              )
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              margin: const EdgeInsets.only(right: 25),
              child: Directionality(
                textDirection: TextDirection.ltr, // even in RTL languages (e.g. Hebrew) we display time range from left to right
                child: Text("${intl.DateFormat('HH:mm').format(visit.dateTime!)} - ${intl.DateFormat('HH:mm').format(_getEndTime())}",
                  style: const TextStyle(fontSize: 28)
                )
              ),
            ),
          ),
          if(visit.paymentAmount != null)
            Row(
              children: [
                const Text("שלמתם: ", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("${visit.paymentAmount} שח"),
              ],
            ),
        ]
      ),
    );
  }
}
