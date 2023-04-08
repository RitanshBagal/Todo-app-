import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todoode/pages/HomePage.dart';
import 'package:todoode/service/Auth_Service.dart';
import 'pages/SignUpPage.dart';
import 'pages/SignInPage.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'pages/AddTodoPage.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}
class MyApp extends StatefulWidget {

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget currentPage = SignUpPage();
  AuthClass authClass = AuthClass();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  void checkLogin()async{
    String? token = await authClass.getToken();
    if(token!=null){
      setState(() {
        currentPage = HomePage();
      });
    }
  }
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner:false,
      home: SignUpPage(),
    );
  }
}
