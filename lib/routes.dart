import 'package:flutter/material.dart';
import 'package:bart_app/screens/Login/index.dart';
import 'package:bart_app/screens/Home/index.dart';
import 'package:bart_app/utils/shared_pref.dart';

class Routes {
  // Set default home.
  Widget _defaultHome = new LoginScreen();
  // Get result of the login function.
  String _result = _getMobileToken();
  if (_result) {
    _defaultHome = new HomeScreen();
  }
  Routes() {
    runApp(new MaterialApp(
      title: "Bart App",
      debugShowCheckedModeBanner: false,
      home: _defaultHome,
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/login':
            return new MyCustomRoute(
              builder: (_) => new LoginScreen(),
              settings: settings,
            );

          case '/home':
            return new MyCustomRoute(
              builder: (_) => new HomeScreen(),
              settings: settings,
            );

          case '/':
            return new MyCustomRoute(
              builder: (_) => new LoginScreen(),
              settings: settings,
            );
        }
      },
    ));
  }
}

class MyCustomRoute<T> extends MaterialPageRoute<T> {
  MyCustomRoute({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (settings.isInitialRoute) return child;
    return new FadeTransition(opacity: animation, child: child);
  }
}
