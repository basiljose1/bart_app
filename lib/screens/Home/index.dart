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
import 'package:url_launcher/url_launcher.dart';
import 'package:bart_app/models/user.dart';
import 'package:bart_app/data/rest_ds.dart';
import 'package:bart_app/components/shimmer.dart';
import 'package:bart_app/components/fab_bottom_app_bar.dart';
import 'package:bart_app/components/fab_with_icons.dart';
import 'package:bart_app/components/layout.dart';




import 'package:bart_app/screens/Home/category_list.dart';
import 'package:bart_app/screens/Home/list_item_bart.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  HomeScreenState createState() => new HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {

  var animateStatus = 0;
  var deviceSize;
  TabController controller;
  String _lastSelected = 'TAB: 0';

  RestDatasource api = new RestDatasource();

  @override
  void initState() {
    super.initState();
    controller = new TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _logout() {
    setState(() {
      animateStatus = 1;
    });

    setMobileToken("");
  }

  void _selectedTab(int index) {
    setState(() {
      _lastSelected = 'TAB: $index';
      print(_lastSelected);
    });
  }

  Widget _buildFab(BuildContext context) {
    return FloatingActionButton(
      onPressed: () { print("yes"); },
      tooltip: 'Search',
      child: Icon(Icons.search),
      elevation: 2.0,
    );
  }



//  final makeBottom = Container(
//    height: 55.0,
//    child: BottomAppBar(
//      color: Colors.white,
//      child: Row(
//        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//        children: <Widget>[
//          IconButton(
//            icon: Icon(Icons.home, color: Colors.black87),
//            onPressed: () {},
//          ),
//          IconButton(
//            icon: Icon(Icons.list, color: Colors.black87),
//            onPressed: () {},
//          ),
//          IconButton(
//            icon: Icon(Icons.search, color: Colors.black87),
//            onPressed: () {},
//          ),
//          IconButton(
//            icon: Icon(Icons.assignment_return, color: Colors.black87),
//            onPressed: () {},
//          ),
//          IconButton(
//            icon: Icon(Icons.assignment, color: Colors.black87),
//            onPressed: () {},
//          )
//        ],
//      ),
//    ),
//  );

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  Widget profileDetails() => Container(
  //  height: deviceSize.height * 0.24,
    child: new FutureBuilder<User>(
      future: api.fetchUser(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
        return new Container(
          padding: EdgeInsets.all(5.00),
          decoration: new BoxDecoration(color: Color.fromRGBO(57, 144, 163, 1.0)),
          child: new Column(
            children: <Widget>[
              new Row(
                children: <Widget>[
                  new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Container(
                        alignment: AlignmentDirectional.center,
                        child: new CircleAvatar(backgroundImage: NetworkImage(snapshot.data.avatar), backgroundColor: Colors.transparent,radius:40.0
                        )
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
                            child: new Text (snapshot.data.shop_name, style: TextStyle(fontSize: 25.0, color: Colors.white), textAlign: TextAlign.left, ),
                          ),
                          new Container(
                            child: new IconButton(icon: new Icon(Icons.mode_edit, color: Colors.white, ), onPressed: null, padding: EdgeInsets.only(top: 20.00), alignment: AlignmentDirectional.centerEnd, ),
                          )
                        ]
                      ),
                      new Row(
                        mainAxisAlignment:MainAxisAlignment.center,
                        children:<Widget>[
                          new Container(
                            padding:EdgeInsets.only(left: 8.00),
                            child: new InkWell(
                              onTap: null,
                              child: FlatButton.icon(onPressed: null, icon: new Icon(FontAwesomeIcons.facebookMessenger, color: Colors.white, ), label: new Text("Messenger", style: TextStyle(color: Colors.white), )),
                            ),
                          ),
                          new Container(
                            child: new InkWell(
                              onTap: null,
                              child: FlatButton.icon(onPressed: () => setState(() {_launchURL("whatsapp://send?phone="+snapshot.data.phone);}), icon: new Icon(FontAwesomeIcons.whatsapp, color: Colors.white, ), label: new Text("Whats app", style: TextStyle(color: Colors.white), )),
                            ),
                          )
                        ]
                      ),
                      new Row(
                        mainAxisAlignment:MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:<Widget>[
                          new Container(
                            padding:EdgeInsets.only(left: 8.00),
                            child: new InkWell(
                            onTap: null,
                            child: FlatButton.icon(onPressed: null, icon: new Icon(FontAwesomeIcons.locationArrow, color: Colors.white, ), label: new Text("#3 Kakkand", style: TextStyle(color: Colors.white), )),
                            ),
                          ),
                        ]
                      )
                    ]
                  ),
                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize:MainAxisSize.max,
                children: <Widget>[
                  new Container(
                    width:deviceSize.width * 0.45,
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(width: 1.0, color: Colors.white30),
                        right: BorderSide(width: 1.0, color: Colors.white30),
                      ),
                    ),
                    child: new InkWell(
                      onTap: null,
                      child: FlatButton.icon(onPressed:() => setState(() {
                        _launchURL("tel:"+snapshot.data.phone);}), icon: new Icon(FontAwesomeIcons.phoneSquare, color: Colors.white, ), label: new Text("Call", style: TextStyle(color: Colors.white), )),
                    ),
                  ),
                  new Container(
                    width:deviceSize.width * 0.45,
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(width: 1.0, color: Colors.white30),
                      ),
                    ),
                    child: new InkWell(
                      onTap: null,
                      child: FlatButton.icon(onPressed: () => setState(() {
                        _launchURL("sms:"+snapshot.data.phone);}), icon: new Icon(FontAwesomeIcons.rocketchat, color: Colors.white, ), label: new Text("Message", style: TextStyle(color: Colors.white), )),
                    ),
                  )
                ],
              )
            ]
          )
        );
      } else if (snapshot.hasError) {
        return new Text("${snapshot.error}");
    }
    return new Container(
      alignment: Alignment(0.0, 0.0),
      padding: EdgeInsets.all(15.0),
      child: new CircularProgressIndicator(strokeWidth: 1.5),
    );
    })
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
        backgroundColor: Color.fromRGBO(245, 245, 245, 1.0),
        leading: new Padding(
          padding: const EdgeInsets.all(8.0),
          child:
            new CircleAvatar(
              backgroundImage:AssetImage('assets/logo.png'),
              foregroundColor: Colors.grey,
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
            alignment: Alignment.bottomRight,
            children: <Widget>[
              new ListView(
                padding: const EdgeInsets.all(0.0),
                children: <Widget>[
                  profileDetails(),
                  new Container(
                    child: new TabBar(
                      controller: controller,
                      indicatorColor:Color.fromRGBO(57, 144, 163, 1.0),
                      labelColor:Colors.black,
                      tabs: <Widget>[
                        new Tab(text: "Categories"),
                        new Tab(text: "All items"),
                        new Tab(text: "Messages"),
                      ],
                    ) ,
                  ),
                  new Container(
                    height: screenSize.height,
                    child: new TabBarView(
                      controller: controller,
                      children: <Widget>[
                        new Container(
                          child: new GridView.builder(
                              itemCount: 5,
                              shrinkWrap: true,
                              primary: true,
                              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                              itemBuilder: (BuildContext context, int index) {
                                return new GestureDetector(
                                  child: new Card(
                                    elevation: 5.0,
                                    child: new Container(
                                      alignment: Alignment.center,
                                      child: new Text('Item $index'),
                                    ),
                                  ),
                                  onTap: () {
                                  },
                                );
                              }),
                        ),
                        new Icon(Icons.account_balance),
                        new Icon(Icons.account_balance)
                      ],
                    ),
                  )
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
                        color: const Color.fromRGBO(254,194,57, 1.0),
                        shape: BoxShape.circle),
                    child: new Icon(
                      Icons.assignment,
                      size: 30.0,
                      color: Colors.white,
                    ),
                  ),
                )
              )
            ],
            ),
          ),
        bottomNavigationBar: new  FABBottomAppBar(
          centerItemText: 'B',
          color: Colors.grey,
          selectedColor: Color.fromRGBO(254, 194, 57, 1.0),
          notchedShape: CircularNotchedRectangle(),
          onTabSelected: _selectedTab,
          items: [
            FABBottomAppBarItem(iconData: Icons.home, text: 'Home'),
            FABBottomAppBarItem(iconData: Icons.list, text: 'List'),
            FABBottomAppBarItem(iconData: Icons.dashboard, text: 'Required'),
            FABBottomAppBarItem(iconData: Icons.grid_on, text: 'All'),
          ],
        ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: _buildFab(
              context),
      ),
    ));
  }
}
