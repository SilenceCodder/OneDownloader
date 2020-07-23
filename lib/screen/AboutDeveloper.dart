import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onedownloader/locator.dart';
import 'package:onedownloader/Styles/AppImage.dart';
import 'package:onedownloader/Styles/AppText.dart';
import 'package:onedownloader/utils/customFunction.dart';

class AboutDeveloper extends StatefulWidget {
  @override
  _AboutDeveloperState createState() => _AboutDeveloperState();
}

class _AboutDeveloperState extends State<AboutDeveloper> {
  final CustomFunction _customFunction = locator<CustomFunction>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          createAppbar(),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return body();
            }, childCount: 1),
          )
        ],
      ),
    );
  }

  CupertinoSliverNavigationBar createAppbar() {
    return CupertinoSliverNavigationBar(
      leading: CupertinoButton(
        child: Icon(
          CupertinoIcons.left_chevron,
          color: Colors.black,
        ),
        minSize: 0.0,
        padding: EdgeInsets.zero,
        onPressed: () {
          Navigator.of(context).maybePop();
        },
      ),
      largeTitle: Text(
        "About Developer",
        style: GoogleFonts.anaheim(
            textStyle: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
        textAlign: TextAlign.center,
      ),
      heroTag: "Sa\'al",
      backgroundColor: Colors.transparent,
    );
  }

  Widget body() {
    return ListView(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: CircleAvatar(
            radius: MediaQuery.of(context).size.width / 8,
            backgroundImage: AssetImage(AppImage.icode),
            backgroundColor: Colors.white,
          ),
        ),
        ListTile(
          title: Text(
            "Harbdollar",
            textAlign: TextAlign.center,
            style: GoogleFonts.anaheim(
                textStyle:
                    TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold)),
          ),
          subtitle: Text(
            "Mobile Developer(Android/iOS), Digital Marketer and Entrepreneur",
            textAlign: TextAlign.center,
            style: GoogleFonts.anaheim(
                textStyle:
                    TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "I love to code and passionate about innovation",
            textAlign: TextAlign.center,
            style: GoogleFonts.anaheim(textStyle: TextStyle(fontSize: 16.0)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "If there's any suggestion or project, You can contact me",
            style: GoogleFonts.anaheim(
                textStyle:
                    TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold)),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            alignment: WrapAlignment.spaceAround,
            children: <Widget>[
              createButton("Github", "https://github.com/Harbdollar",
                  "https://image.flaticon.com/icons/png/128/25/25231.png"),
              createButton(
                  "linkedin",
                  "https://www.linkedin.com/in/olajire-abdullahi-48007614b/",
                  "https://image.flaticon.com/icons/png/512/174/174857.png"),
              createButton("Facebook", "https://www.facebook.com/Harbdollar",
                  "https://www.facebook.com/images/fb_icon_325x325.png"),
              createButton(
                  "Direct Message",
                  "https://wa.me/+2348185951999?text=Hi,%20Am%20%20messaging%20you%20from%20Nairaland%20App%20developed%20by%20you%20My%20Name%20is",
                  "https://i.pinimg.com/736x/30/91/1a/30911adfe9513c87864074d2925f097c.jpg"),
            ],
          ),
        ),
      ],
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
    );
  }

  Widget createButton(String title, String url, String image) {
    return Column(
      children: <Widget>[
        RaisedButton(
          color: Colors.white,
          onPressed: () {
            _customFunction.launchURL(url);
          },
          child: CircleAvatar(
            backgroundImage: NetworkImage(image),
            radius: 28.0,
            backgroundColor: Colors.white,
          ),
          shape: CircleBorder(),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            title,
            style: Theme.of(context).textTheme.title.copyWith(fontSize: 14.0),
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
