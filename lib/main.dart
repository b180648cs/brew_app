import 'package:brew_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:brew_app/screens/wrapper.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';

void main()
{
  runApp(MyApp());
}


class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(

      home: Wrapper(),
    ),
    );
  }


}