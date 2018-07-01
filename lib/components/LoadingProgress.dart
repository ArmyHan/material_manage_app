import 'package:flutter/material.dart';

class LoadingProgress extends StatelessWidget {
  getProgressDialog() {
    return new Center(
      child: new CircularProgressIndicator(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return getProgressDialog();
  }
}
