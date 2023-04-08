import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todoode/pages/HomePage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
class AuthClass {
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  FirebaseAuth auth = FirebaseAuth.instance;
  final Storage = new FlutterSecureStorage();

  Future<void> googleSignIn(BuildContext context) async {
    try{
      GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      if(googleSignInAccount != null){
        GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
        AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );
        try{
          UserCredential userCredential = await auth.signInWithCredential(credential);
          storeTokenAndData(userCredential);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (builder) => HomePage()),
                  (route) => false);
        }catch(e){
          final snackbar = SnackBar(content: Text(e.toString()));
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
        }
      }
      else{
        final snackbar = SnackBar(content: Text("Not Able to Sign In"));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      }
    }catch(e){
      final snackbar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }
  Future<void> storeTokenAndData(UserCredential userCredential)async{
    await Storage.write(key: "token", value: userCredential.credential?.token.toString());
    await Storage.write(key: "userCredential", value: userCredential.toString());
  }
  Future<String?> getToken()async{
    return await Storage.read(key: "token");
  }
  Future<void> logout()async{
    try{
      await _googleSignIn.signOut();
      await auth.signOut();
      await Storage.delete(key: "token");
    }catch(e){

    }
  }

}