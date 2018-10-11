class User {
//  String _email;
  String _token;
  User(this._token);

  User.map(dynamic obj) {
    this._token = obj["auth_token"];
//    this._password = obj["password"];
  }

  String get token => _token;
//  String get password => _password;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["token"] = token;
//    map["password"] = _password;

    return map;
  }
}

//class Token {
//  String _token;
//
//  Token(this._token);
//
//  Token.map(dynamic obj) {
//    this._token = obj["auth_token"]
//  }
//
//  String get token => _token;
//
//  Map<String, dynamic> toMap() {
//    var map = new Map<String, dynamic>();
//    map["token"] = token;
//    return map;
//  }
//}