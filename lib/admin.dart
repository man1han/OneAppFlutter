import 'package:HackRU/screens/login.dart';
import 'package:HackRU/screens/scanner2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:groovin_material_icons/groovin_material_icons.dart';
import 'colors.dart';
import 'package:hidden_drawer_menu/hidden_drawer/hidden_drawer_menu.dart';
import 'package:hidden_drawer_menu/menu/item_hidden_menu.dart';
import 'package:hidden_drawer_menu/hidden_drawer/screen_hidden_drawer.dart';
import 'package:HackRU/screens/about.dart';
import 'package:HackRU/screens/map.dart';
import 'package:HackRU/screens/help.dart';
import 'package:HackRU/screens/home.dart';
import 'package:HackRU/filestore.dart';

class AdminPage extends StatefulWidget {
  AdminPage({Key key}) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> with TickerProviderStateMixin {
  List<ScreenHiddenDrawer> items = new List();

  @override
  void initState() {

    items.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: "Home",
          baseStyle: TextStyle( color: white.withOpacity(0.5), fontSize: 28.0 ),
          colorLineSelected: yellow,
        ),
        Home()));

    items.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: "Map",
          baseStyle: TextStyle( color: white.withOpacity(0.5), fontSize: 28.0 ),
          colorLineSelected: pink,
        ),
        Map()));

    items.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: "Scanner",
          baseStyle: TextStyle( color: white.withOpacity(0.5), fontSize: 28.0 ),
          colorLineSelected: yellow,
        ),
        QRScanner2()));

    items.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: "Help",
          baseStyle: TextStyle( color: white.withOpacity(0.5), fontSize: 28.0 ),
          colorLineSelected: pink,
        ),
        Help()));

    items.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: "About",
          baseStyle: TextStyle( color: white.withOpacity(0.5), fontSize: 28.0 ),
          colorLineSelected: yellow,
        ),
        About()));


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return HiddenDrawerMenu(
      actionsAppBar: <Widget>[
        IconButton(icon: Icon(GroovinMaterialIcons.logout, color: pink,),
          color: pink,
          splashColor: yellow,
          onPressed: (){
            Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute( builder: (BuildContext context) => Login()), ModalRoute.withName('/login'));
            deleteStoredCredential();
        })
      ],
      backgroundColorMenu: charcoal,
      backgroundColorAppBar: charcoal,
      elevationAppBar: 0,
      backgroundMenu: DecorationImage(image: ExactAssetImage('assets/images/drawer_bg.png'),fit: BoxFit.cover),
      screens: items,
      iconMenuAppBar: Icon(Icons.arrow_back, color: green,),
    );

  }
}
