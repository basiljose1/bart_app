//
//class User {
////  String _email;
//  String _token;
//  User(this._token);
//
//  User.map(dynamic obj) {
//    this._token = obj["auth_token"];
////    this._password = obj["password"];
//  }
//
//  String get token => _token;
////  String get password => _password;
//
//  Map<String, dynamic> toMap() {
//    var map = new Map<String, dynamic>();
//    map["token"] = token;
////    map["password"] = _password;
//
//    return map;
//  }
//}


class User {
  final String email;
  final String phone;
  final String name;
  final String shop_name;
  final String avatar;
  final String location;
  final String latitude;
  final String longitude;

  User({this.email,this.phone,this.name,this.shop_name,this.avatar,this.location,this.latitude,this.longitude});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email : json["email"],
      phone : json["phone"],
      name : json["name"],
      shop_name : json["shop_name"],
      avatar : json["avatar"],
      location : json["location"],
      latitude : json["latitude"],
      longitude : json["longitude"],
    );
  }
}