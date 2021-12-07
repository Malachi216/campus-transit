import 'package:flutter/material.dart';

class PageNotFoundWidget extends StatelessWidget {
  final Uri uri;
  const PageNotFoundWidget({
    Key key,this.uri,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Page ${uri.path} not found'),
      ),
    );
  }
}
