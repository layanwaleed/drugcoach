import 'package:drugcoach/reusables/reusables.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../applocal.dart';
import '../reusables/AlertDialog.dart';
import 'SignIn.dart';

class ForgotPassPage extends StatefulWidget {
  const ForgotPassPage({Key? key}) : super(key: key);

  @override
  State<ForgotPassPage> createState() => _ForgotPassPageState();
}

class _ForgotPassPageState extends State<ForgotPassPage> {
  @override
  //to get the hight and width of the device so that we can have dynamic paddings and not static
  double ScreenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  double ScreenWidth(BuildContext context) => MediaQuery.of(context).size.width;

  TextEditingController _EmailTextController = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Container(
      decoration: backgroundimage(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Form(
          key: _formkey,
          child: Center(
            child: Column(
              // to display content vertically
              children: [
                //to display logo at the top of the page
                logopadding(context),

                //to display the title of the page
                titlepadding(
                    "${AppLocale.of(context).getTranslated('forgot_pass')}",
                    context),

                //to display the text to tell the user what to do.
                subtxt(context,
                    "${AppLocale.of(context).getTranslated('forgotpasssubtxt')}"),

                //displaying the email text field
                txtfields(
                    "${AppLocale.of(context).getTranslated('email')}",
                    "${AppLocale.of(context).getTranslated('email_hint')}",
                    false,
                    context,
                    _EmailTextController),

                //a padding to make a space between widgets
                Padding(padding: EdgeInsets.all(5)),

                //submit button to send the email
                submitbtns(
                    context,
                    "${AppLocale.of(context).getTranslated('resetpass')}",
                    false,
                    false,
                    () => {
                          //first we need to check if the field is empty or not
                          if (_formkey.currentState!.validate())
                            {
                              //if not empty then we send an email to the given email address to reset password
                              FirebaseAuth.instance
                                  .sendPasswordResetEmail(
                                      email: _EmailTextController.text)
                                  .then((value) => {
                                        //if an email was sent then we want to chow the circular indicator to tell the user
                                        //that work behind the scene is being done but we need to alert the user first
                                        //that an email was sent by an alert dialog so we put the indicator first because it
                                        //runs in the back then the alert occurs and after clicking ok then the indicator
                                        //is still there then the user will be redirected to the sign in page
                                        showDialog(
                                            context: context,
                                            builder: (context) => const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                )),
                                      })
                                  .then((value) => {
                                        showAlertDialog(
                                            context,
                                            false,
                                            "${AppLocale.of(context).getTranslated('passreset')}",
                                            "${AppLocale.of(context).getTranslated('resetpar')}"),
                                        Future.delayed(
                                            Duration(seconds: 5),
                                            () => {
                                                  Navigator.popUntil(
                                                      context,
                                                      ModalRoute.withName(
                                                          "/SignIn")),
                                                })
                                      })
                                  .onError((error, stackTrace) => {
                                        showAlertDialog(
                                            context,
                                            false,
                                            "${AppLocale.of(context).getTranslated('error')}",
                                            "${AppLocale.of(context).getTranslated('passerror')}"),
                                      })
                            }
                        }),

                Padding(
                  padding: EdgeInsets.only(
                      left: ScreenWidth(context) * 0.01,
                      top: ScreenHeight(context) * 0.10),
                  child: TextButton(
                      child: Text(
                        "${AppLocale.of(context).getTranslated('backtosignin')}",
                        style: TextStyle(fontSize: 18.0),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignInPage()),
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
