import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleLogin{



  Future<FirebaseUser> getUser({FirebaseUser currentUser,GoogleSignIn googleSignIn})async{
    
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
}