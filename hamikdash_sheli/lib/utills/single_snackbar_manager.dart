import 'package:flutter/material.dart';

class SingleSnackbarManager {
  String content;
  String action;
  bool _isSnackbarActive = false;

  SingleSnackbarManager(this.content, this.action);
  
  void showToast(BuildContext context) {
    if(_isSnackbarActive) {
      return;
    }

    _isSnackbarActive = true;

    final scaffold = ScaffoldMessenger.of(context);

    scaffold
      .showSnackBar(
        SnackBar(
          content: Text(content),
          action: SnackBarAction(label: action, onPressed: scaffold.hideCurrentSnackBar),
        ),
      )
      .closed
        .then((SnackBarClosedReason reason) {
        _isSnackbarActive = false ;
      });
  }
}