


import 'package:flutter/material.dart';
import 'package:hamikdash_sheli/korban.dart';
import 'package:hamikdash_sheli/widgets/korbans_widget.dart';

class SummeryPage extends StatelessWidget {
  const SummeryPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Directionality(
          textDirection: TextDirection.rtl,
          child:Text("המקדש שלי"),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "סיכום",
                style: Theme.of(context).textTheme.headline3,
                textAlign: TextAlign.center,
              ),
              KorbansWidget(korbanot: currentOrder!.korbans!),
              Row(
                children: [
                  const Text("מתי: ", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(currentOrder!.dateTime.toString()),
                ],
              ),
              if(currentOrder!.paymentAmount != null)
                Row(
                  children: [
                    const Text("שלמתם: ", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("${currentOrder!.paymentAmount} שח"),
                  ],
                ),
              TextButton(
                onPressed: () {
                  visitList.add(currentOrder!);
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                child: const Text("אישור")
              )
            ]
          ),
        ),
      )
    );
  }
}