import 'package:drugcoach/reusables/AlertDialog.dart';
import 'package:drugcoach/reusables/NavBar.dart';
import 'package:drugcoach/reusables/reusables.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../applocal.dart';

class ChangePassPage extends StatefulWidget {
  const ChangePassPage({Key? key}) : super(key: key);

  @override
  State<ChangePassPage> createState() => _ChangePassPageState();
}

class _ChangePassPageState extends State<ChangePassPage> {
  //controller for the textfields
  TextEditingController _OldPasswordController = TextEditingController();
  TextEditingController _NewPasswordController = TextEditingController();
  TextEditingController _VerifyPasswordController = TextEditingController();

  //the following line of code is used to validate the form information
  //the global key is used because it can access the current formstate
  //which the normal keys cannot do , this global key is mainly used for
  //form validation using .validate() function that will be used below
  final GlobalKey<FormState> _Formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //to get the current logged in user
    User? user = FirebaseAuth.instance.currentUser;

    //storing the email of the current user
    String? email = user?.email;
    return Container(
        decoration: backgroundimage(),
        child: Scaffold(
          drawer: NavBar(),
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          appBar: theappbar(context),
          body: SingleChildScrollView(
            child: Form(
              key: _Formkey,
              child: Center(
                child: Column(children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: Column(
                      // to display content vertically
                      children: [
                        blacktitle(context,
                            "${AppLocale.of(context).getTranslated('changepass')}"),
                        subtxt(context,
                            "${AppLocale.of(context).getTranslated('changepasssubtxt')}"),
                        txtfields(
                            "${AppLocale.of(context).getTranslated('oldpass')}",
                            "${AppLocale.of(context).getTranslated('oldpasshint')}",
                            true,
                            context,
                            _OldPasswordController),
                        txtfields(
                            "${AppLocale.of(context).getTranslated('newpass')}",
                            "${AppLocale.of(context).getTranslated('newpasshint')}",
                            true,
                            context,
                            _NewPasswordController),
                        txtfields(
                            "${AppLocale.of(context).getTranslated('verifynew')}",
                            "${AppLocale.of(context).getTranslated('verifynew')}",
                            true,
                            context,
                            _VerifyPasswordController),
                        Padding(
                            padding: EdgeInsets.all(
                                MediaQuery.of(context).size.height * 0.02)),

                        //submit button
                        submitbtns(
                            context,
                            "${AppLocale.of(context).getTranslated('changepass')}",
                            false,
                            false,
                            () => {
                                  //in order to change the password we need to first check if the old one is correct
                                  //to do so we need to sign in with the email and password , if the sign in process
                                  //was successful then the password is correct other wise wrong password entered

                                  if (_Formkey.currentState!.validate())
                                    {
                                      if (_NewPasswordController.text ==
                                          _VerifyPasswordController.text)
                                        {
                                          //signing in with credentials given
                                          FirebaseAuth.instance
                                              .signInWithEmailAndPassword(
                                                  email: email.toString(),
                                                  password:
                                                      _OldPasswordController
                                                          .text)

                                              //if success then we update the the password to what the user entered
                                              .then((value) => value.user
                                                  ?.updatePassword(
                                                      _NewPasswordController
                                                          .text)
                                                  .then(
                                                      (value) => showAlertDialog(
                                                          context,
                                                          false,
                                                          "${AppLocale.of(context).getTranslated('passchanged')}",
                                                          "${AppLocale.of(context).getTranslated('passchangesuccess')}")

                                                      //if an error occured the error wil be displayed in the dialog
                                                      ))
                                              .catchError((error)  {
                                                    showAlertDialog(
                                                        context,
                                                        false,
                                                        "${AppLocale.of(context).getTranslated('error')}",
                                                        "${AppLocale.of(context).getTranslated('passchangeerror')}");
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
                      ],
                    ),
                  ),
                  Column(
                    children: [homebtnpadding(context)],
                  )
                ]),
              ),
            ),
          ),
        ));
  }
}
