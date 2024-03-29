import 'package:flutter/material.dart';

class CardTitle extends StatelessWidget {
  final String title;

  const CardTitle(this.title, ) : super();

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: new TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
    );
  }
}