import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/models/brew.dart';

class BrewTile extends StatelessWidget {
  final Brew brew;

  BrewTile({this.brew});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20,6
            , 20, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.brown[brew.strength],
            backgroundImage: AssetImage('assets/brew_crew_icon.png'),
          ),
          title: Text(brew.name),
          subtitle: Text('Takes ${brew.sugars} sugar(s)'),
        ),
      ),
    );
  }
}
