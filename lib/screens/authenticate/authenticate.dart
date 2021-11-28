//sign in or register widget
import 'package:brew_crew/screens/authenticate/register.dart';
import 'package:brew_crew/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;

  //function to toggle between register and sign in
  void toggleView(){

    setState(() {
      showSignIn=!showSignIn;
    });

  }
  @override
  Widget build(BuildContext context) {
    //return sign in or register
    if(showSignIn){
      return SignIn(toggleView : toggleView);
    }
    else{
      return Register(toggleView: toggleView);
    }

  }
}
