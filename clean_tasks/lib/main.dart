import 'package:clean_tasks/Screens/Login.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';


main(List<String> args) {

  initializeDateFormatting().then((_){
    runApp(MaterialApp(
    home: LoginPage(),
    debugShowCheckedModeBanner: false,
    
  ));
  });
 
}