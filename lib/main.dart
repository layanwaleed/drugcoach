import 'dart:async';

import 'package:drugcoach/applocal.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:drugcoach/screens/SignIn.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dcdg/dcdg.dart';
var lang = 'en';
void main() async {
  //the following code ensure that the firebase is running and initialized before running the app
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //sharedPreferences.setString('lang', 'en');
  //lang = sharedPreferences.getString('lang')!;
  //Locale locale = Locale('${sharedPreferences.getString('lang')}','');
  runApp(MyApp());
}

class MyApp extends StatefulWidget {


  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state =
    context.findAncestorStateOfType<_MyAppState>();

    state?.setState(() {
      state.locale = newLocale;
    });
  }


  @override
  State<MyApp> createState() => _MyAppState();

  static of(BuildContext context) {
    return MyApp.of(context);
  }



}

class _MyAppState extends State<MyApp> {


  _fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();

    return Locale('${prefs.getString('language_code')}',
        prefs.getString('country_code'));
  }


  late Locale locale;

  @override
  void initState() {
    super.initState();
    this._fetchLocale().then((locale) {
      setState(() {
        this.locale = locale;
      });
    });
  }



  // root widget of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: this.locale,
      home: MainPage(),

      //this is used to decide rtl or ltr
      localizationsDelegates: [
        AppLocale.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate

      ],


      //to declare what language the application supports
      supportedLocales: [
        Locale('en' , ''),
        Locale('ar' , '')
      ],

      localeResolutionCallback: ( currentLocal , supportedLocales){

        //currentlocal is the actual device language
        //we need to see if it is null or not
        //if it is then the first supported local is returned which is english
        //otherwise the language of the device is returned if it is supported
        if(currentLocal != null){
          for ( Locale locale in supportedLocales ){
            if(currentLocal.languageCode == locale.languageCode) {
              return currentLocal;
            }
          }
        }
        return supportedLocales.first;
      },
    );
  }
  //




}
class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}
class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();

    Timer(
        Duration(seconds: 3),
            ()=>Navigator.pushReplacement(context,
                MaterialPageRoute(

                  //naming this route sign in to redirect the user here after log out
                    settings: RouteSettings(name: '/SignIn'),
                    builder: (context) => SignInPage())
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.1),
                  child: Image.asset('assets/logo.png'),
                ),

                Text(
                    "DrugCoach",
                    style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.065 , fontFamily: "Oswald"))
              ]
          )

      ),
    );

  }
}


