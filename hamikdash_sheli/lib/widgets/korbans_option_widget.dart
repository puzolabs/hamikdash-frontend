
import 'package:flutter/material.dart';
import 'package:hamikdash_sheli/widgets/korbans_widget.dart';
import 'package:hamikdash_sheli/korban.dart';

import '../pages/date_selection_page.dart';

class KorbansOptionWidget extends StatelessWidget {
  const KorbansOptionWidget({
    super.key,
    required this.korbanotOption,
  });

  final KorbansOption korbanotOption;

  void _goToDateSelectionPage(BuildContext context)
  {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
            return const DateSelectionPage(mode: DateSelectionMode.create);
        }
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            korbanotOption.name,
            style: Theme.of(context).textTheme.headline4,
          ),
          KorbansWidget(korbanot: korbanotOption.korbans),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.only(left: 20, bottom: 20),
              child: ElevatedButton(
                onPressed: () {
                  currentVisit!.korbans = korbanotOption.korbans;
                  _goToDateSelectionPage(context);
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(20),
                ),
                child: const Text("בחר")
              ),
            ),
          ),
        ],
      );
  }
}
