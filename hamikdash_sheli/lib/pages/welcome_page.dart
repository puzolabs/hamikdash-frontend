
import 'package:flutter/material.dart';
import 'package:hamikdash_sheli/utills/screen_dimension.dart';
import 'package:hamikdash_sheli/pages/visits_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({
    super.key,
  });

  void _goToVisitsPage(BuildContext context)
  {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
            return const VisitsPage();
        }
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/assets/images/western-wall.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 20.percentOfScreenHeight(context), 0, 0),
              //alignment: Alignment.topCenter,
              child: SizedBox(
                width: double.infinity,
                height: 8.percentOfScreenHeight(context),
                child: Image.asset('lib/assets/images/icon.png'),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 30.percentOfScreenHeight(context), 0, 0),
              //alignment: Alignment.topCenter,
              child: SizedBox(
                width: double.infinity,
                height: 8.percentOfScreenHeight(context),
                child: Image.asset('lib/assets/images/title.png'),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(5.percentOfScreenWidth(context), 0, 5.percentOfScreenWidth(context), 20.percentOfScreenHeight(context)), //const EdgeInsets.fromLTRB(20, 0, 20, 150),
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: double.infinity,
                height: 8.percentOfScreenHeight(context),
                child: ElevatedButton(
                  onPressed: () {
                    _goToVisitsPage(context);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(2),
                  ),
                  child: Text("התחל",
                    style: TextStyle(height: 1, fontSize: 4.percentOfScreenHeight(context)),
                  )
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}
