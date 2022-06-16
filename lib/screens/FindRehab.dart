import 'package:drugcoach/reusables/NavBar.dart';
import 'package:drugcoach/reusables/reusables.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../applocal.dart';

class FindRehabPage extends StatefulWidget {
  const FindRehabPage({Key? key}) : super(key: key);

  @override
  State<FindRehabPage> createState() => _FindRehabPageState();
}

class _FindRehabPageState extends State<FindRehabPage> {

  var Names = [];
  var Addresses = [];
  var Locations = [];
  var Phones = [];


  var aNames = [];
  var aAddresses = [];
  var aLocations = [];
  var aPhones = [];

  @override
  void initState() {
    super.initState();

    //we reference the table(although not actually a table due to it being NOSQL)
    //the FAQs info
    DatabaseReference rehabdb = FirebaseDatabase.instance.ref().child("Rehab");
    DatabaseReference arehabdb = FirebaseDatabase.instance.ref().child("ArabicRehab");

    //get the data once and then do some things
    rehabdb.once().then((event) {

      final num = event.snapshot.children.length;

      for (int i = 1; i <= num; i++) {
        final snapshot = event.snapshot.child("$i");
        final phone = snapshot.child("Phone");
        final location = snapshot.child("Location");
        final name = snapshot.child("Name");
        final address = snapshot.child("Address");

        Names.add(name.value);
        Locations.add(location.value);
        Phones.add(phone.value);
        Addresses.add(address.value);
        setState(() {});
      }
    });

    arehabdb.once().then((event) {

      final num = event.snapshot.children.length;

      for (int i = 1; i <= num; i++) {
        final snapshot = event.snapshot.child("$i");
        final phone = snapshot.child("Phone");
        final location = snapshot.child("Location");
        final name = snapshot.child("Name");
        final address = snapshot.child("Address");

        aNames.add(name.value);
        aLocations.add(location.value);
        aPhones.add(phone.value);
        aAddresses.add(address.value);

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
        body: Center(
          child: Column(
            children : [ SingleChildScrollView(
              child: Container(

          height: MediaQuery.of(context).size.height * 0.8,

                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column( // to display content vertically
                    children: [

                      Redtitle("${AppLocale.of(context).getTranslated('rehabfac')}", context),

                      if(_getLanguageCode(context) == 'en')
                      for(int i = 0 ; i<Names.length ; i++)
                        RehabPadding(Names[i],Addresses[i], context , Phones[i] , Locations[i])

                      else
                      for(int i = 0 ; i<aNames.length ; i++)
                        RehabPadding(aNames[i],aAddresses[i], context , aPhones[i] , aLocations[i]),
    ],
                  ),
                ),
              ),
            ),

              Column(
                children: [
                  homebtnpadding(context)
                ],
              )
    ]
          ),

        ),
      ),
    );
  }
}
Container RehabPadding(String rehabname , String address , BuildContext context , String phone , String location){
  return Container(
      height: MediaQuery.of(context).size.height * 0.35,
      width: MediaQuery.of(context).size.width * 0.78,
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              child: ListTile(
                leading: Icon(Icons.account_balance,
                    size: MediaQuery.of(context).size.width * 0.13),
                title: Text(rehabname, style: TextStyle(fontSize:  MediaQuery.of(context).size.width * 0.04, fontWeight: FontWeight.bold),),
                subtitle: Text(address),
              ),
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.03 ,
                    right: MediaQuery.of(context).size.width * 0.03,
                bottom: MediaQuery.of(context).size.height * 0.02),
                child : submitbtns(context, "${AppLocale.of(context).getTranslated('call')}", false, false, ()=>{
                  launchUrl(callrehab(phone)),
                })
              ),
            ),


            Container(
              child: Padding(
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.03 ,
                      right: MediaQuery.of(context).size.width * 0.03 ),
                  child : submitbtns(context, "${AppLocale.of(context).getTranslated('location')}", false, false, ()=>{
                    launchUrl(rehablocation(location)),

                  })
              ),
            )


          ],
        ),
      )
  );
}

_getLanguageCode(BuildContext context) {
  return Localizations.localeOf(context).languageCode;
}

