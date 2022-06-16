import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../applocal.dart';
import '../reusables/NavBar.dart';
import '../reusables/reusables.dart';

class AwarenessPage extends StatefulWidget {
  const AwarenessPage({Key? key}) : super(key: key);

  @override
  State<AwarenessPage> createState() => _AwarenessPageState();
}

class _AwarenessPageState extends State<AwarenessPage> {
//the following variables are to manage the state of each tab
//each tab selected will cal the set state function that give the followign variables
//its corresponding values to that specific tab
  var selectedTab = 1;
  var selectedText = "First Tab";

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: backgroundimage(),
      child: Scaffold(
        drawer: NavBar(),
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        appBar: theappbar(context),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              // to display content vertically
              children: [
                //the following container is the tabs container
                Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.07,

                  //the following row is to display the tab bar above
                  child: Row(
                    children: [
                      //in the row we will have 5 column each one represents a tab
                      Column(
                        children: [
                          //a gesture detector is used to detect if the user chose this
                          //specific tab and each tab has a title and a number
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedTab = 1;
                                selectedText =
                                    "${AppLocale.of(context).getTranslated('why')}";
                              });
                            },

                            //inside the first column we will have another column the displays
                            //the icon and the text of each tab which is inside the reusable
                            //container widget
                            child: thecontainer(
                                "${AppLocale.of(context).getTranslated('why')}",
                                Icon(Icons.help_outline,
                                    color: selectedTab == 1
                                        ? Colors.blue
                                        : Colors.black),
                                context,
                                selectedTab,
                                1),
                          ),
                        ],
                      ),

                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedTab = 2;
                            selectedText =
                                "${AppLocale.of(context).getTranslated('symptoms')}";
                          });
                        },
                        child: thecontainer(
                            "${AppLocale.of(context).getTranslated('symptoms')}",
                            Icon(Icons.sentiment_dissatisfied,
                                color: selectedTab == 2
                                    ? Colors.blue
                                    : Colors.black),
                            context,
                            selectedTab,
                            2),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedTab = 3;
                            selectedText =
                                "${AppLocale.of(context).getTranslated('sideffects')}";
                          });
                        },
                        child: thecontainer(
                            "${AppLocale.of(context).getTranslated('sideffects')}",
                            Icon(Icons.error_outline,
                                color: selectedTab == 3
                                    ? Colors.blue
                                    : Colors.black),
                            context,
                            selectedTab,
                            3),
                      ),

                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedTab = 4;
                            selectedText =
                                "${AppLocale.of(context).getTranslated('prevention')}";
                          });
                        },
                        child: thecontainer(
                            "${AppLocale.of(context).getTranslated('prevention')}",
                            Icon(Icons.pan_tool,
                                color: selectedTab == 4
                                    ? Colors.blue
                                    : Colors.black),
                            context,
                            selectedTab,
                            4),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedTab = 5;
                            selectedText =
                                "${AppLocale.of(context).getTranslated('treatment')}";
                          });
                        },
                        child: thecontainer(
                            "${AppLocale.of(context).getTranslated('treatment')}",
                            Icon(Icons.assignment_turned_in,
                                color: selectedTab == 5
                                    ? Colors.blue
                                    : Colors.black),
                            context,
                            selectedTab,
                            5),
                      ),
                    ],
                  ),
                ),

                awarenesstitle(context, selectedTab),

                bodyofselectedtab(context, selectedTab),

                homebtnpadding(context)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Container bodyofselectedtab(BuildContext context, selectedTab) {
  if (selectedTab == 1) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.55,
      child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.03,
                    right: MediaQuery.of(context).size.width * 0.03),
                child: Text(
                  "${AppLocale.of(context).getTranslated('whatisdrugs')}",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.height * 0.035,
                      color: Colors.black),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.04,
                    right: MediaQuery.of(context).size.width * 0.05,
                    top: MediaQuery.of(context).size.height * 0.01),
                child: Text(
                  "${AppLocale.of(context).getTranslated('whatpar')}",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.025),
                  textAlign: TextAlign.justify,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.03,
                    right: MediaQuery.of(context).size.width * 0.03,
                    top: MediaQuery.of(context).size.height * 0.02),
                child: Text(
                  "${AppLocale.of(context).getTranslated('whyquestion')}",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.height * 0.035,
                      color: Colors.black),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.04,
                    top: MediaQuery.of(context).size.height * 0.01,
                    right: MediaQuery.of(context).size.width * 0.05),
                child: Text(
                  "${AppLocale.of(context).getTranslated('whypar')}",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.025),
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          )),
    );
  } else if (selectedTab == 2) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.55,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.03,
                  right: MediaQuery.of(context).size.width * 0.03),
              child: Text(
                "${AppLocale.of(context).getTranslated('physical')}",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.height * 0.035,
                    color: Colors.black),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.04,
                  top: MediaQuery.of(context).size.height * 0.01,
                  right: MediaQuery.of(context).size.width * 0.05),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${AppLocale.of(context).getTranslated('physicaltxt')}",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.025),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.03,
                  top: MediaQuery.of(context).size.height * 0.01,
                  right: MediaQuery.of(context).size.width * 0.03),
              child: Text(
                "${AppLocale.of(context).getTranslated('changes')}",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.height * 0.035,
                    color: Colors.black),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.04,
                  top: MediaQuery.of(context).size.height * 0.01,
                  right: MediaQuery.of(context).size.width * 0.05),
              child: Text(
                "${AppLocale.of(context).getTranslated('behaviortxt')}",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.025),
                textAlign: TextAlign.justify,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.03,
                  top: MediaQuery.of(context).size.height * 0.01,
                  right: MediaQuery.of(context).size.width * 0.03),
              child: Text(
                "${AppLocale.of(context).getTranslated('psycho')}",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.height * 0.035,
                    color: Colors.black),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.04,
                  top: MediaQuery.of(context).size.height * 0.01,
                  right: MediaQuery.of(context).size.width * 0.05),
              child: Text(
                "${AppLocale.of(context).getTranslated('psychopar')}",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.025),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
    );
  } else if (selectedTab == 3) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.55,
      child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.03,
                    top: MediaQuery.of(context).size.height * 0.01,
                    right: MediaQuery.of(context).size.width * 0.03),
                child: Text(
                  "${AppLocale.of(context).getTranslated('shortterm')}",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.height * 0.035,
                      color: Colors.black),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.04,
                    top: MediaQuery.of(context).size.height * 0.01,
                    right: MediaQuery.of(context).size.width * 0.05),
                child: Text(
                  "${AppLocale.of(context).getTranslated('shorteffects')}",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.025),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.03,
                    top: MediaQuery.of(context).size.height * 0.01,
                    right: MediaQuery.of(context).size.width * 0.03),
                child: Text(
                  "${AppLocale.of(context).getTranslated('longterm')}",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.height * 0.035,
                      color: Colors.black),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.04,
                    top: MediaQuery.of(context).size.height * 0.01,
                    right: MediaQuery.of(context).size.width * 0.05),
                child: Text(
                  "${AppLocale.of(context).getTranslated('longeffects')}",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.025),
                ),
              ),
            ],
          )),
    );
  } else if (selectedTab == 4) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.55,
      child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.04,
                    top: MediaQuery.of(context).size.height * 0.01,
                    right: MediaQuery.of(context).size.width * 0.05),
                child: Text(
                  "${AppLocale.of(context).getTranslated('preventionpar')}",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.025),
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          )),
    );
  } else {
    return Container(
      height: MediaQuery.of(context).size.height * 0.55,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.04,
                  top: MediaQuery.of(context).size.height * 0.01,
                  right: MediaQuery.of(context).size.width * 0.05),
              child: Text(
                "${AppLocale.of(context).getTranslated('treatmentpar')}",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.025),
                textAlign: TextAlign.justify,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.03,
                  top: MediaQuery.of(context).size.height * 0.01,
                  right: MediaQuery.of(context).size.width * 0.03),
              child: Text(
                "${AppLocale.of(context).getTranslated('detoxification')}",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.height * 0.035,
                    color: Colors.black),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.04,
                  top: MediaQuery.of(context).size.height * 0.01,
                  right: MediaQuery.of(context).size.width * 0.05),
              child: Text(
                "${AppLocale.of(context).getTranslated('detoxpar')}",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.025),
                textAlign: TextAlign.justify,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.03,
                  top: MediaQuery.of(context).size.height * 0.01,
                  right: MediaQuery.of(context).size.width * 0.03),
              child: Text(
                "${AppLocale.of(context).getTranslated('medication')}",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.height * 0.035,
                    color: Colors.black),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.04,
                  top: MediaQuery.of(context).size.height * 0.01,
                  right: MediaQuery.of(context).size.width * 0.05),
              child: Text(
                "${AppLocale.of(context).getTranslated('medpar')}",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.025),
                textAlign: TextAlign.justify,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.03,
                  top: MediaQuery.of(context).size.height * 0.01,
                  right: MediaQuery.of(context).size.width * 0.03),
              child: Text(
                "${AppLocale.of(context).getTranslated('cognitive')}",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.height * 0.035,
                    color: Colors.black),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.04,
                  top: MediaQuery.of(context).size.height * 0.01,
                  right: MediaQuery.of(context).size.width * 0.05),
              child: Text(
                "${AppLocale.of(context).getTranslated('cbtpar')}",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.025),
                textAlign: TextAlign.justify,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.03,
                  top: MediaQuery.of(context).size.height * 0.01,
                  right: MediaQuery.of(context).size.width * 0.03),
              child: Text(
                "${AppLocale.of(context).getTranslated('rbet')}",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.height * 0.035,
                    color: Colors.black),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.04,
                  top: MediaQuery.of(context).size.height * 0.01,
                  right: MediaQuery.of(context).size.width * 0.05),
              child: Text(
                "${AppLocale.of(context).getTranslated('rbetpar')}",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.025),
                textAlign: TextAlign.justify,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.03,
                  top: MediaQuery.of(context).size.height * 0.01,
                  right: MediaQuery.of(context).size.width * 0.03),
              child: Text(
                "${AppLocale.of(context).getTranslated('contingency')}",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.height * 0.035,
                    color: Colors.black),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.04,
                  top: MediaQuery.of(context).size.height * 0.01,
                  right: MediaQuery.of(context).size.width * 0.05),
              child: Text(
                "${AppLocale.of(context).getTranslated('contpar')}",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.025),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
