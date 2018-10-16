import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
//  final Animation<double> buttonGrowAnimation;
  AddButton();
  @override
  Widget build(BuildContext context) {
    return (
    new Container(
      width: 60.0,
      height: 60.0,
      alignment: FractionalOffset.center,
      decoration: new BoxDecoration(
          color: const Color.fromRGBO(247, 64, 106, 1.0),
          shape: BoxShape.circle),
      child: new Icon(
        Icons.add,
        size: 40.0,
        color: Colors.white,
      ),
    ));
  }
}
