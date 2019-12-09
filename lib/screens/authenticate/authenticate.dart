import 'package:brew_app/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';

import 'register.dart';

class  Authenticate extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return   _AuthenticateState();
  }

}


class _AuthenticateState extends State<Authenticate>
{
  bool showSignIn=true;
  void toggleView()
  {
    setState(() {

      showSignIn=!showSignIn;
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

      if(showSignIn)
        {
          return SignIn(toggleView: toggleView);
        }
      else
        {
          return Register(toggleView: toggleView);
        }
  }

}


