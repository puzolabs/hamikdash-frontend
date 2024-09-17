


import 'package:flutter/material.dart';
import 'package:hamikdash_sheli/korban.dart';
import 'package:hamikdash_sheli/pages/summery_page.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({
    super.key,
  });

  void _goToSummeryPage(BuildContext context)
  {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
            return SummeryPage();
        }
      )
    );
  }

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
                "תשלום",
                style: Theme.of(context).textTheme.headline3,
                textAlign: TextAlign.center,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: ElevatedButton(
                  onPressed: () {
                    _goToSummeryPage(context);
                  },
                  child: const Text("המשך")
                ),
              ),
            ]
          ),
        ),
      )
    );
  }
}
