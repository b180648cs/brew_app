
import 'package:brew_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:brew_app/screens/home/home.dart';
import 'package:provider/provider.dart';
import 'authenticate/authenticate.dart';


class Wrapper extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    // either home or authenticate

    final user=Provider.of<User>(context);
    print(user);
    if(user==null)
    return Authenticate();

    else
      return Home();
  }

}