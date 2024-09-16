
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
              margin: const EdgeInsets.only(right: 25, bottom: 25),
              child: Text("הנכם מוזמנים ב ${DateFormat('EEEE, MMM d, yyyy HH:mm').format(visit.dateTime!)}",
                style: const TextStyle(fontSize: 18)
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
