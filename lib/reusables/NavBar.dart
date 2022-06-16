// import 'package:firebase_auth/firebase_auth.dart';
import 'package:drugcoach/reusables/reusables.dart';
import 'package:drugcoach/screens/ContactUs.dart';
import 'package:drugcoach/screens/Home.dart';
import 'package:drugcoach/screens/SignIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../applocal.dart';
import '../main.dart';
import '../screens/ProfilePage.dart';


class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}


//nav bar is the menu that will show after clicking on the profile icon that is located in the appbar
//it is a reusable widget since all logged in screens will need the app bar and navbar

class _NavBarState extends State<NavBar> {


  var txt ='';

  //to get the hight and width of the device so that we can have dynamic paddings and not static
  double ScreenHeight(BuildContext context) => MediaQuery.of(context).size.height;
  double ScreenWidth(BuildContext context) => MediaQuery.of(context).size.width;




  void initState() {
    super.initState();
    setState(() {});
  }



  void thetxt(String thet){

    setState(() {txt = thet;});

  }

  @override
  Widget build(BuildContext context) {
    //to get the current logged in user info to display the user name in the nav bar title
    User? user = FirebaseAuth.instance.currentUser;


    //we want to return a drawer that will slide open when the profile icon is clicked
    return Drawer(
        child: Container(

          //setting the bg color of the menu
            color: Color(0xffd8e5f1),

            //list view is used to list widgets as an array
            child: ListView(
              children: [

                //the header of the menu which in our case is where the username is
                DrawerHeader(
                  child:
                  Padding(
                      padding: EdgeInsets.only(
                          left: ScreenWidth(context) * 0.06,
                          top: ScreenHeight(context) * 0.04),
                      child : Text("${user!.displayName}"
            , style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.05,
                          fontFamily: "Oswald"),textAlign: TextAlign.center,
                      )),
                ),


                //below is where the list of other pages are located each text button will redirect user to another page
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top : ScreenHeight(context) * 0.03),

                      //list tile is list a bulllet list where we can choose the icon and title
                      child: ListTile(
                        leading: Icon(
                          Icons.home,
                          size: ScreenWidth(context)*0.1,
                          color:Color.fromRGBO(186, 62, 75, 10),
                        ),
                        title: Text("${AppLocale.of(context).getTranslated('home')}",
                            style: TextStyle(
                                fontSize: ScreenWidth(context)*0.07,
                                color: Colors.black,
                                fontFamily: "Oswald")),
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        },
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            top : ScreenHeight(context) * 0.03),
                        child: ListTile(
                          leading: Icon(
                            Icons.badge,
                            size: ScreenWidth(context)*0.1,
                            color:Color.fromRGBO(186, 62, 75, 10),
                          ),
                          title: Text("${AppLocale.of(context).getTranslated('profile')}",
                              style: TextStyle(
                                  fontSize: ScreenWidth(context)*0.07,
                                  color: Colors.black,
                                  fontFamily: "Oswald")),
                          onTap: () {

                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ProfilePage()),
                            );
                          },
                        )
                    ),

                    Padding(
                        padding: EdgeInsets.only(top : ScreenHeight(context) * 0.03),
                        child: ListTile(
                          leading:Icon(
                            Icons.mark_email_read_outlined ,
                            size: ScreenWidth(context)*0.1,
                            color:Color.fromRGBO(186, 62, 75, 10),
                          ),
                          title: Text("${AppLocale.of(context).getTranslated('contact')}",
                              style: TextStyle(
                                  fontSize: ScreenWidth(context)*0.07,
                                  color: Colors.black,
                                  fontFamily: "Oswald")),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ContactUsPage()),
                            );
                          },
                        )
                    ),

                    //the log out button was a different button than all the submit button because
                    //we wanted to have an icon
                    Padding(
                        padding: EdgeInsets.only(top : ScreenHeight(context)*0.05),
                        child :  ElevatedButton.icon(
                            icon: Icon(Icons.logout),

                            label: Text("${AppLocale.of(context).getTranslated('logout')}", style:
                            TextStyle(fontSize: ScreenWidth(context)*0.045),),

                            onPressed  : () {
                              //FirebaseAuth.instance.signOut().then((value) {
                              //to sign out we use the sign out function
                              //then we pop until the sign in page by looking for the extension of it
                              FirebaseAuth.instance.signOut().then((value) {
                              Navigator.of(context).popUntil(ModalRoute.withName("/SignIn"));
                              });

                            } ,
                            style: ElevatedButton.styleFrom(
                                primary: Color.fromRGBO(200, 65, 70, 80),
                                minimumSize: Size(ScreenWidth(context)*0.6, ScreenHeight(context)*0.055),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                )
                            )
                        )
                    ),
                  ],
                )

              ],
            )
        ));
  }
}



