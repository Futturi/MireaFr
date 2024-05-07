import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:raspisanie/repositories/registscreen/models/regist.dart';
import 'package:raspisanie/repositories/registscreen/regist_repo.dart';

class Regist extends StatefulWidget{
  @override
  _Regist createState() => _Regist();
}

class _Regist extends State<Regist>{
  final name = TextEditingController();
  final mail = TextEditingController();
  final password = TextEditingController();
  final group = TextEditingController();
  regist? id;
  String? err;
  @override
  Widget build(BuildContext build){
    final mquery = MediaQuery.of(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Регистрация",),
          leading: FloatingActionButton(
            onPressed: () => Navigator.pop(context),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            child: const Icon(Icons.arrow_back, color: Colors.white70,),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: mquery.size.height / 10,),
              Padding(padding: EdgeInsets.symmetric(horizontal: mquery.size.width / 5), child: Container(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Card(
                  shape:  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: Colors.white70,
                  child: Column(
                    children: [
                      const Image(image: AssetImage('assets/logo.png'), width: 350),
                      Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child:TextField(
                        controller: name,
                        style: Theme.of(context).textTheme.bodySmall,
                        decoration: InputDecoration(
                          hintText: 'ФИО',
                          hintStyle: Theme.of(context).textTheme.bodySmall,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 30.0),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(width: 1.0, color: Colors.black38),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(width: 1.5, color: Colors.black),
                          ),
                        ),
                      ),),
                      const SizedBox(height: 30),
                      Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: TextField(
                        controller: mail,
                        style: Theme.of(context).textTheme.bodySmall,
                        decoration: InputDecoration(
                          hintText: 'Почта',
                          hintStyle: Theme.of(context).textTheme.bodySmall,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 30.0),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(width: 1.0, color: Colors.black38),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(width: 1.5, color: Colors.black),
                          ),
                        ),
                      ),),
                      const SizedBox(height: 30),
                      Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: TextField(
                        controller: password,
                        style: Theme.of(context).textTheme.bodySmall,
                        decoration: InputDecoration(
                          hintText: 'Пароль',
                          hintStyle: Theme.of(context).textTheme.bodySmall,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 30.0),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(width: 1.0, color: Colors.black38),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(width: 1.5, color: Colors.black),
                          ),
                        ),
                      ),),
                      const SizedBox(height: 30),
                      Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child:TextField(
                        controller: group,
                        style: Theme.of(context).textTheme.bodySmall,
                        decoration: InputDecoration(
                          hintText: 'Группа',
                          hintStyle: Theme.of(context).textTheme.bodySmall,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 30.0),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(width: 1.0, color: Colors.black38),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(width: 1.5, color: Colors.black),
                          ),
                        ),
                      ) ,),
                      const SizedBox(height: 15,),
                      Text(err ?? '', style: TextStyle(color: Colors.redAccent),),
                      SizedBox(height: 15,),
                      FloatingActionButton(onPressed: ()async{
                        try{
                          id = await RegistRepo().signUp(mail.text, password.text, name.text, group.text);
                          context.go('/');
                        }catch(e){
                          err = 'Такой пользователь уже существует';
                        }
                      },
                          backgroundColor: Theme.of(context).scaffoldBackgroundColor, child: const Icon(Icons.arrow_forward, color: Colors.white70,)),
                      const SizedBox(height: 20,)
                    ],

                  ),
                ),
              ),
              ),
              SizedBox(height: mquery.size.height / 10,),
            ],
          ),)

    );
  }
}