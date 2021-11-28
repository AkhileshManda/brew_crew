import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  //Instance of Auth service class
  final AuthService _auth = AuthService();

  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email='';
  String password='';
  String error='';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() :Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign into Brew Crew'),
          actions: [
            FlatButton.icon(
                onPressed: (){
                  widget.toggleView();
                },
                icon: Icon(Icons.person),
                label: Text('Register'))
          ]
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 50 ,vertical: 20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 20,),
              TextFormField(

                validator: (val){
                  if(val.isEmpty){
                    return 'Enter an email';
                  }
                  return null;
                },

                keyboardType: TextInputType.emailAddress,
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                onChanged: (val){

                    setState(() {
                      email=val;

                    });

                },
              ),
              SizedBox(height: 20,),
              TextFormField(

                validator: (val){
                  if(val.length<6){
                    return 'Enter password of minimum 6 char';
                  }
                  return null;
                },

                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                obscureText: true,
                onChanged: (val){
                  setState(() {
                    password=val;
                  });
                },
              ),
              SizedBox(height: 20,),
              RaisedButton(
                color: Colors.pink[400],
                  child: Text('Sign In',
                  style: TextStyle(color: Colors.white),),
                  onPressed: () async{

                  if(_formKey.currentState.validate()){
                    setState(() {
                      loading=true;
                    });
                    dynamic result = await _auth.signInWithEmailAndPassword(
                        email, password);
                    if(result==null){
                     setState(() {
                       error = 'Could not sign in with those credentials';
                       loading=false;
                     });
                    }

                  }
                }),
              SizedBox(height: 12,),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),

              ),
            ],
          ),
        ),
      ),
    );
  }
}
