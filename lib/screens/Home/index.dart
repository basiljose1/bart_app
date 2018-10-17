import 'package:flutter/material.dart';
import 'styles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/animation.dart';
import 'dart:async';
import '../../components/ListViewContainer.dart';
import '../../components/AddButton.dart';
import '../../components/HomeTopView.dart';
import '../../components/FadeContainer.dart';
import 'homeAnimation.dart';
import 'package:intl/intl.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flushbar/flushbar.dart';
import 'package:bart_app/utils/shared_pref.dart';
import 'package:bart_app/components/profile_tile.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  HomeScreenState createState() => new HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {

  var animateStatus = 0;
  var deviceSize;
  @override
  void initState() {
    super.initState();
  }
  void _logout() {
    setState(() {
      animateStatus = 1;
    });
    setMobileToken("");
  }

  final makeBottom = Container(
    height: 55.0,
    child: BottomAppBar(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.home, color: Colors.black87),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.blur_on, color: Colors.black87),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.hotel, color: Colors.black87),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.account_box, color: Colors.black87),
            onPressed: () {},
          )
        ],
      ),
    ),
  );

Widget profileDetails() => Container(
  height: deviceSize.height * 0.24,
  child: Container(
    padding: EdgeInsets.all(5.00),
    decoration: new BoxDecoration(color: Colors.blueAccent),
    child: new Column(
      children: <Widget>[
        new Row(
    children: <Widget>[
      new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Container(
            alignment: AlignmentDirectional.center,
            child: new Image.asset(
              'assets/logo.png',
              height: 60.0,
              fit: BoxFit.cover,
            ),
          ),
        ]
      ),
      new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children:<Widget>[
              new Container(
                padding: EdgeInsets.only(top: 20.00, left: 20.0),
//                  width: 200.0,
                child: new Text ("Basil Jose", style: TextStyle(fontSize: 25.0, color: Colors.white),textAlign: TextAlign.left,),
              ),
              new Container(
                child: new IconButton(icon: new Icon(Icons.mode_edit, color: Colors.white,), onPressed: null,padding: EdgeInsets.only(top: 20.00),alignment: AlignmentDirectional.centerEnd,),
              )
             ]
          ),
          new Row(
              mainAxisAlignment:MainAxisAlignment.center ,
              children:<Widget>[
                new Container(
                  padding:EdgeInsets.only(left: 8.00),
                    child: new InkWell(
                      onTap: null,
                      child: FlatButton.icon(onPressed: null, icon:  new Icon(FontAwesomeIcons.facebookMessenger, color: Colors.white,), label: new Text("Messenger", style: TextStyle(color: Colors.white),)),
                    ),
                ),
                new Container(
                  child: new InkWell(
                    onTap: null,
                    child: FlatButton.icon(onPressed: null, icon:  new Icon(FontAwesomeIcons.whatsapp, color: Colors.white,), label: new Text("Whats app", style: TextStyle(color: Colors.white),)),
                  ),
                )

              ]
          ),
          new Row(
              mainAxisAlignment:MainAxisAlignment.start ,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:<Widget>[
                new Container(
                  padding:EdgeInsets.only(left: 8.00),
                  child: new InkWell(
                    onTap: null,
                    child: FlatButton.icon(onPressed: null, icon:  new Icon(FontAwesomeIcons.mapMarkedAlt, color: Colors.white,), label: new Text("#3 Kakkand", style: TextStyle(color: Colors.white),)),
                  ),
                ),
              ]
          )

          ]
      ),
    ],
  ),
      ]
    )
  ),
);

  Widget profileContact() => Container(
    height: deviceSize.height * 0.24,
    child: Container(
      child: new Row(
          children:<Widget>[
            new Container(
              padding:EdgeInsets.only(left: 8.00),
              child: new InkWell(
                onTap: null,
                child: FlatButton.icon(onPressed: null, icon:  new Icon(FontAwesomeIcons.facebookMessenger, color: Colors.white,), label: new Text("Messenger", style: TextStyle(color: Colors.white),)),
              ),
            ),
            new Container(
              child: new InkWell(
                onTap: null,
                child: FlatButton.icon(onPressed: null, icon:  new Icon(FontAwesomeIcons.whatsapp, color: Colors.white,), label: new Text("Whats app", style: TextStyle(color: Colors.white),)),
              ),
            )
          ]
      ),
    )
  );

  //Column1
  Widget profileColumn() => Container(
    height: deviceSize.height * 0.24,
    child: FittedBox(
//      alignment: Alignment.center,
      child: Padding(
//        padding: const EdgeInsets.all(8.0),
        child: Column(
//          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ProfileTile(
              title: "Pawan Kumar",
              subtitle: "Developer",
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new Container(
                    padding:EdgeInsets.only(left: 8.00),
                    child: new InkWell(
                      onTap: null,
                      child: FlatButton.icon(onPressed: null, icon:  new Icon(FontAwesomeIcons.facebookMessenger, color: Colors.white,), label: new Text("Messenger", style: TextStyle(color: Colors.white),)),
                    ),
                  ),
                  new Container(
                    child: new InkWell(
                      onTap: null,
                      child: FlatButton.icon(onPressed: null, icon:  new Icon(FontAwesomeIcons.whatsapp, color: Colors.white,), label: new Text("Whats app", style: TextStyle(color: Colors.white),)),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );

  //column2

  //column3
  Widget descColumn() => Container(
    height: deviceSize.height * 0.13,
    child: Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: Text(
          "Google Developer Expert for Flutter. Passionate #Flutter, #Android Developer. #Entrepreneur #YouTuber",
          style: TextStyle(fontWeight: FontWeight.w700),
          textAlign: TextAlign.center,
          maxLines: 3,
          softWrap: true,
        ),
      ),
    ),
  );
  //column4
  Widget accountColumn() => FittedBox(
    fit: BoxFit.fill,
    child: Container(
      height: deviceSize.height * 0.3,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          FittedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ProfileTile(
                  title: "Website",
                  subtitle: "about.me/imthepk",
                ),
                SizedBox(
                  height: 10.0,
                ),
                ProfileTile(
                  title: "Phone",
                  subtitle: "+919876543210",
                ),
                SizedBox(
                  height: 10.0,
                ),
                ProfileTile(
                  title: "YouTube",
                  subtitle: "youtube.com/mtechviral",
                ),
              ],
            ),
          ),
          FittedBox(
            fit: BoxFit.cover,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ProfileTile(
                  title: "Location",
                  subtitle: "New Delhi",
                ),
                SizedBox(
                  height: 10.0,
                ),
                ProfileTile(
                  title: "Email",
                  subtitle: "mtechviral@gmail.com",
                ),
                SizedBox(
                  height: 10.0,
                ),
                ProfileTile(
                  title: "Facebook",
                  subtitle: "fb.com/imthepk",
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  Widget followColumn(Size deviceSize) => Container(
    height: deviceSize.height * 0.13,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        ProfileTile(
          title: "1.5K",
          subtitle: "Posts",
        ),
        ProfileTile(
          title: "2.5K",
          subtitle: "Followers",
        ),
        ProfileTile(
          title: "10K",
          subtitle: "Comments",
        ),
        ProfileTile(
          title: "1.2K",
          subtitle: "Following",
        )
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    timeDilation = 0.3;
    Size screenSize = MediaQuery.of(context).size;
    deviceSize = MediaQuery.of(context).size;

    return (new WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: new Scaffold(
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
            IconButton(
              icon: new Icon(Icons.settings, color: Colors.black,),
              onPressed: () {},
            ),
          ],
        ),
        body: new Container(
          width: screenSize.width,
          height: screenSize.height,
          child: new Stack(
            //alignment: buttonSwingAnimation.value,
            alignment: Alignment.bottomRight,
            children: <Widget>[
              new ListView(
                padding: const EdgeInsets.all(0.0),
                children: <Widget>[
                  profileDetails(),
                  profileContact()
//                  CommonDivider(),
//                  followColumn(deviceSize),
//                  CommonDivider(),
//                  descColumn(),
//                  CommonDivider(),
//                  accountColumn()
                ],
              ),

              new Padding(
                padding: new EdgeInsets.all(20.0),
                child: new InkWell(
                  splashColor: Colors.white,
                  highlightColor: Colors.white,
                  onTap:_logout,
                  child: new Container(
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
                  ),
                )
              )

             ],
            ),
          ),
        bottomNavigationBar: makeBottom,
      ),
    ));
  }
}
