import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../applocal.dart';
import '../reusables/NavBar.dart';
import '../reusables/reusables.dart';
import 'ChangePass.dart';
import 'Deactivate.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    //to get the information of the current user ( username and email )
    User? user = FirebaseAuth.instance.currentUser;

    return Container(
      decoration: backgroundimage(),
      child: Scaffold(
        drawer: NavBar(),
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        appBar: theappbar(context),
        body: Center(
          child: Column(children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.8,
              child: Column(
                // to display content vertically
                children: [
                  blacktitle(context,
                      "${AppLocale.of(context).getTranslated('profile')}"),

                  //the following container is the white box to display the username and email
                  //we center aligned it and gave it the appropriate margins and padding
                  //we set the height relative to the screen height * 0.2
                  //we gave it a decoration ( white color , shadow and rounded corners)
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.04,
                        right: MediaQuery.of(context).size.height * 0.03,
                        left: MediaQuery.of(context).size.height * 0.03),
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.width * 0.03),
                    height: MediaQuery.of(context).size.height * 0.2,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),

                          //the size of the shadow before creating it
                          spreadRadius: 3,

                          //the size of the shadow
                          blurRadius: 5,

                          //offset is the x and y components or axis of the shadows
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),

                    //the following is a column inside the white box to display the information
                    child: Column(
                      children: [
                        //to display each field horizontally ( icon , username , username )
                        Row(
                          children: [
                            //first container is for the icon
                            Container(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height *
                                      0.025),
                              child: Icon(
                                Icons.person,
                                size: MediaQuery.of(context).size.width * 0.07,
                                color: const Color.fromRGBO(186, 62, 75, 10),
                              ),
                            ),

                            //container for the word username
                            Container(
                                padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.025),
                                child: Text(
                                  "${AppLocale.of(context).getTranslated('pusername')}",
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.045,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                            Container(
                                padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.025),
                                child: Text(
                                  '${user!.displayName}',
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.04,
                                    color: Colors.black,
                                  ),
                                )),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height *
                                      0.025),
                              child: Icon(
                                Icons.alternate_email,
                                size: MediaQuery.of(context).size.width * 0.07,
                                color: Color.fromRGBO(186, 62, 75, 10),
                              ),
                            ),
                            Container(
                                padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.025),
                                child: Text(
                                  "${AppLocale.of(context).getTranslated('pemail')}",
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.045,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),

                            //expanded is used to control the horizontal over flow but the mediaquery
                            //is used to control the vertical overflow
                            Expanded(
                              child: Container(
                                  padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height *
                                          0.025),
                                  child: Text(
                                    '${user.email}',
                                    style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.04,
                                      color: Colors.black,
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  //padding to make space between info and button
                  Padding(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.height * 0.02)),

                  //redirect to changepass page
                  submitbtns(
                      context,
                      "${AppLocale.of(context).getTranslated('changepass')}",
                      false,
                      false,
                      () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChangePassPage()),
                            )
                          }),

                  //padding for appearances
                  Padding(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.height * 0.02)),

                  //redirect to deactivate account page
                  submitbtns(
                      context,
                      "${AppLocale.of(context).getTranslated('deactivate')}",
                      false,
                      false,
                      () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DeactivatePage()),
                            )
                          }),
                ],
              ),
            ),
            Column(
              children: [homebtnpadding(context)],
            )
          ]),
        ),
      ),
    );
  }
}
