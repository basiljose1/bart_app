import 'dart:async';
import 'dart:convert';
import 'package:bart_app/utils/network_util.dart';
import 'package:bart_app/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:bart_app/utils/shared_pref.dart';



class RestDatasource {
  NetworkUtil _netUtil = new NetworkUtil();
  static final BASE_URL = "https://bartapp.tk";
  static final LOGIN_URL = BASE_URL + "/api/auth/token/login/";
//  static final _API_KEY = "somerandomkey";

  Future<String> login(String email, String password) {
    return _netUtil.post(LOGIN_URL, body: {
//      "token": _API_KEY,
      "email": email,
      "password": password
    }).then((dynamic res) {
      if(res.containsKey("auth_token")) {
        return res["auth_token"];
      } else {
        return "Login Failed";
      }
    });
  }

  Future<User> fetchUser() async {
    String token = await getMobileToken();
    print(token);
    final response =
    await http.get('https://bartapp.tk/api/auth/me/',headers: {"Authorization": "Token "+token});

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return User.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load User');
    }
  }
}
