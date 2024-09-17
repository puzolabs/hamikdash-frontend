


import 'package:flutter/material.dart';
import 'package:hamikdash_sheli/korban.dart';
import 'package:hamikdash_sheli/pages/payment_page.dart';
import 'package:hamikdash_sheli/pages/summery_page.dart';

class ComingOptionsPage extends StatelessWidget {
  const ComingOptionsPage({
    super.key,
  });

  void _goToPaymentPage(BuildContext context)
  {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
            return const PaymentPage();
        }
      )
    );
  }

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
                "איך אתם מגיעים עם הפריטים?",
                style: Theme.of(context).textTheme.headline3,
                textAlign: TextAlign.center,
              ),
              Card(
                child: ListTile(
                  leading: const FlutterLogo(),
                  title: Text(
                    "תכינו לי את כל הפריטים",
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  onTap: () {
                    currentVisit!.comingOption = ComingOption.prepareAllForMe;
                    _goToPaymentPage(context);
                  },
                )
              ),
              Card(
                child: ListTile(
                  leading: const FlutterLogo(),
                  title: Text(
                    "מביא/ה בעצמי את כל הפריטים",
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  onTap: () {
                    currentVisit!.comingOption = ComingOption.bringingAllWithMe;
                    _goToSummeryPage(context);
                  },
                ),
              ),
            ]
          ),
        ),
      )
    );
  }
}
