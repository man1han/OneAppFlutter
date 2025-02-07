import 'package:hackru/styles.dart';
import 'package:hackru/defaults.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:url_launcher/url_launcher.dart' as url_launcher;

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: ListView(
        children: <Widget>[
          Center(
            child: Image.asset(
              'assets/hackru-logos/hackru_red.png',
              semanticLabel: 'hackru logo',
              height: 250.0,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Text(
              kAboutApp,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 15.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(25.0),
            child: Center(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Made with',
                      style: TextStyle(
                        color: Colors.grey.shade800,
                        fontWeight: FontWeight.w700,
                        fontSize: 16.0,
                      ),
                    ),
                    const WidgetSpan(
                      child: FlutterLogo(size: 24.0),
                    ),
                    TextSpan(
                      text: 'Flutter & ❤️ by HackRU RnD Team',
                      style: TextStyle(
                        color: Colors.grey.shade800,
                        fontWeight: FontWeight.w700,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w700,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 100.0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SocialMediaCard(
                  onPressed: () => url_launcher.launch(HACK_RU_WEBSITE_URL),
                  iconData: FontAwesomeIcons.link,
                ),
                SocialMediaCard(
                  onPressed: () => url_launcher.launch(REPOSITORY_URL),
                  iconData: FontAwesomeIcons.github,
                ),
                SocialMediaCard(
                  onPressed: () => url_launcher.launch(FACEBOOK_PAGE_URL),
                  iconData: FontAwesomeIcons.facebookSquare,
                ),
                SocialMediaCard(
                  onPressed: () => url_launcher.launch(INSTAGRAM_PAGE_URL),
                  iconData: FontAwesomeIcons.instagram,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SocialMediaCard extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData? iconData;
  const SocialMediaCard({Key? key, this.onPressed, this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 2.0,
        color: Theme.of(context).accentColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(
              iconData,
              color: HackRUColors.black,
              size: 30.0,
            ),
          ),
        ),
      ),
    );
  }
}
