
import 'package:flutter/material.dart';
import 'package:hamikdash_sheli/korban.dart';
import 'package:hamikdash_sheli/widgets/korbans_widget.dart';

class KorbansSummeryWidget extends StatelessWidget {
  const KorbansSummeryWidget({
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
          Row(
            children: [
              const Text("מתי: ", style: TextStyle(fontWeight: FontWeight.bold)),
              Text(visit.dateTime.toString()),
            ],
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
