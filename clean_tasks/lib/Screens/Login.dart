import 'package:clean_tasks/Screens/HomePage.dart';
import 'package:clean_tasks/TemaDark.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final GoogleSignIn googleSignIn = GoogleSignIn();
  FirebaseUser currentUser;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool visibleFloatButtom =false;
  bool darkMode;
  bool orderAsc;
  TemaDark temaDark = TemaDark();

  initPrefs()async{
    final prefs = await SharedPreferences.getInstance();
    darkMode = prefs.getBool("darkMode");
    orderAsc = prefs.getBool("orderAsc");
  }

  Future<FirebaseUser> _getUser()async{
    
    if(currentUser != null)return currentUser;

    try{
      final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken
      );

      final AuthResult authResult = await FirebaseAuth.instance.signInWithCredential(credential);
      final FirebaseUser user = authResult.user;

      return user;

      

    }catch(error){
      return null;
    }
  }
  void _logIn()async{
    final FirebaseUser user = await _getUser();
    //print("dados Google: ${user.displayName}");
    if(user ==null){
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Login não efetuado, favor tente novamente!"),
          backgroundColor: Colors.red,
        )
      );
    }else{
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context)=> HomePage(
          user: user,
          dark: darkMode,
          orderAsc: orderAsc,
        )
      ));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPrefs();
    
    FirebaseAuth.instance.onAuthStateChanged.listen((user){
      currentUser = user;
      
      if(currentUser != null){
        setState(() {
        visibleFloatButtom = false;
      });
        Future.delayed(Duration(milliseconds: 1500),(){
          Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context)=> HomePage(
          user: user,
          dark: darkMode,
          orderAsc: orderAsc,
        )
      ));
        });
         
      }else{
        _getUser();
        setState(() {
        visibleFloatButtom = true;
      });
      }
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkMode ==true ?temaDark.scafoldcolor : null,
      key: _scaffoldKey,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        
          child: Image.asset("assets/phone_people.png",fit: BoxFit.contain,),
        
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:  Visibility(
        visible: visibleFloatButtom,
        child: Padding(
        padding: EdgeInsets.only(bottom: 15),
        child: FloatingActionButton(
        backgroundColor: Colors.red,
        child: Text("G", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25),),
        onPressed: (){
          _logIn();
          
        }),)),
    );
  }
}