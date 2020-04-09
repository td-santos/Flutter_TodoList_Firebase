import 'package:clean_tasks/Stores/home_store.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../TemaDark.dart';

class DialogConta extends StatefulWidget {
  final FirebaseUser user;
  final bool darkMode;

  const DialogConta({Key key, this.user, this.darkMode}) : super(key: key);

  @override
  _DialogContaState createState() => _DialogContaState();
}

class _DialogContaState extends State<DialogConta> {
  TemaDark temaDark = TemaDark();
  bool valueSwitch;
  bool darkMode;
  HomeStore homeStore = HomeStore();

  salvarShared(bool darkmode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("darkMode", darkmode);

    print("(SalvarPrefs): ");
    //initState();
  }
  initPrefs()  {
    //final prefs = await SharedPreferences.getInstance();
    homeStore.setDarkMode(widget.darkMode);
    print("INITPREFS DARK: ${homeStore.darkMode}");
    //darkMode = prefs.getBool("darkMode");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPrefs();
    //darkMode = homeStore.darkMode;
    print(homeStore.darkMode);
    
   // if (darkMode == true) {
   //   valueSwitch = true;
   // } else {
   //   valueSwitch = false;
   // }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: SingleChildScrollView(
        child: Observer(builder: (_){
          return AnimatedContainer(
          duration: Duration(milliseconds: 300),
          width: width,
          decoration: BoxDecoration(
              color:
                  homeStore.darkMode == true ? temaDark.dialogColor : Colors.white,
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 10, left: 10, bottom: 10),
                child: Container(
                  height: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      widget.user.photoUrl,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10, bottom: 0),
                child: Text(
                  widget.user.displayName,
                  style: TextStyle(
                      fontSize: 20,
                      color: homeStore.darkMode == true
                          ? Colors.grey[400]
                          : Colors.black),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: Text(
                  widget.user.email,
                  style: TextStyle(
                      fontSize: 15,
                      color: homeStore.darkMode == true
                          ? Colors.grey[600]
                          : Colors.grey[600]),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      "Modo Escuro",
                      style: TextStyle(
                          fontSize: 17,
                          color: homeStore.darkMode == true
                              ? Colors.grey[400]
                              : Colors.black),
                    ),
                    Padding(padding: EdgeInsets.only(left: 5),
                    child: Switch(
                      value: homeStore.darkMode, 
                      onChanged: (value){
                        darkMode = value;
                        homeStore.setDarkMode(value);
                        salvarShared(homeStore.darkMode);
                      }),)
                    
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Container(
                  width: width,
                  height: 60,
                  decoration: BoxDecoration(
                      color: Colors.red[400],
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                  child: Center(
                    child: Text(
                      "Fazer LogOff",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey[850],
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
        })
      ),
    );
  }
}
