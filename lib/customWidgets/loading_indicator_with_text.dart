import 'package:flutter/material.dart';
import 'package:mobile_authentication/customWidgets/platform_circle_indicator.dart';
import 'package:mobile_authentication/helper/utility.dart';

class LoadingIndicatorWithMessage extends StatelessWidget {
  final String text;

  const LoadingIndicatorWithMessage({
    Key key,
    @required this.text,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Utility().getSize(context).height * 0.25,
      width: Utility().getSize(context).width * 0.30,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PlatformCircularProgressIndicator().show(context),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(text),
            )
          ],
        ),
      ),
    );
  }
}
