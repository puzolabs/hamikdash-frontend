


import 'package:flutter/material.dart';
import 'package:hamikdash_sheli/korban.dart';

class ComingOptionsPage extends StatelessWidget {
  const ComingOptionsPage({
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
                "איך אתם מגיעים עם הפרטים?",
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
                    currentOrder.comingOption = ComingOption.prepareAllForMe;
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
                    currentOrder.comingOption = ComingOption.bringingAllWithMe;
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
