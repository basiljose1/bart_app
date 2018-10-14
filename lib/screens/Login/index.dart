import 'dart:io';
import 'package:flutter/material.dart';
import 'styles.dart';
import 'loginAnimation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/animation.dart';
import 'dart:async';
import '../../components/SignInButton.dart';
import '../../components/Logo.dart';
import 'package:flutter/services.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:bart_app/data/rest_ds.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);
  @override
  LoginScreenState createState() => new LoginScreenState();
}

class LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  AnimationController _loginButtonController;
  var animationStatus = 0;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  String _password, _email;

  @override
  void initState() {
    super.initState();
    _loginButtonController = new AnimationController(
        duration: new Duration(milliseconds: 3000), vsync: this);
  }

  @override
  void dispose() {
    _loginButtonController.dispose();
    super.dispose();
  }

  Future<Null> _playAnimation() async {
    try {
      await _loginButtonController.forward();
      await _loginButtonController.reverse();
    } on TickerCanceled {}
  }

  Future<bool> _onWillPop() async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('Are you sure want to exit'),
          actions: <Widget>[
            new FlatButton(
              child: new Text('No'),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            new FlatButton(
              onPressed:()=> exit(0),
              child: new Text('Yes'),
            ),
          ],
        );
      },
    ) ?? false;
  }

  void _submit() {
    final form = formKey.currentState;
    RestDatasource api = new RestDatasource();

    if (form.validate()) {
      api.login(_email, _password).then((String token) {
        print(token);
//        view.onLoginSuccess(user);
        });
//          .catchError((Exception error) => _view.onLoginError(error.toString()));
      setState(() {
        animationStatus = 1;
      });
      _playAnimation();
      form.save();
    }
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 0.4;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return (new WillPopScope(
        onWillPop: _onWillPop,
        child: new Scaffold(
          body: new Container(
              decoration: new BoxDecoration(
                image: backgroundImage,
              ),
              child: new Container(
                  child: new ListView(
                    padding: const EdgeInsets.all(0.0),
                    children: <Widget>[
                      new Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: <Widget>[
                          new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 100.0, bottom: 60.0),
                                child: new Logo(image: tick),
                              ),
//                              Form
                              new Container(
                                margin: new EdgeInsets.symmetric(horizontal: 20.0),
                                child: new Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    new Form(
                                        key: formKey,
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
                                                onSaved: (val) => _email = val,
                                                validator: (val) {
                                                  return validateEmail(val);
                                                },
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
                                                onSaved: (val) => _password = val,
                                                validator: (val) {
                                                  return val.length < 8
                                                      ? "Password must have atleast 8 chars"
                                                      : null;
                                                },
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
                              ),

                              new FlatButton(
                                padding: const EdgeInsets.only(
                                  top: 160.0,
                                ),
                                onPressed: null,
                                child: new Text(
                                  "Don't have an account? Sign Up",
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  style: new TextStyle(
                                      fontWeight: FontWeight.w300,
                                      letterSpacing: 0.5,
                                      color: Colors.white,
                                      fontSize: 12.0),
                                ),
                              )
                            ],
                          ),
                          animationStatus == 0
                              ? new Padding(
                                  padding: const EdgeInsets.only(bottom: 50.0),
                                  child: new InkWell(
                                      onTap: () {
                                        _submit();
                                      },
                                      child: new SignIn()),
                                )
                              : new StaggerAnimation(
                                  buttonController:
                                      _loginButtonController.view),
                        ],
                      ),
                    ],
                  ))),
        )));
  }
}
