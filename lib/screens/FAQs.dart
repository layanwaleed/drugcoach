import 'package:drugcoach/reusables/NavBar.dart';
import 'package:drugcoach/reusables/reusables.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../applocal.dart';

class FAQsPage extends StatefulWidget {
  const FAQsPage({Key? key}) : super(key: key);

  @override
  State<FAQsPage> createState() => _FAQsPageState();
}

class _FAQsPageState extends State<FAQsPage> {
  //creating a list for all question and answers in the db
  var Questions = [];
  var Answers = [];

  var aQuestions = [];
  var aAnswers = [];

  @override
  void initState() {
    super.initState();

    //we reference the table(although not actually a table due to it being NOSQL)
    //the FAQs info
    DatabaseReference faqdb = FirebaseDatabase.instance.ref().child("FAQs");
    DatabaseReference afaqdb = FirebaseDatabase.instance.ref().child("AFAQs");

    //get the data once and then do some things
    faqdb.once().then((event) {
      //we then for loop inside the db to get every question and answer
      //the structure of the db is
      //db
      //FAQs + Rehab + Drugs
      //Inside the rehab we have 5 children each with a key of unique num ( 1 to 5 )
      //each key has its question and answer so to access all questions and answers
      //we need to go to faq then each key then each question and answer
      //and add them to their relative lists to display them later.

      //to get the number of faqs
      final num = event.snapshot.children;

      for (int i = 1; i <= num.length; i++) {
        final snapshot = event.snapshot.child("$i");
        final qsnapshot = snapshot.child("Question");
        final asnapshot = snapshot.child("Answer");

        Questions.add(qsnapshot.value);
        Answers.add(asnapshot.value);

        setState(() {});
      }
    });

    afaqdb.once().then((event) {

      final num = event.snapshot.children;

      for (int i = 1; i <= num.length; i++) {
        final snapshot = event.snapshot.child("$i");
        final qsnapshot = snapshot.child("Question");
        final asnapshot = snapshot.child("Answer");

        aQuestions.add(qsnapshot.value);
        aAnswers.add(asnapshot.value);

        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: backgroundimage(),
      child: Scaffold(
        drawer: NavBar(),
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        appBar: theappbar(context),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              // to display content vertically
              children: [
                Container(
                    height: MediaQuery.of(context).size.height * 0.8,

            child : SingleChildScrollView(
              child: Column(
                  children: [
                    //the following padding is to display the title of the page in red at the center
                    Redtitle("${AppLocale.of(context).getTranslated('faq')}", context),

                    //iterating through the lists to display the FAQs

                    if(_getLanguageCode(context) == 'en')
                    for (int i = 0; i < Answers.length; i++)
                      FAQspadding(context, Answers[i], Questions[i])

                    else
                      for (int i = 0; i < aAnswers.length; i++)
                        FAQspadding(context, aAnswers[i], aQuestions[i]),
                  ],
              ),
            )

    ),
                Column(
                  children: [
                    homebtnpadding(context)
                  ],
                )
              ],
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

