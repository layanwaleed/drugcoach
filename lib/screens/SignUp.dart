import 'package:drugcoach/reusables/AlertDialog.dart';
import 'package:drugcoach/reusables/reusables.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../applocal.dart';
import 'SignIn.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  //to get the hight and width of the device so that we can have dynamic paddings and not static
  double ScreenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  double ScreenWidth(BuildContext context) => MediaQuery.of(context).size.width;

  //username controller to control username of the user with what he/she entered
  TextEditingController _UsernameTextController = TextEditingController();

  //email controller that will be used to monitor what the user enters
  TextEditingController _EmailTextController = TextEditingController();

  //password controller that is used to monitor what the user enters
  TextEditingController _PasswordTextController = TextEditingController();

// verify password controller that is used to monitor what the user enters
  TextEditingController _VerifyPasswordTextController = TextEditingController();

  //the following line of code is used to validate the form information
  //the global key is used because it can access the current formstate
  //which the normal keys cannot do , this global key is mainly used for
  //form validation using .validate() function that will be used below
  final GlobalKey<FormState> _Formkey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Container(
      decoration: backgroundimage(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Form(
            key: _Formkey,
            child: Center(
              child: Column(
                // to display content vertically
                children: [
                  //to display logo at the top of the page
                  logopadding(context),

                  //to display the title of the page
                  titlepadding(
                      "${AppLocale.of(context).getTranslated('signup')}",
                      context),

                  //username txt field
                  txtfields(
                      "${AppLocale.of(context).getTranslated('username')}",
                      "${AppLocale.of(context).getTranslated('usernamehinttxt')}",
                      false,
                      context,
                      _UsernameTextController),
                  //email textfield
                  txtfields(
                      "${AppLocale.of(context).getTranslated('email')}",
                      "${AppLocale.of(context).getTranslated('email_hint')}",
                      false,
                      context,
                      _EmailTextController),
                  //password textfield
                  txtfields(
                      "${AppLocale.of(context).getTranslated('pass')}",
                      "${AppLocale.of(context).getTranslated('pass_hint')}",
                      true,
                      context,
                      _PasswordTextController),
                  //verify password
                  txtfields(
                      "${AppLocale.of(context).getTranslated('verifypass')}",
                      "${AppLocale.of(context).getTranslated('pass_hint')}",
                      true,
                      context,
                      _VerifyPasswordTextController),

                  //sign up button
                  submitbtns(
                      context,
                      "${AppLocale.of(context).getTranslated('signup')}",
                      false,
                      true,
                      () => {
                            //first we need to check if the user entered all form field
                            //by using the key with the .validate() function that validates
                            //all form fields and returns true if no errors found
                            if (_Formkey.currentState!.validate())
                              {
                                //if no errors found then the account will be created based on what the user enters
                                if (_PasswordTextController.text ==
                                    _VerifyPasswordTextController.text)
                                  {
                                    //if the user verified the password correctly then an account will be created
                                    // create a user with the email and password given
                                    FirebaseAuth.instance
                                        .createUserWithEmailAndPassword(
                                            email: _EmailTextController.text,
                                            password:
                                                _PasswordTextController.text)
                                        .then((value) => {
                                              //if an account was created successfully then add the username to the account as the Displayname
                                              value.user?.updateDisplayName(
                                                  _UsernameTextController.text),
                                              //then show a successful regeistration message
                                              showAlertDialog(
                                                  context,
                                                  true,
                                                  "${AppLocale.of(context).getTranslated('successreg')}",
                                                  "${AppLocale.of(context).getTranslated('successpar')}"),
                                            })
                                        .onError((error, stackTrace) => {
                                              //if an error occurred such as wrong email format or email already in use or not long enough pass
                                              //an error message will occur
                                              showAlertDialog(
                                                  context,
                                                  false,
                                                  "${AppLocale.of(context).getTranslated('error')}",
                                                  "${AppLocale.of(context).getTranslated('signuperrormsg')}"),
                                            })
                                  }
                                else
                                  {
                                    showAlertDialog(
                                        context,
                                        false,
                                        "${AppLocale.of(context).getTranslated('error')}",
                                        "${AppLocale.of(context).getTranslated('passverifyerror')}"),
                                  }
                              }
                          }),

                  //to display the text that redirects the user to sign in page
                  Padding(
                    padding: EdgeInsets.only(
                        left: ScreenWidth(context) * 0.16,
                        right: ScreenWidth(context) * 0.15,
                        top: ScreenHeight(context) * 0.03),
                    child: Row(children: [
                      Text(
                          "${AppLocale.of(context).getTranslated('haveaccount')}",
                          style: TextStyle(
                              fontSize: ScreenHeight(context) * 0.022)),
                      TextButton(
                          child: Text(
                            "${AppLocale.of(context).getTranslated('signin')}",
                            style: TextStyle(
                                fontSize: ScreenHeight(context) * 0.022),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignInPage()),
                            );
                          })
                    ]),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
