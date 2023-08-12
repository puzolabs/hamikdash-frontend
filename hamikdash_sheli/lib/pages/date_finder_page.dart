
import 'package:flutter/material.dart';
import 'package:hamikdash_sheli/korban.dart';
import 'coming_options_page.dart';

class DateFinderPage extends StatelessWidget {
  const DateFinderPage({
    super.key,
  });

  void _goToComingOptionsPage(BuildContext context)
  {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
            return const ComingOptionsPage();
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
                "מתי יהיה לכם נח להגיע?",
                style: Theme.of(context).textTheme.headline3,
                textAlign: TextAlign.center,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.only(left: 20),
                  child:ElevatedButton(
                    onPressed: () {
                      _goToComingOptionsPage(context);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(20),
                    ),
                    child: const Text("המשך")
                  ),
                ),
              ),
            ]
          ),
        ),
      )
    );
  }
}
