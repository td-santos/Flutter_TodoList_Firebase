import 'package:clean_tasks/Screens/Login.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

salvarDarkModeInitial(bool darkMode) async {    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("darkMode", darkMode);
    
    print("(SalvarPrefs MAIN DARK MODE):$darkMode ");    
  }

  salvarOrderASCInitial(bool orderAsc) async {    
    final prefs = await SharedPreferences.getInstance();
    
    await prefs.setBool("orderAsc", orderAsc);
    print("(SalvarPrefs MAIN ORDER ASC): $orderAsc");    
  }

  
  

main(List<String> args) async {
    WidgetsFlutterBinding.ensureInitialized();
    final prefs = await SharedPreferences.getInstance();

    bool darkMode;
    bool orderAsc;

    darkMode = prefs.getBool("darkMode");
    orderAsc = prefs.getBool("orderAsc");
    if(darkMode == null){
      darkMode = false;
      salvarDarkModeInitial(darkMode);
    }
    if(orderAsc == null){
      orderAsc = true;
      salvarOrderASCInitial(orderAsc);
    }


    print("DARKMODE MAIN: $darkMode");
    print("ORDER ASC MAIN: $orderAsc");

      initializeDateFormatting().then((_) {
        runApp(MaterialApp(
          home: LoginPage(),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: darkMode ==true ?Colors.grey[850]: Colors.white
          ),
        ));
      });
}
