import 'dart:async';

import 'package:bart_app/utils/network_util.dart';
import 'package:bart_app/models/user.dart';

class RestDatasource {
  NetworkUtil _netUtil = new NetworkUtil();
  static final BASE_URL = "https://bartapp.tk";
  static final LOGIN_URL = BASE_URL + "/api/auth/token/login/";
//  static final _API_KEY = "somerandomkey";

  Future<User> login(String email, String password) {
    return _netUtil.post(LOGIN_URL, body: {
//      "token": _API_KEY,
      "email": email,
      "password": password
    }).then((dynamic res) {
      if(res.containsKey("auth_token")) {
        return new User.map(res);
      } else {
        print("Login Failed");
        throw new Exception("Login Failed");
      }
    });
  }
}