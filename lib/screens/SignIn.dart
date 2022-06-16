import 'package:drugcoach/applocal.dart';
import 'package:drugcoach/main.dart';
import 'package:drugcoach/reusables/reusables.dart';
import 'package:drugcoach/screens/Home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../reusables/AlertDialog.dart';
import 'ForgotPass.dart';
import 'SignUp.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  //to get the hight and width of the device so that we can have dynamic paddings and not static
  double ScreenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  double ScreenWidth(BuildContext context) => MediaQuery.of(context).size.width;

  //email controller that will be used to monitor what the user enters
  TextEditingController _EmailTextController = TextEditingController();

  //password controller that is used to monitor what the user enters
  TextEditingController _PasswordTextController = TextEditingController();

  //the following line of code is used to validate the form information
  //the global key is used because it can access the current formstate
  //which the normal keys cannot do , this global key is mainly used for
  //form validation using .validate() function that will be used below
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  //creating the Uri that make the button actually call using the urilauncher package
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: "911",
  );

  void initState() {
    super.initState();
    setState(() {});
  }

  Widget build(BuildContext context) {
    return Container(
      decoration: backgroundimage(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Center(
              child: Column(
                // to display content vertically
                children: [
                  //to display logo at the top of the page
                  logopadding(context),

                  //to display the title of the page
                  titlepadding(
                      "${AppLocale.of(context).getTranslated('welcome_statement')}",
                      context),

                  //email textfield
                  txtfields(
                      "${AppLocale.of(context).getTranslated('email')}",
                      "${AppLocale.of(context).getTranslated('email_hint')}",
                      false,
                      context,
                      _EmailTextController),
                  txtfields(
                      "${AppLocale.of(context).getTranslated('pass')}",
                      "${AppLocale.of(context).getTranslated('pass_hint')}",
                      true,
                      context,
                      _PasswordTextController),

                  Padding(

                      //this padding is for the button if the user forgot his password
                      padding: EdgeInsets.only(
                          left: ScreenWidth(context) * 0.5,
                          bottom: ScreenHeight(context) * 0.01),
                      child: TextButton(
                          child: Text(
                            "${AppLocale.of(context).getTranslated('forgot_pass')}",
                            style: TextStyle(
                                fontSize: ScreenHeight(context) * 0.022),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForgotPassPage()),
                            );
                          })),

                  submitbtns(context, "${AppLocale.of(context).getTranslated('signin')}", true, false, () => {
                            //when the user clicks on the sign in button first it will validate
                            //if the field are empty or not using the textformfield validators in the reusable widgets
                            //then it comes here to validate whether the entered text is in the required format (email and password)
                            //then if the validation is successful it signs in with the given credintials
                            //if the sign in was successful the user will be redirected to the home page
                            //otherwise an alert message will appear with the error in it.
                            if (_formkey.currentState!.validate())
                              {
                                FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                        email: _EmailTextController.text,
                                        password: _PasswordTextController.text)
                                    .then((value) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomePage()),
                                  );
                                }).onError((error, stackTrace) {
                                  showAlertDialog(
                                      context,
                                      false,
                                      "${AppLocale.of(context).getTranslated('error')}",
                                      "${AppLocale.of(context).getTranslated('errormsg')}");
                                }),
                              }
                          }),

                  //to display the text below the button that redirects to sign up page
                  Padding(
                    padding: EdgeInsets.only(
                        left: ScreenWidth(context) * 0.2,
                        right: ScreenWidth(context) * 0.1,
                        top: ScreenHeight(context) * 0.01),
                    child: Row(children: [
                      Text(
                          "${AppLocale.of(context).getTranslated('donthaveaccount')}",
                          style: TextStyle(
                              fontSize: ScreenHeight(context) * 0.022)),
                      TextButton(
                          child: Text(
                            "${AppLocale.of(context).getTranslated('signup')}",
                            style: TextStyle(
                                fontSize: ScreenHeight(context) * 0.022),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpPage()),
                            );
                          }),
                    ]),
                  ),

                  Container(
                      margin: EdgeInsets.only(
                          top: ScreenHeight(context) * 0.02,
                          bottom: ScreenHeight(context) * 0.02),
                      width: ScreenWidth(context) * 0.7,
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
                              margin: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width * 0.035, right: MediaQuery.of(context).size.width *
                                      0.035),
                              child: Image.asset(
                                'assets/contact.png',
                                width: MediaQuery.of(context).size.width * 0.115,
                              ),
                              padding: EdgeInsets.only(
                                  top:
                                      MediaQuery.of(context).size.height * 0.01,
                                  bottom: MediaQuery.of(context).size.height *
                                      0.01),
                            ),


                            Container(
                              margin: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width *
                                      0.045),
                              child: Text(
                                "${AppLocale.of(context).getTranslated('callforhelp')}",
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.055,
                                    color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      )),
                  Container(
                      child: TextButton(
                    child: Text(
                        _getLanguageCode(context) == 'en' ? 'عربي' : 'English'),
                    onPressed: () {
                      if (_getLanguageCode(context) == 'en') {
                        MyApp.setLocale(context, Locale('ar', ''));
                      } else {
                        MyApp.setLocale(context, Locale('en', ''));
                      }
                    },
                  ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

_getLanguageCode(BuildContext context) {
  print(Localizations.localeOf(context).languageCode);
  return Localizations.localeOf(context).languageCode;
}
