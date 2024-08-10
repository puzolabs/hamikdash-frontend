
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
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 150),
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: double.infinity,
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
