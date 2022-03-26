import 'package:hackru/models/cred_manager.dart';
import 'package:hackru/models/models.dart';
import 'package:hackru/services/hackru_service.dart';
import 'package:hackru/ui/pages/about_app/about.dart';
import 'package:hackru/ui/pages/help/help.dart';
import 'package:hackru/ui/pages/home.dart';
import 'package:hackru/ui/pages/qr_scanner/QRScanner.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:hackru/ui/widgets/custom_hidden_drawer_menu.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';

import '../styles.dart';

class HackRUApp extends StatefulWidget {
  HackRUApp({Key? key}) : super(key: key);

  @override
  _HackRUAppState createState() => _HackRUAppState();
}

class _HackRUAppState extends State<HackRUApp> {
  List<ScreenHiddenDrawer> items = [];
  bool _hasAuthToken = false;
  User? user;

  final _selectedDrawerItem =
      TextStyle(color: HackRUColors.pink, fontWeight: FontWeight.w700);
  final _nonSelectedDrawerItem = TextStyle(
      color: HackRUColors.grey, fontSize: 28.0, fontWeight: FontWeight.w500);

  @override
  void initState() {
    _hasToken();
    if (_hasAuthToken != null) _drawerItems();
    super.initState();
  }

  /// =========================================================
  ///                     CREDENTIAL MANAGER
  /// =========================================================
  void _hasToken() async {
    var hasToken = await hasCredentials();
    if (hasToken) {
      setState(() {
        _hasAuthToken = hasToken;
      });
      _getUserProfile();
    } else {
      setState(() {
        _hasAuthToken = false;
      });
    }
  }

  void _getUserProfile() async {
    var _storedEmail = await getEmail();
    var _authToken = await getAuthToken();
    var userProfile = await getUser(_authToken!, _storedEmail!);
    print('====== Email: ${userProfile.email} ======');
    if (userProfile != null) {
      setState(() {
        user = userProfile;
      });
    }
  }

  /// =========================================================
  ///                      DRAWER ITEMS
  /// =========================================================
  void _drawerItems() {
    setState(() {});
    items.add(ScreenHiddenDrawer(
      ItemHiddenMenu(
        name: 'Home',
        baseStyle: _nonSelectedDrawerItem,
        colorLineSelected: HackRUColors.yellow,
        selectedStyle: _selectedDrawerItem,
      ),
      Home(),
    ));

    // items.add(ScreenHiddenDrawer(
    //   ItemHiddenMenu(
    //     name: 'Map',
    //     baseStyle: _nonSelectedDrawerItem,
    //     colorLineSelected: HackRUColors.yellow,
    //     selectedStyle: _selectedDrawerItem,
    //   ),
    //   HackRUMap(),
    // ));

    items.add(ScreenHiddenDrawer(
      ItemHiddenMenu(
        name: 'Help',
        baseStyle: _nonSelectedDrawerItem,
        colorLineSelected: HackRUColors.yellow,
        selectedStyle: _selectedDrawerItem,
      ),
      Help(),
    ));

    items.add(ScreenHiddenDrawer(
      ItemHiddenMenu(
        name: 'About',
        baseStyle: _nonSelectedDrawerItem,
        colorLineSelected: HackRUColors.yellow,
        selectedStyle: _selectedDrawerItem,
      ),
      About(),
    ));

    //NOTE: only show QR_SCANNER button to authorized users
    if (_hasAuthToken) {
      if (user?.role.organizer == true || user?.role.organizer == true) {
        items.add(ScreenHiddenDrawer(
          ItemHiddenMenu(
            name: "QR Scanner",
            baseStyle: _nonSelectedDrawerItem,
            colorLineSelected: HackRUColors.yellow,
            selectedStyle: _selectedDrawerItem,
          ),
          QRScanner(),
        ));
      }
    }

    if (_hasAuthToken) {
      items.add(ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'Logout',
          baseStyle: _nonSelectedDrawerItem,
          colorLineSelected: HackRUColors.yellow,
          selectedStyle: _selectedDrawerItem,
          onTap: () async {
            await deleteCredentials();
            await Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (BuildContext context) => HackRUApp(),
                maintainState: false,
              ),
              ModalRoute.withName('/main'),
            );
          },
        ),
        Container(),
      ));
    }
  }

  /// =========================================================
  ///                     BUILD FUNCTION
  /// =========================================================

  @override
  Widget build(BuildContext context) {
    print('==**==== HAS_AUTH_TOKEN: $_hasAuthToken ===**===');
    return CustomHiddenDrawerMenu(
      actionsAppBar: <Widget>[
        _hasAuthToken
            ? IconButton(
                icon: Icon(
                  FontAwesomeIcons.signOutAlt,
                  color: Theme.of(context).primaryColor,
                ),
                color: HackRUColors.transparent,
                splashColor: HackRUColors.yellow,
                onPressed: () async {
                  await deleteCredentials();
                  setState(() {
                    _hasAuthToken = false;
                  });
                  await Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (BuildContext context) => HackRUApp(),
                      maintainState: false,
                    ),
                    ModalRoute.withName('/main'),
                  );
                },
              )
            : Container(),
      ],
      leadingAppBar: Icon(
        Icons.menu,
        color: HackRUColors.grey,
      ),
      styleAutoTittleName: Theme.of(context).textTheme.headline6,
      backgroundColorMenu: HackRUColors.grey,
      backgroundColorAppBar: Theme.of(context).backgroundColor,
      elevationAppBar: 0.0,
      backgroundMenu: Container(
        color: HackRUColors.charcoal,
        child: FlareActor(
          'assets/flare/party.flr',
          alignment: Alignment.center,
          fit: BoxFit.contain,
          animation: 'idle',
        ),
      ),
      screens: items,
      typeOpen: TypeOpen.FROM_LEFT,
    );
  }
}
