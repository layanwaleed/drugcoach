import 'dart:ffi';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../applocal.dart';
import '../reusables/NavBar.dart';
import '../reusables/reusables.dart';

class SearchForDrugPage extends StatefulWidget {
  const SearchForDrugPage({Key? key}) : super(key: key);

  @override
  State<SearchForDrugPage> createState() => _SearchForDrugPageState();
}

class _SearchForDrugPageState extends State<SearchForDrugPage> {
  List drugName = [];
  List drugWarning = [];
  List drugSideEffects = [];
  List drugDescription = [];
  List drugDosing = [];

  List Resultlist = [];
  var resultindex;

  TextEditingController _searchcontroller = TextEditingController();

  @override
  void initState() {
    super.initState();

    //we reference the table(although not actually a table due to it being NOSQL)
    //the FAQs info
    DatabaseReference drugsdb = FirebaseDatabase.instance.ref().child("drugs");

    //get the data once and then do some things
    drugsdb.once().then((event) {
      final num = event.snapshot.children.length;

      for (int i = 1; i <= num; i++) {
        final snapshot = event.snapshot.child("$i");
        final name = snapshot.child("Name");
        final description = snapshot.child("Description");
        final dosing = snapshot.child("Dosing");
        final sideeffect = snapshot.child("Side Effects");
        final warning = snapshot.child("Warnings");
        drugName.add(name.value);
        drugDescription.add(description.value);
        drugDosing.add(dosing.value);
        drugSideEffects.add(sideeffect.value);
        drugWarning.add(warning.value);

        _searchcontroller.addListener(_SearchOnChange);
        setState(() {});
      }
    });
  }

  _SearchOnChange() {
    var showResult = [];

    if (_searchcontroller != "") {
      for (int i = 0; i < drugName.length; i++) {
        if (_searchcontroller.text.toLowerCase() ==
            drugName[i].toString().toLowerCase()) {
          resultindex = i;
          showResult.add(drugName[i].toString());
          showResult.add(drugDescription[i].toString());
          showResult.add(drugDosing[i].toString());
          showResult.add(drugSideEffects[i].toString());
          showResult.add(drugWarning[i].toString());
        }
      }
    }

    setState(() {
      Resultlist = showResult;
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
        body: Center(
          child: Column(
            // to display content vertically
            children: [
              Container(
                color: Colors.white,
                margin:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
                child: TextField(
                  controller: _searchcontroller,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText:
                        "${AppLocale.of(context).getTranslated('drugname')}",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.blue,
                          width: MediaQuery.of(context).size.width * 0.004),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              if (Resultlist.isEmpty)
                Container(
                    color: const Color.fromRGBO(237, 237, 237, 1),
                    height: MediaQuery.of(context).size.height * 0.7,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "${AppLocale.of(context).getTranslated('entervalid')}",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.08),
                        textAlign: TextAlign.center,
                      ),
                    ))
              else
                drugcontainer(context, Resultlist),
              homebtnpadding(context),
            ],
          ),
        ),
      ),
    );
  }
}

Container drugcontainer(BuildContext context, List Resultlist) {
  return Container(
    color: const Color.fromRGBO(237, 237, 237, 1),
    height: MediaQuery.of(context).size.height * 0.7,
    width: MediaQuery.of(context).size.width * 0.9,
    child: SingleChildScrollView(
      child: Column(
        children: [
          Text(Resultlist[0].toString(),
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.05,
                  color: const Color.fromRGBO(186, 62, 75, 10),
                  fontFamily: "Oswald")),
          Text("${AppLocale.of(context).getTranslated('description')}",
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.08,
                  fontFamily: "Oswald"),
              textAlign: TextAlign.left),
          Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.08,
                right: MediaQuery.of(context).size.width * 0.07,
                top: MediaQuery.of(context).size.height * 0.01,
                bottom: MediaQuery.of(context).size.height * 0.01),
            child: Text(
              Resultlist[1].toString(),
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.025),
              textAlign: TextAlign.justify,
            ),
          ),
          Text("${AppLocale.of(context).getTranslated('dosing')}",
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.08,
                  fontFamily: "Oswald"),
              textAlign: TextAlign.left),
          Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.08,
                right: MediaQuery.of(context).size.width * 0.07,
                top: MediaQuery.of(context).size.height * 0.01,
                bottom: MediaQuery.of(context).size.height * 0.01),
            child: Text(
              Resultlist[2].toString(),
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.025),
              textAlign: TextAlign.justify,
            ),
          ),
          Text("${AppLocale.of(context).getTranslated('sidee')}",
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.08,
                  fontFamily: "Oswald"),
              textAlign: TextAlign.left),
          Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.08,
                right: MediaQuery.of(context).size.width * 0.07,
                top: MediaQuery.of(context).size.height * 0.01,
                bottom: MediaQuery.of(context).size.height * 0.01),
            child: Text(
              Resultlist[3].toString(),
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.025),
              textAlign: TextAlign.justify,
            ),
          ),
          Text("${AppLocale.of(context).getTranslated('warnings')}",
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.08,
                  fontFamily: "Oswald"),
              textAlign: TextAlign.left),
          Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.08,
                right: MediaQuery.of(context).size.width * 0.07,
                top: MediaQuery.of(context).size.height * 0.01,
                bottom: MediaQuery.of(context).size.height * 0.01),
            child: Text(
              Resultlist[4].toString(),
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.025),
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    ),
  );
}
