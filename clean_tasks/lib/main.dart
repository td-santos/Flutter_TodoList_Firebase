import 'package:clean_tasks/Screens/Login.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

salvarSharedInitial({bool darkmode,bool orderAsc}) async {    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("darkMode", darkmode);
    await prefs.setBool("orderAsc", orderAsc);
    print("(SalvarPrefs MAIN): ");    
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
  salvarSharedInitial(darkmode:darkMode);
}
if(orderAsc == null){
  orderAsc = true;
  salvarSharedInitial(orderAsc: orderAsc);
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
