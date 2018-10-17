import 'package:flutter/material.dart';
import '../../components/Logo.dart';
import 'package:bart_app/screens/Login/styles.dart';
import 'package:flutter_google_places_autocomplete/flutter_google_places_autocomplete.dart';
import 'dart:async';

const kGoogleApiKey = "AIzaSyAidWwNLnELWOwwtpANdnSLPkqm5dvcFkc";

// to get places detail (lat/lng)
GoogleMapsPlaces _places = new GoogleMapsPlaces(kGoogleApiKey);

Future<Null> displayPrediction(Prediction p, ScaffoldState scaffold) async {
  if (p != null) {
    // get detail (lat/lng)
    PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId);
    final lat = detail.result.geometry.location.lat;
    final lng = detail.result.geometry.location.lng;

    scaffold.showSnackBar(
        new SnackBar(content: new Text("${p.description} - $lat/$lng")));
  }
}

class RegisterShop extends StatefulWidget {
  @override
  _RegisterShopState createState() => new _RegisterShopState();
}
final homeScaffoldKey = new GlobalKey<ScaffoldState>();
final searchScaffoldKey = new GlobalKey<ScaffoldState>();

class _RegisterShopState extends State<RegisterShop> {
  Mode _mode = Mode.overlay;
  TextEditingController _c ;

  @override
  void initState() {
    _c = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,

        leading: new Padding(
          padding: const EdgeInsets.all(8.0),
          child:
          new CircleAvatar(
            backgroundImage:AssetImage('assets/logo.png'),
          ),
        ),
        title: Text("Let's bart", style: TextStyle(fontWeight: FontWeight.w200, color: Colors.black),),
        actions: <Widget>[
          new BackButton(
              color: Colors.black
          ),
        ],
      ),
      backgroundColor: Colors.white,
      key: homeScaffoldKey,
      body: Center(
        child: loginBody(),
      ),
    );
  }

  loginBody() => SingleChildScrollView(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[loginFields()],
    ),
  );

  loginHeader() => Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      SizedBox(
        height: 50.0,
      ),
      Logo(image: tick,),
      SizedBox(
        height: 30.0,
      ),
      Text(
        "Welcome to Bart",
        style: TextStyle(fontWeight: FontWeight.w700, color: Color.fromRGBO(247, 64, 106, 1.0)),
      ),
      SizedBox(
        height: 5.0,
      ),
    ],
  );

  loginFields() => Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[

//        new RaisedButton(
//            onPressed: () async {
//              // show input autocomplete with selected mode
//              // then get the Prediction selected
//              Prediction p = await showGooglePlacesAutocomplete(
//                  context: context,
//                  apiKey: kGoogleApiKey,
//                  onError: (res) {
//                    homeScaffoldKey.currentState.showSnackBar(
//                        new SnackBar(content: new Text(res.errorMessage)));
//                  },
//                  mode: Mode.overlay,
//                  language: "en",
//                  components: [new Component(Component.country, "in")]);
//                  if (p != null) {
//                    PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId);
//                    final lat = detail.result.geometry.location.lat;
//                    final lng = detail.result.geometry.location.lng;
//
//                    setState((){
//                      _c.text = "${p.description} - $lat/$lng";
//                    });
//                  }
//            },
//            child: new Text("Search places")),
        Container(
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 30.0),
          child: TextField(
            maxLines: 1,
            decoration: InputDecoration(
              hintText: "Enter your name",
              labelText: "Name",
            ),
          ),
        ),

        Container(
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 30.0),
          child: TextField(
            maxLines: 1,
            decoration: InputDecoration(
              hintText: "Enter your email",
              labelText: "Email",
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 30.0),
          child: TextField(
            maxLines: 1,
            decoration: InputDecoration(
              hintText: "Enter your shop name",
              labelText: "Shop Name",
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 30.0),
          child: PlacesAutocompleteFormField(
            apiKey:kGoogleApiKey,
            hint:"Shop Location",
            controller: _c,
            mode:Mode.overlay,
            onSaved: (val) => print(val),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 30.0),
          child: TextField(
            maxLines: 1,
            decoration: InputDecoration(
              hintText: "Enter your phone number",
              labelText: "Phone Number",
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
          child: TextField(
            maxLines: 1,
            obscureText: true,
            decoration: InputDecoration(
              hintText: "Enter your password",
              labelText: "Password",
            ),
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
          width: 280.0,
          height: 60.0,
          child: RaisedButton(
            padding: EdgeInsets.all(12.0),
            shape: StadiumBorder(),
            child: Text(
              "Own a shop",
              style: TextStyle(color: Colors.white, fontSize: 22.00),
            ),
            color: const Color.fromRGBO(247, 64, 106, 1.0),
            onPressed: () {},
          ),
        ),
        SizedBox(
          height: 5.0,
        ),

      ],
    ),
  );
}