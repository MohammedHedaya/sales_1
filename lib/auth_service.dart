import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sales_1/home_page.dart';
import 'package:sales_1/login_screen.dart';

class AuthService{
  signInWithGoogle() async{
    final GoogleSignInAccount? googleUser=await GoogleSignIn(
        scopes: <String>['email']).signIn();

    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
//sign out
  signOut(){
    FirebaseAuth.instance.signOut();
  }

//handle
  handleAuthState(){
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot){
          if(snapshot.hasData){
            return const HomePage();
          }else{
            return const LoginScreen();
          }
        });
  }

}

