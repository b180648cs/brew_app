import 'package:brew_app/models/brew.dart';
import 'package:brew_app/screens/home/settings_form.dart';
import 'package:brew_app/services/auth.dart';
import 'package:brew_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'brew_list.dart';


class Home extends StatelessWidget
{

  final AuthService _auth=AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel()
    {
      showModalBottomSheet(context: context, builder:(context)
      {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 60.0),
          child:SettingsForm(),
        );
      });
    }
    return  StreamProvider<List<Brew>>.value(
      value:DatabaseService().brews,
      child:Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: Text("Brew crew"),
        backgroundColor: Colors.brown[500],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text("logout"),
            onPressed: () async
              {
                await _auth.signOut();
              },

          ),
          FlatButton.icon(onPressed: (){
            _showSettingsPanel();
          }, icon: Icon(Icons.settings), label:Text("Settings"))
        ],
      ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: 
            AssetImage('assets/coffee_bg.png'),
            fit: BoxFit.cover),
          ),
            child: BrewList()),
    ),);
  }

}