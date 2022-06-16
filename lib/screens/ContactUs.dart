import 'package:drugcoach/reusables/NavBar.dart';
import 'package:drugcoach/reusables/reusables.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../applocal.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({Key? key}) : super(key: key);

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  @override
  //to get the height and width of the device so that we can have dynamic paddings and not static
  double ScreenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  double ScreenWidth(BuildContext context) => MediaQuery.of(context).size.width;

  final GlobalKey<FormState> _Formkey = GlobalKey<FormState>();

  TextEditingController _SubjectTextController = TextEditingController();
  TextEditingController _MessageTextController = TextEditingController();

  //creating the Uri for the email button to create an email path
  static Uri _emailLaunchUri = Uri();

  Widget build(BuildContext context) {
    //to get the info of the currently logged in user
    User? user = FirebaseAuth.instance.currentUser;

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
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: Column(
                        children: [
                          //to display the title of the page
                          blacktitle(context,
                              "${AppLocale.of(context).getTranslated('contact')}"),

                          //to display the sub text
                          subtxt(context,
                              "${AppLocale.of(context).getTranslated('howtohelp')}"),

                          txtfields(
                              "${AppLocale.of(context).getTranslated('subject')}",
                              "${AppLocale.of(context).getTranslated('subjecthint')}",
                              false,
                              context,
                              _SubjectTextController),

                          Padding(
                            //this padding is for the user to input the message
                            padding: EdgeInsets.only(
                                left: ScreenWidth(context) * 0.05,
                                right: ScreenWidth(context) * 0.05,
                                bottom: ScreenHeight(context) * 0.05),

                            child: Container(
                              color: Colors.white,
                              child: TextFormField(
                                controller: _MessageTextController,
                                validator: (value) {
                                  //validation of text field not empty
                                  if (value == null || value.isEmpty) {
                                    return "${AppLocale.of(context).getTranslated('required')}";
                                  }
                                },

                                //to be able to write multi lines in the message field
                                maxLines: 8,
                                keyboardType: TextInputType.multiline,

                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue,
                                        width: ScreenWidth(context) * 0.005),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  labelText:
                                      "${AppLocale.of(context).getTranslated('msg')}",
                                  hintText:
                                      "${AppLocale.of(context).getTranslated('msghint')}",
                                ),
                              ),
                            ),
                          ),

                          submitbtns(context, "${AppLocale.of(context).getTranslated('submit')}", false, false, () => {
                                    //if validation is successful , we create the email path
                                    if (_Formkey.currentState!.validate())
                                      {
                                        //to create the Uri we need to specify the path
                                        //email or tel or sms or etc
                                        //we want to send an email so we use mailto
                                        //and the path component is the recipient
                                        //the the query parameters are the subject of the email and
                                        //the body which is the message
                                        _emailLaunchUri = Uri(
                                          scheme: 'mailto',
                                          path: 'lay20180193@std.psut.edu.jo',
                                          queryParameters: {
                                            'subject':
                                                _SubjectTextController.text,
                                            'body': _MessageTextController.text
                                          },
                                        ),

                                        //then we launch the url
                                        launchUrl(_emailLaunchUri),

                                        //this method actually opens the mail app in the phone instead of
                                        //sending the email directly from the app
                                      }
                                  }),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        homebtnpadding(context),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
