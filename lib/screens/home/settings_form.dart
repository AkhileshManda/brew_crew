import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({Key key}) : super(key: key);

  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {


  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0','1','2','3','4'];

  //form values
  String _currentName;
  String _currentSugars;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){

          UserData userData = snapshot.data;
          return Form(
            key: _formKey,
            child: ListView(
              children: [
                Text(
                  'Update your brew settings',
                  style: TextStyle(fontSize: 18),
                ),

                SizedBox(height: 20,),

                TextFormField(
                  initialValue: userData.name,
                  decoration: textInputDecoration,
                  validator: (val){
                    if(val.isEmpty){
                      return 'Please enter a name';
                    }
                    else{
                      return null;
                    }
                  },
                  onChanged: (val){

                    setState(() {
                      _currentName=val;
                    });

                  },

                ),

                SizedBox(height: 20,),

                //dropdown
                DropdownButtonFormField(

                  decoration: textInputDecoration,
                  //getting an error on using value
                  value:  _currentSugars!=null ? _currentSugars : userData.sugars ,
                  onChanged: (val){
                    setState(() {
                      _currentSugars = val;
                    });
                  },
                  items: sugars.map((sugar){
                    return DropdownMenuItem(
                      value: sugar,
                      child : Text('$sugar sugars'),
                    );
                  }).toList(),
                ),

                //slider
                Slider(

                  min: 100,
                  max: 900,
                  divisions: 8,
                  onChanged: (val){
                    setState(() {
                      _currentStrength = val.round();
                    });
                  },
                  value: (_currentStrength ?? userData.strength).toDouble(),
                  activeColor: Colors.brown[_currentStrength ?? userData.strength],
                  inactiveColor: Colors.brown[_currentStrength ?? userData.strength],

                ),

                RaisedButton(

                  color: Colors.pink[400],
                  child: Text(
                    'Update',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: ()async{
                    if(_formKey.currentState.validate()){
                      await DatabaseService(uid: user.uid).updateUserData(
                          _currentSugars ?? userData.sugars,
                          _currentName ?? userData.name,
                          _currentStrength ?? userData.strength
                      );
                      Navigator.pop(context);
                    }
                  },


                ),

              ],
            ),

          );

        }else{
           return Loading();
          }

      }
    );
  }
}
