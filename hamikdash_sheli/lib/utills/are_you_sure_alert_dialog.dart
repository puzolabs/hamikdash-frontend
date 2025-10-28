
import 'package:flutter/material.dart';

class AreYouSureAlertDialog {
  String title;
  String content;
  String noText;
  String yesText;

  AreYouSureAlertDialog(this.title, this.content, this.noText, this.yesText);

  Future<bool> showAdaptiveConfirmationDialog(BuildContext context) async {
    final bool? confirmed = await showAdaptiveDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog.adaptive( // use native platform (Android \ iOS) alert box
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              child: Text(noText),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text(yesText),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );

    return confirmed == null || !confirmed ? false : true;
  }
}
