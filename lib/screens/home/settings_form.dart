import 'package:brew_app/models/user.dart';
import 'package:brew_app/services/database.dart';
import 'package:brew_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:brew_app/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SettingFormState();
  }
}

class _SettingFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4', '5'];

// current things
  String _currentName;
  String _currentSugars;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot){
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    " Update your brew data",
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: userData.name,
                    decoration: textInputDecoration,
                    validator: (val) =>
                        val.isEmpty ? "Enter a valid mail" : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  SizedBox(height: 20.0),
                  // drop down menu

                  DropdownButtonFormField(
                      value: _currentSugars ?? userData.sugars,

                      decoration: textInputDecoration,
                      items: sugars.map(
                        (sugar) {
                          return DropdownMenuItem(
                            value: sugar,
                            child: Text("$sugar sugars"),
                          );
                        },
                      ).toList(),
                      onChanged: (val) => setState(() => _currentSugars = val)),
                  Slider(
                    value: (_currentStrength ?? userData.strength).toDouble(),
                    activeColor: Colors.brown[_currentStrength ?? userData.strength],
                    inactiveColor: Colors.brown[_currentStrength ?? userData.strength],
                    min: 100,
                    max: 900,
                    divisions: 8,
                    onChanged: (val) {
                      setState(() {
                        _currentStrength = val.round();
                      });
                    },
                  ),
                  // slider

                  RaisedButton(
                    color: Colors.pink[400],
                    child: Text(
                      "Update",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                     if(_formKey.currentState.validate())
                       {
                         await DatabaseService(uid: user.uid).updateUserData(
                           _currentSugars?? userData.sugars,
                           _currentName ?? userData.name,
                           _currentStrength ?? userData.strength
                         );
                         Navigator.pop(context);
                       }
                    },
                  )
                ],
              ),
            );
          } else {
             return Loading();
          }
        });
  }
}
