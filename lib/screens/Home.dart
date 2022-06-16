import 'package:drugcoach/reusables/NavBar.dart';
import 'package:drugcoach/reusables/reusables.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../applocal.dart';

import 'Awareness.dart';
import 'FAQs.dart';
import 'FindRehab.dart';
import 'SearchForDrug.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //to get the height and width of the device so that we can have dynamic paddings and not static
  double ScreenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  double ScreenWidth(BuildContext context) => MediaQuery.of(context).size.width;

  //creating the Uri that make the button actually call using the urilauncher package
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: "911",
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      //calling the background image reusable widget function
      decoration: backgroundimage(),

      child: Scaffold(
        drawer: NavBar(),

        //to not let anything go below the app bar we use :
        extendBodyBehindAppBar: false,

        //to call the appbar reusable function :
        appBar: theappbar(context),

        //to not have any overflow
        resizeToAvoidBottomInset: false,

        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            // to display content vertically
            children: [
              Redtitle(
                  "${AppLocale.of(context).getTranslated('service')}", context),

              //to display the services we divide them into two rows
              //each row contains 2 services

              Row(children: [
                servicesflex(
                    context,
                    () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AwarenessPage()))
                        },
                    "assets/awareness.png",
                    "${AppLocale.of(context).getTranslated('awareness')}"),
                servicesflex(
                    context,
                    () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SearchForDrugPage()))
                        },
                    "assets/searchfordrug.png",
                    "${AppLocale.of(context).getTranslated('searchdrug')}"),
              ]),
              Row(children: [
                servicesflex(
                    context,
                    () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FAQsPage()))
                        },
                    "assets/faq.png",
                    "${AppLocale.of(context).getTranslated('faq')}"),
                servicesflex(
                    context,
                    () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FindRehabPage()))
                        },
                    "assets/rehab.png",
                    "${AppLocale.of(context).getTranslated('rehab')}"),
              ]),

              //call for help button row
              Row(children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: ScreenWidth(context) * 0.4,
                      right: ScreenWidth(context) * 0.4),
                  child: Container(
                      margin:
                          EdgeInsets.only(top: ScreenHeight(context) * 0.06),
                      child: ElevatedButton(
                        onPressed: () {
                          launchUrl(launchUri);
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          primary: Color.fromRGBO(203, 84, 88, 1),
                        ),
                        child: Row(
                          children: [
                            Container(
                              child: Image.asset(
                                'assets/contact.png',
                                width: MediaQuery.of(context).size.width * 0.11,
                              ),
                              padding: EdgeInsets.only(
                                  top:
                                      MediaQuery.of(context).size.height * 0.01,
                                  bottom: MediaQuery.of(context).size.height *
                                      0.01),
                            ),
                          ],
                        ),
                      )),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
