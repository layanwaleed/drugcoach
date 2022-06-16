import 'package:drugcoach/reusables/NavBar.dart';
import 'package:drugcoach/reusables/reusables.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../applocal.dart';
import '../reusables/AlertDialog.dart';
import 'Deactivated.dart';

class DeactivatePage extends StatefulWidget {
  const DeactivatePage({Key? key}) : super(key: key);

  @override
  State<DeactivatePage> createState() => _DeactivatePageState();
}

class _DeactivatePageState extends State<DeactivatePage> {
  TextEditingController _PasswordController = TextEditingController();

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
        body: Form(
          key: _Formkey,
          child: Center(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: Column(
                    // to display content vertically
                    children: [
                      blacktitle(context,
                          "${AppLocale.of(context).getTranslated('ydeactivate')}"),
                      subtxt(context,
                          "${AppLocale.of(context).getTranslated('deactiavtesubtxt')}"),
                      txtfields(
                          "${AppLocale.of(context).getTranslated('pass')}",
                          "${AppLocale.of(context).getTranslated('pass_hint')}",
                          true,
                          context,
                          _PasswordController),
                      Padding(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.height * 0.01)),
                      submitbtns(
                          context,
                          "${AppLocale.of(context).getTranslated('deactivate')}",
                          false,
                          false,
                          () => {
                                //in order to deactivate an account we need to check if the
                                //account exists or the right user is deactivating the account
                                //so we need to sign in the user with the current email and the password
                                //he/she entered and if the process was successful we then delete the account
                                //other wise an error will occur

                                if (_Formkey.currentState!.validate())
                                  {
                                    //signing in with credentials given
                                    FirebaseAuth.instance
                                        .signInWithEmailAndPassword(
                                            email: email.toString(),
                                            password: _PasswordController.text)
                                        .then((value) => value.user?.delete())
                                        .then((value) => {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DeactivedPage()),
                                              ),
                                            })
                                        .catchError((error) {
                                      showAlertDialog(
                                          context,
                                          false,
                                          "${AppLocale.of(context).getTranslated('error')}",
                                          "${AppLocale.of(context).getTranslated('deactivateerrorpar')}");
                                    })
                                  }
                              }),
                    ],
                  ),
                ),
                Column(
                  children: [homebtnpadding(context)],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
