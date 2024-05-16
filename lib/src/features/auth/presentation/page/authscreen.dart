import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:raspisanie/src/features/auth/data/api/authscreen_repo.dart';
import 'package:raspisanie/src/features/auth/data/models/authscreen.dart';

class AuthScreen extends StatefulWidget{
  @override
  _AuthScreen createState() => _AuthScreen();
}

class _AuthScreen extends State<AuthScreen>{
  final logincontoller = TextEditingController();
  final passwordcontroller = TextEditingController();
  List<Users>? token;
  String a = "123";
  bool ob = true;
  void _togglePasswordVisibility() {
    setState(() {
      ob = !ob;
    });
  }
  @override
  Widget build(BuildContext context){
    final mquery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Авторизация",),
        leading: CachedNetworkImage(
          imageUrl: 'https://imgtr.ee/images/2024/05/16/456eae728534559e1429570936fc374e.png',
        )
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: mquery.size.height / 10),
        Padding(padding: EdgeInsets.symmetric(horizontal: mquery.size.width / 5), child: Container(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Card(
            shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),), color: Colors.white70,
            child: Column(
              children: [
                CachedNetworkImage(imageUrl: 'https://imgtr.ee/images/2024/05/16/439e0cc848d620903cad8c6e4367c0ef.png'),
                Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child:Container(
                  child: TextField(
                    controller: logincontoller,
                    style: Theme.of(context).textTheme.bodySmall,
                    decoration: InputDecoration(
                      hintText: 'Логин',
                      hintStyle: Theme.of(context).textTheme.bodySmall,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 30.0),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(width: 1.0, color: Colors.black38),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(width: 1.5, color: Colors.black),
                      ),
                    ),
                  ),
                ),),
                const SizedBox(height: 30,),
                Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: Container(
                  child: TextField(
                    controller: passwordcontroller,
                    style: Theme.of(context).textTheme.bodySmall,
                    obscureText: ob,
                    decoration: InputDecoration(
                      hintText: 'Пароль',
                      suffixIcon: IconButton(
                        icon: Icon(ob ? Icons.visibility_off : Icons.visibility),
                        onPressed: _togglePasswordVisibility,
                      ),
                      hintStyle: Theme.of(context).textTheme.bodySmall,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 30.0),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(width: 1.0, color: Colors.black38),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(width: 1.5, color: Colors.black),
                      ),
                    ),
                  ),
                ),
                ),
                const SizedBox(height: 50,),
                FloatingActionButton(
                  onPressed: ()async{
                    try{
                      await AuthScreenRepository().Signin(logincontoller.text, passwordcontroller.text);
                      context.go('/main');
                    } catch(e){
                      context.go('/signup');
                    }
                  },
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    child: const Icon(Icons.arrow_forward, color: Colors.white70,)
                ),
                const SizedBox(height: 20,)
              ],
            )
    )
        )
        ),
            SizedBox(height: mquery.size.height / 5),
          ],
        ),
      ),
    );
  }
}
