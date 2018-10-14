import 'package:flutter/material.dart';
import './InputFields.dart';

class FormContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return (
    new Container(
      margin: new EdgeInsets.symmetric(horizontal: 20.0),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new Form(
              child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
            new Container(
              decoration: new BoxDecoration(
                border: new Border(
                  bottom: new BorderSide(
                    width: 0.5,
                    color: Colors.white24,
                  ),
                ),
              ),
              child: new TextFormField(
                obscureText: false,
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: new InputDecoration(
                icon: new Icon(
                  Icons.person_outline,
                  color: Colors.white,
                ),
                border: InputBorder.none,
                hintText: "Email",
                hintStyle: const TextStyle(color: Colors.white, fontSize: 15.0),
                contentPadding: const EdgeInsets.only(
                  top: 30.0, right: 30.0, bottom: 30.0, left: 5.0),
                ),
              ),
            ),

            new Container(
              decoration: new BoxDecoration(
                border: new Border(
                  bottom: new BorderSide(
                    width: 0.5,
                    color: Colors.white24,
                  ),
                ),
              ),
              child: new TextFormField(
                obscureText: true,
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: new InputDecoration(
                  icon: new Icon(
                    Icons.lock_outline,
                    color: Colors.white,
                  ),
                  border: InputBorder.none,
                  hintText: "Password",
                  hintStyle: const TextStyle(color: Colors.white, fontSize: 15.0),
                  contentPadding: const EdgeInsets.only(
                      top: 30.0, right: 30.0, bottom: 30.0, left: 5.0),
                ),
              ),
            )
            ],
          )),
        ],
      ),
    ));
  }
}
