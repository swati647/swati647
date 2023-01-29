import 'package:rsa_app/card_title.dart';
import 'package:rsa_app/gender.dart';
import 'package:flutter/material.dart';

import 'widget_utils.dart' show screenAwareSize;

class GenderCard extends StatefulWidget {
  final Gender initialGender;

  const GenderCard({required Key key, required this.initialGender}) : super(key: key);

  @override
  _GenderCardState createState() => _GenderCardState();
}
class _GenderCardState extends State<GenderCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.only(top: screenAwareSize(8.0, context)),
         child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CardTitle("GENDER"),
              Padding(
                padding: EdgeInsets.only(top: screenAwareSize(16.0, context)),
                child: _drawMainStack(),
              ),
            ],
          ),
        ),
      ),
    );
  }
   Widget _drawMainStack() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        _drawCircleIndicator(),
      ],
    );
  }

  Widget _drawCircleIndicator() {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        GenderCircle(),
      ],
    );
  }

}


class GenderCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: _circleSize(context),
      // height: _circleSize(context),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color.fromRGBO(244, 244, 244, 1.0),
      ),
    );
  }
}