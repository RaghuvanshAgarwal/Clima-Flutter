import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';

class AppDialogs {
  Function _onTap;

  AppDialogs({required this._onTap});

  void locationServiceErrorDialog(BuildContext context, String message) {
    showPlatformDialog(
      context: context,
      builder: (context) => BasicDialogAlert(
        title: Text('Location'),
        content: Text(message),
        actions: <Widget>[
          BasicDialogAction(
            title: Text("OK"),
            onPressed: () {
              Navigator.pop(context);
              _onTap();
            },
          ),
        ],
      ),
    );
  }

  void clientExceptionDialog(BuildContext context, String message) {
    showPlatformDialog(
      context: context,
      builder: (context) => BasicDialogAlert(
        title: Text('Network'),
        content: Text(message),
        actions: <Widget>[
          BasicDialogAction(
            title: Text("OK"),
            onPressed: () {
              Navigator.pop(context);
              _onTap();
            },
          ),
        ],
      ),
    );
  }

  void generalErrorDialog(BuildContext context, String message) {
    showPlatformDialog(
      context: context,
      builder: (context) => BasicDialogAlert(
        title: Text('Something went Wrong'),
        content: Text(message),
        actions: <Widget>[
          BasicDialogAction(
            title: Text("OK"),
            onPressed: () {
              Navigator.pop(context);
              _onTap();
            },
          ),
        ],
      ),
    );
  }
}
