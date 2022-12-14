
import 'package:flutter/material.dart';
import 'package:hamikdash_sheli/pages/coming_options_page.dart';
import 'package:hamikdash_sheli/widgets/korban_widget.dart';
import 'package:hamikdash_sheli/korban.dart';

class KorbansOptionWidget extends StatelessWidget {
  const KorbansOptionWidget({
    super.key,
    required this.korbanotOption,
  });

  final KorbansOption korbanotOption;

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
                    currentOrder.korbans = korbanotOption.korbans;
                    _goToComingOptionsPage(context);
                  },
                ),
              ],
            ),
          ],
        ),
      );
  }
}
