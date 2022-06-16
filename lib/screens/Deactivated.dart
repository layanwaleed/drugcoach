import 'package:drugcoach/screens/SignUp.dart';
import 'package:flutter/material.dart';

import '../applocal.dart';
import '../reusables/reusables.dart';

class DeactivedPage extends StatelessWidget {
  const DeactivedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: backgroundimage(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            children: [
              logopadding(context),
              titlepadding(
                  "${AppLocale.of(context).getTranslated('deactivated')}",
                  context),
              subtxt(context,
                  "${AppLocale.of(context).getTranslated('deactivatedpar')}"),
              Padding(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width * 0.02)),
              submitbtns(
                  context,
                  "${AppLocale.of(context).getTranslated('signup')}",
                  false,
                  false,
                  () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpPage()),
                        ),
                      })
            ],
          ),
        ),
      ),
    );
  }
}
