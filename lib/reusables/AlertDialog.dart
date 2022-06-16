import 'package:flutter/material.dart';

import '../applocal.dart';
import '../screens/SignIn.dart';

class ShowAlertDialog extends StatelessWidget {
  final bool Success;
  final String txt;
  final String title;

  const ShowAlertDialog(
      {Key? key, required this.Success, required this.txt, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return showAlertDialog(context, Success , title, txt);
  }
}


//the following widget is used to show an alert message to the user in case of sign up success
//sign up failure or sign in failure and it was written alone because we need the constructor
//for the parameters

//it takes it in the context ( location of the widget ) , a boolean that tells if
//the process was successful or not with the title of the alert message , as well as the
//the message of success or the error that occurred

showAlertDialog(BuildContext context ,bool Success, String thetitle , themsg) {

  //in case of sign up we need 2 buttons in the alert msg one in which it pops back to the
  //sign up page and the other to redirect the user to the sign in page
  //to sign in and enter the app , so we created two buttons as shown below

  Widget okButton = TextButton(
    child: Text("${AppLocale.of(context).getTranslated('ok')}"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  Widget doneButton = TextButton(
    child: Text("${AppLocale.of(context).getTranslated('signin')}"),
    onPressed: () {
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => SignInPage()),);
    },
  );

  //Creating the alert dialog : we initialized it at first
  AlertDialog alert = new AlertDialog();


  //then if the process was successful we we show the box with the intended message and title
  //as well as the two buttons as the actions of the dialog
  if(Success) {
    alert = AlertDialog(
      title: Text(thetitle),
      content: Text("$themsg"),
      actions: [
        okButton,
        doneButton,
      ],
    );
  }

  //if it was a failure then one button will be shown at the bottom of the dialog which pops the user
  //back to the signup page with description of the error
  else {

    alert = AlertDialog(
      title: Text(thetitle),
      content: Text("$themsg"),
      actions: [
        okButton
      ],
    );

  }


  // lastly we need to show the dialog , and we do that by using the showdialog() function
  //it shows the dialog above the context with a dimmed background
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}