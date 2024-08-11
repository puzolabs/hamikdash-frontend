
import 'package:flutter/material.dart';
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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

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
              padding: EdgeInsets.fromLTRB(0, screenHeight * 0.2, 0, 0),
              //alignment: Alignment.topCenter,
              child: SizedBox(
                width: double.infinity,
                height: screenHeight * 0.08,
                child: Image.asset('lib/assets/images/icon.png'),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(screenWidth * 0.05, 0, screenWidth * 0.05, screenHeight * 0.2), //const EdgeInsets.fromLTRB(20, 0, 20, 150),
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: double.infinity,
                height: screenHeight * 0.08,
                child: ElevatedButton(
                  onPressed: () {
                    _goToVisitsPage(context);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(2),
                  ),
                  child: const Text("התחל")
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}
