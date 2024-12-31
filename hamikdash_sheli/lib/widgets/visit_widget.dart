
import 'package:flutter/material.dart';
import 'package:hamikdash_sheli/dataTypes/visit.dart';
import 'package:hamikdash_sheli/services/visit_data_retriever.dart';
import 'package:intl/intl.dart';
import 'package:hamikdash_sheli/widgets/korbans_widget.dart';

class VisitWidget extends StatelessWidget {
  const VisitWidget({
    super.key,
    required this.visit,
  });

  final Visit visit;

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
              child: Text(DateFormat('EEEE, MMM d, yyyy').format(visit.dateTime!),
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
              child: Text(DateFormat('HH:mm').format(visit.dateTime!),
                style: const TextStyle(fontSize: 28)
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
