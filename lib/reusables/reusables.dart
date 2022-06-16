//this is file is used to write every widget that will be reused in many screens
//to reduce duplicate code



import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../applocal.dart';
import '../main.dart';
import '../screens/Home.dart';


var txt = 'عربي';
//the following widget is used to set the background image to all screens and
//to ensure that all screens have the same background image and size
//it returns a box decoration
BoxDecoration backgroundimage(){
  return const BoxDecoration(
    image: DecorationImage( // creates an image to show
      image: AssetImage("assets/bg.jpeg"),//setting the image from the assets file
      fit: BoxFit.cover,//setting the size fo the image to cover the whole screen
    ),
  );
}


//the following widget is to display the logo in the same place all over the outer pages
Padding logopadding(BuildContext context){
  return Padding(
      padding: EdgeInsets.only(
        //setting the paddings of the img to be in the center of every page
          left : MediaQuery.of(context).size.width * 0.07,
          top: MediaQuery.of(context).size.height * 0.05,
          bottom : MediaQuery.of(context).size.height * 0.02
      ),
      child :Image.asset('assets/logo.png',width: MediaQuery.of(context).size.width * 0.46,) //getting the image and setting it to size 200
  );
}

//to display the title with padding to the left in each screen
Padding titlepadding(String text , BuildContext context){
  return Padding(padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02 , bottom: MediaQuery.of(context).size.height * 0.03),
    child : Text(text, style: TextStyle(fontFamily: "Oswald", fontSize: MediaQuery.of(context).size.width * 0.08),));
}



//the following widget is to display text fields depending on the parameters
Padding txtfields(String labeltxt , String hinttxt , bool ispass , BuildContext context ,TextEditingController controller ,  ){
  return Padding(
    //padding to make it look nice
    padding: EdgeInsets.only(
        left : MediaQuery.of(context).size.width * 0.05,
        right : MediaQuery.of(context).size.width * 0.05,
      bottom : MediaQuery.of(context).size.height * 0.015,
    ),
    child: TextFormField(

      //we need to check if this text field is a password or not , if so hide the content
      obscureText: ispass,

      //validator for all text field to make sure they are not empty
      validator: (value){
        if (value == null || value.isEmpty) return "${AppLocale.of(context).getTranslated('required')}";
      },

      //controller to control what to do with what the user enters
      controller: controller,
      // validator: validateUsername,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,

        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue ,width: MediaQuery.of(context).size.width * 0.004),
          borderRadius: BorderRadius.circular(15),
        ),

        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white ),
          borderRadius: BorderRadius.circular(15),
        ),

        labelText: labeltxt,
        hintText: hinttxt,



      ),
    ),
  );
}


//the following widget is to display the submit buttons all over the app
Container submitbtns(BuildContext context , String text , bool islogin , bool issignup , Function onTap){
  return Container(
    //we return a container the inside it is the button
    //we control the size of the container below
    width: MediaQuery.of(context).size.width * 0.85,
    height: MediaQuery.of(context).size.height * 0.05 ,

    //the button with its action based on the function sent as a parameter
    child: ElevatedButton(
      child: Text(
        text,
        style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.045),
      ),
      onPressed: () {
        onTap();
      },


      //styling the button
      style: ElevatedButton.styleFrom(
          primary: Color.fromRGBO(209, 106, 110, 1),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          )),),
  );
}


//the following widget is for the app bar at the top of each screen
//it returns an app bar which is basically the tool bar of the app
AppBar theappbar(BuildContext context) {
  return AppBar(
    leading: Builder(builder: (BuildContext context) {
      //leading means the main action happening in the appbar which in our case is to open a menu
      //the leading action is alocated to the profile icon which we gave size and color below
      return IconButton(
        icon: Icon(
          Icons.account_circle,
          color: Color.fromRGBO(200, 65, 70, 80),
          size: MediaQuery.of(context).size.width * 0.1,
        ),
        onPressed: () {
          //we we press the leading icon the menu opens which is the drawer in the app
          Scaffold.of(context).openDrawer();
        },

        //the tool tip will tell the user what the button will do if clicked
        //it appears after long pressing on the icon button
        tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
      );
    }
    ),

    actions: [
      TextButton(
          onPressed: ()=>{
            if(_getLanguageCode(context) == 'en'){
              MyApp.setLocale(context, Locale('ar', '')),
            }

            else
              MyApp.setLocale(context, Locale('en', '')),

          },
          child: Text(
              _getLanguageCode(context) == 'en' ? 'عربي' : 'English'))
    ],


    //below we set the bg color and the height of the app bar in general
    backgroundColor: Color(0xffd8e5f1),



    //to remove the shadow of the appbar
    elevation: 0,

    //to center align the text
    centerTitle: true,


    //to display the DrugCoach text at the center
    title: Text(
      "DrugCoach",
      style: TextStyle(color: Colors.black, fontFamily: "Oswald", fontSize: MediaQuery.of(context).size.height * 0.04),
    ),
  );
}




_getLanguageCode(BuildContext context) {
  return Localizations.localeOf(context).languageCode;
}



Flexible servicesflex(BuildContext context , Function onTap , String image , String txt) {

  //flexible is used to give each service a specific space that it must stick to
  //it is usually used with rows and columns
  return Flexible(

    //to make the child of the flexible widget fill the entire space we use tight fit

    fit: FlexFit.tight,

    //a container is used to display each service
    child: Container(


      // to make all 4 services have the exact same height we use a constraint
        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.2),


        //setting the margin of each service container to make a space between them
        margin: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.03,
            top: MediaQuery.of(context).size.height * 0.02,
            right: MediaQuery.of(context).size.width * 0.03),


        //according to which service , the user will be redirected to that service page
        //we passed the function of redirecting the user as a parameter
        child: ElevatedButton(
          onPressed: () {
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => AwarenessPage()));

            onTap();
          },

          //to make the background of the container grey
          style: ElevatedButton.styleFrom(
              primary: Color.fromRGBO(237, 237, 237, 1)),

          //then to diplay the image and text we put them in a column inside the container
          //to display them vertically

          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
                child: Container(

                  //to make the images of all logos the same size and location
                  constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.095),
                  //displaying the image of the service with a dynamic width
                  child: Image.asset(
                    image,
                    width: MediaQuery.of(context).size.width * 0.23,
                  ),
                ),
              ),

              Container(
                //displaying the text of the service
                child: Text(
                  txt,
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.05, color: Color.fromRGBO(203, 84, 88, 1)),
                ),
              )
            ],
          ),
        )),
  );
}



//the following widget is to display the title of the pages that are used after log in
//it displays the title in a black , size 46 font and left align it
Padding blacktitle(BuildContext context , String txt){

  return Padding(
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.05,
          right: MediaQuery.of(context).size.width * 0.05,
          top: MediaQuery.of(context).size.height * 0.05),
      child : Text(txt, style: TextStyle(fontSize:MediaQuery.of(context).size.width * 0.11 , fontFamily: "Oswald"))

  );

}


//the following widget is used to display the sub text in grey left aligned font
Padding subtxt(BuildContext context , String txt){
  return Padding(
    padding: EdgeInsets.only(
      top : MediaQuery.of(context).size.height * 0.01,
      left : MediaQuery.of(context).size.width * 0.05,
      right:  MediaQuery.of(context).size.width * 0.05,
      bottom:  MediaQuery.of(context).size.height * 0.03,
    ),
    child: Text(txt , style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.06 , fontFamily: "Oswald" , color: Colors.grey)),

  );
}


//the following widget is the FAQs Widget wher eit is called for each FAQ
Widget FAQspadding(BuildContext context, String txt, String Question) {
  return Padding(

    //bottom padding
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height * 0.02,
        left:MediaQuery.of(context).size.width * 0.05,
        right: MediaQuery.of(context).size.width * 0.05,),
      //expansion tile is used because it is a single line with an expansion arrow
      //its child will be displayed when clicked
      child: ExpansionTile(
        //to display a grey color when the tile is expanded
        backgroundColor: Color.fromRGBO(237, 237, 237, 1),
        title: Text(
          //to display the question
          Question,
          style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.053, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        children: [

          //listtile is what will be display after expansion
          ListTile(
              title: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.03) ,
                child: Text(
                  txt , style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.045),
                ),
              ))
        ],
      ));
}



//the following reusable widget is for the tabs inside the baar in the awareness page
//it will be used 5 time for each tab
Container thecontainer(String txt, Icon theicon, BuildContext context,
    int selectedTab , int currenttab) {
  return Container(


    //to give each tab a max width
    constraints: BoxConstraints(
        //maxWidth: MediaQuery.of(context).size.width * 0.3,
    minWidth: MediaQuery.of(context).size.width * 0.15,
    //maxHeight:  MediaQuery.of(context).size.height * 0.5
    ),


    child: Column(children: [

      //this is for the Why tab
      theicon,
      Text(txt, style: TextStyle(
          color:
          selectedTab == currenttab ? Colors.blue : Colors.black),)
    ]),
    padding:
    EdgeInsets.only(
        left: MediaQuery
        .of(context)
        .size
        .width * 0.03,
        right: MediaQuery
            .of(context)
            .size
            .width * 0.02,


        top: MediaQuery
            .of(context)
            .size
            .height * 0.008),

  );

}


Padding homebtnpadding(context){
  return Padding(
    padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.4,
        right: MediaQuery.of(context).size.width * 0.4,
      //bottom: MediaQuery.of(context).size.height * 0.01,
    ),
    child: Container(
        child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },

            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              primary: Color.fromRGBO(209, 106, 110, 1),
            ),
            child: Icon(Icons.home),

            )
        )
    );
}

//the following widget is to display the title of each awareness tab according
//to what selected tap is currently showing and since the title will not change
//we set the here based on the selected tab
Container awarenesstitle(BuildContext context , int selectedTab){

  String txt = "";

  if(selectedTab == 1) {
    txt = "${AppLocale.of(context).getTranslated('whytxt')}";
  }
  else if ( selectedTab == 2){
    txt = "${AppLocale.of(context).getTranslated('symptomstxt')}";
  }
  else if ( selectedTab == 3){
    txt = "${AppLocale.of(context).getTranslated('sidetxt')}";
  }
  else if ( selectedTab == 4) {
    txt = "${AppLocale.of(context).getTranslated('preventiontxt')}";
  }
  else {
    txt = "${AppLocale.of(context).getTranslated('treatmenttxt')}";
  }
  return Container(
    height: MediaQuery.of(context).size.height * 0.165,

    child: Padding(
        padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.04,
            right: MediaQuery.of(context).size.width * 0.04,
            top: MediaQuery.of(context).size.height * 0.02,
            bottom: MediaQuery.of(context).size.height * 0.02),
        child: Text(txt , style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.08,fontWeight: FontWeight.bold, color:  Color.fromRGBO(186, 62, 75, 10),),)),
  );
}



Padding Redtitle(String txt , BuildContext context){
  return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.06,
          bottom: MediaQuery.of(context).size.height * 0.02),
      child : Text(txt , style: TextStyle(
          fontSize: MediaQuery.of(context).size.height * 0.05,
          color: Color.fromRGBO(186, 62, 75, 10),
          fontFamily: "Oswald" ))

  );
}

Uri callrehab(String phone){
  return Uri(
    scheme: "tel",
    path: phone
  );
}

Uri rehablocation(String location){
  return Uri(
    scheme:"https",
    path: location
  );
}