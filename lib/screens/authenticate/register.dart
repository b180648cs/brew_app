import 'package:brew_app/services/auth.dart';
import 'package:brew_app/shared/constants.dart';
import 'package:brew_app/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget
{final Function toggleView;
Register({ this.toggleView});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RegisterState();
  }


}

class _RegisterState extends State<Register>
{ final AuthService _auth= AuthService();
  final _formkey=GlobalKey<FormState>();
String email='';
String password='';
String error='';
bool loading=false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return loading? Loading():Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text("Register"),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text("Sign in"),
            onPressed: () async
            {
              widget.toggleView();
            },
          )
        ],
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
          child: Form(
            key:_formkey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: "Email"),
                  validator: (val)=>val.isEmpty ? "Enter a valid email": null,
                    onChanged: (val)
                    {
                      setState(() {
                        email=val;
                      });

                    }
                ),
                SizedBox(height: 20.0),
                TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: "Password"),
                    obscureText: true,
                    validator: (val)=>val.length<6 ? "Enter a password  6 char long": null,
                    onChanged: (val)
                    {
                      setState(() {
                        password=val;
                      });
                    }
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                  child: Text("Register",
                    style: TextStyle(color: Colors.white),),
                  onPressed: () async
                  { if(_formkey.currentState.validate()) {
                   dynamic result= await _auth.registerWithEmailAndPassword(email, password);
                   setState(() {
                     loading=true;
                   });
                   if(result==null)
                     {
                       setState(() {
                         error="Enter a valid email";
                         loading=false;
                       });
                     }
                  }

                  },
                ),
                SizedBox(height: 12.0),
                Text(error,
                style: TextStyle(color: Colors.red,fontSize: 14.0),)
              ],
            ),
          )
      ),

    );
  }
  }

