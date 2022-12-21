
import 'package:flutter/material.dart';
import 'package:hamikdash_sheli/widgets/korban_widget.dart';
import 'package:hamikdash_sheli/korban.dart';

import '../pages/date_finder_page.dart';

class KorbansOptionWidget extends StatelessWidget {
  const KorbansOptionWidget({
    super.key,
    required this.korbanotOption,
  });

  final KorbansOption korbanotOption;

  void _goToDateFinderPage(BuildContext context)
  {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
            return const DateFinderPage();
        }
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return
      Card(
        child: ListView(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          children: <Widget>[
            Text(
              korbanotOption.name,
              style: Theme.of(context).textTheme.headline4,
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: korbanotOption.korbans.length,
                itemBuilder: (BuildContext context, int index) {
                  return KorbanWidget(korban: korbanotOption.korbans[index]);
                },
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
              )
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: const Text('בחר'),
                  onPressed: () {
                    currentVisit!.korbans = korbanotOption.korbans;
                    _goToDateFinderPage(context);
                  },
                ),
              ],
            ),
          ],
        ),
      );
  }
}
