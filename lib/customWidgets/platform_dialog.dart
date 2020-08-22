import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_authentication/customWidgets/plateform_widget.dart';

class PlatFormDialogBox extends PlatformWidget {
  final Widget content;

  PlatFormDialogBox({
    @required this.content,
  });

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
    return Dialog(
      child: content,
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return Dialog(
      child: content,
    );
  }
}
