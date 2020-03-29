import 'package:clean_tasks/Screens/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final GoogleSignIn googleSignIn = GoogleSignIn();
  FirebaseUser currentUser;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
      Navigator.push(context, MaterialPageRoute(
        builder: (context)=> HomePage(
          user: user,
        )
      ));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth.instance.onAuthStateChanged.listen((user){
      currentUser = user;
      if(currentUser != null){
         Navigator.push(context, MaterialPageRoute(
        builder: (context)=> HomePage(
          user: user,
        )
      ));
      }
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50)
                )
              ),
              child: FlatButton(
                onPressed: (){
                  _logIn();
                },
                child: Text("Login Google",style: TextStyle(
                  color: Colors.white,
                  fontSize: 25
                ),),
              ),
            ),
          ),
        ),
      ),
    );
  }
}