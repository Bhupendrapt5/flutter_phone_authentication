import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_authentication/customWidgets/plateform_widget.dart';

class PlatformCircularProgressIndicator extends PlatformWidget {
  Widget show(BuildContext context) {
    return this;
  }

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return Center(
      child: CupertinoActivityIndicator(
        radius: 20.0,
      ),
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
