import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_authentication/customWidgets/plateform_widget.dart';

class PlatFormAlertDialogBox extends PlatformWidget {
  final String title;
  final String content;
  final String defaultActionText;
  final String cancelActionText;

  PlatFormAlertDialogBox({
    @required this.title,
    @required this.content,
    @required this.defaultActionText,
    this.cancelActionText,
  })  : assert(title != null),
        assert(content != null),
        assert(defaultActionText != null);

  Future<bool> show(BuildContext context) async {
    return Platform.isIOS
        ? await showCupertinoDialog<bool>(
            context: context,
            builder: (context) => this,
          )
        : await showDialog<bool>(
            context: context,
            barrierDismissible: false,
            builder: (context) => this,
          );
  }

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: _buildWidget(context),
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: _buildWidget(context),
    );
  }

  List<Widget> _buildWidget(BuildContext context) {
    final actions = <Widget>[];
    if (cancelActionText != null) {
      actions.add(
        PlatformAlertDialogAction(
          callback: () => Navigator.pop(context, false),
          widget: Text(cancelActionText),
        ),
      );
    }
    actions.add(
      PlatformAlertDialogAction(
        callback: () => Navigator.pop(context, true),
        widget: Text(defaultActionText),
      ),
    );

    return actions;
  }
}

class PlatformAlertDialogAction extends PlatformWidget {
  final Widget widget;
  final VoidCallback callback;

  PlatformAlertDialogAction({
    @required this.widget,
    @required this.callback,
  });
  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return CupertinoDialogAction(
      child: widget,
      onPressed: callback,
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return FlatButton(
      onPressed: callback,
      child: widget,
    );
  }
}
