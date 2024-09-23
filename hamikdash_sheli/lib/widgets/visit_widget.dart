
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hamikdash_sheli/korban.dart';
import 'package:hamikdash_sheli/widgets/korbans_widget.dart';

class VisitWidget extends StatelessWidget {
  const VisitWidget({
    super.key,
    required this.visit,
  });

  final Visit visit;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          KorbansWidget(korbanot: visit.korbans!),
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
