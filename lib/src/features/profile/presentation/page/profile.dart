import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget{
  @override
  _Profile createState() => _Profile();
}

class _Profile extends State<Profile>{
  @override
  Widget build(BuildContext build){
    return Scaffold(
      appBar: AppBar(
        title: Text("Профиль"),
      ),
      body: Text("123")
    );
  }
}