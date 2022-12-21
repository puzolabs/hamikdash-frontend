


import 'package:flutter/material.dart';
import 'package:hamikdash_sheli/korban.dart';
import 'package:hamikdash_sheli/widgets/visit_widget.dart';

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
              VisitWidget(visit: currentVisit!),
              TextButton(
                onPressed: () {
                  visitList.add(currentVisit!);
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
