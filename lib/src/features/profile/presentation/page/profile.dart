import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:raspisanie/src/features/profile/data/api/profile_repo.dart';
import 'package:raspisanie/src/features/profile/data/models/profile.dart';

class Profile extends StatefulWidget {
  @override
  _Profile createState() => _Profile();
}

class _Profile extends State<Profile> {
  final emailCont = TextEditingController();
  final nameCont = TextEditingController();
  final pasCont = TextEditingController();
  final groupCont = TextEditingController();
  Future<User?> getUs() async{
    return await ProfileRepo().getUser();
  }
  @override
  void initState(){
      getUs().then((value){
        print(value);
        emailCont.text = value?.Email ?? "";
        nameCont.text = value?.Name ?? "";
        groupCont.text = value?.Groupa ?? "";
      });
  }
  @override
  Widget build(BuildContext build) {
    int a = 1;
    return Scaffold(
        appBar: AppBar(
          title: Text("Профиль"),
        ),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 100),
            child: Container(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    color: Colors.black12,
                    child: Column(
                      children: [
                        Expanded(
                            child: Row(
                          children: [
                            Expanded(
                                child: Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: CachedNetworkImage(
                                  imageUrl:
                                      'https://imgtr.ee/images/2024/05/16/439e0cc848d620903cad8c6e4367c0ef.png'),
                            )),
                            Expanded(
                                child: Column(children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 100, 20, 20),
                                child: Container(
                                    child: Row(
                                  children: [
                                    SizedBox(
                                      width: 21,
                                    ),
                                    Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      color: Colors.blueAccent[100],
                                      child: Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(45, 15, 45, 15),
                                        child: Text(
                                          'Почта',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 50,
                                    ),
                                    Expanded(
                                      child: TextField(
                                        controller: emailCont,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                        decoration: InputDecoration(
                                          hintText: 'Почта',
                                          hintStyle: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 30.0),
                                          enabledBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1.0,
                                                color: Colors.white24),
                                          ),
                                          focusedBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1.5,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 20),
                                child: Container(
                                    child: Row(
                                  children: [
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      color: Colors.blueAccent[100],
                                      child: Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(50, 15, 50, 15),
                                        child: Text(
                                          'ФИО',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 50,
                                    ),
                                    Expanded(
                                      child: TextField(
                                        controller: nameCont,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                        decoration: InputDecoration(
                                          hintText: 'ФИО',
                                          hintStyle: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 30.0),
                                          enabledBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1.0,
                                                color: Colors.white24),
                                          ),
                                          focusedBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1.5,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 20),
                                child: Container(
                                    child: Row(
                                  children: [
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      color: Colors.blueAccent[100],
                                      child: Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(40, 15, 40, 15),
                                        child: Text(
                                          'Пароль',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 50,
                                    ),
                                    Expanded(
                                      child: TextField(
                                        controller: pasCont,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                        decoration: InputDecoration(
                                          hintText: 'Пароль',
                                          hintStyle: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 30.0),
                                          enabledBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1.0,
                                                color: Colors.white24),
                                          ),
                                          focusedBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1.5,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 20),
                                child: Container(
                                    child: Row(
                                  children: [
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      color: Colors.blueAccent[100],
                                      child: Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(40, 15, 40, 15),
                                        child: Text(
                                          'Группа',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 50,
                                    ),
                                    Expanded(
                                      child: TextField(
                                        controller: groupCont,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                        decoration: InputDecoration(
                                          hintText: 'Группа',
                                          hintStyle: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 30.0),
                                          enabledBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1.0,
                                                color: Colors.white24),
                                          ),
                                          focusedBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1.5,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )),
                              ),
                            ]))
                          ],
                        )),
                        Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 250),
                              child: Container(
                                width: 100,
                                child: FloatingActionButton(
                                  onPressed: () async{
                                    ProfileRepo().updateUser(emailCont.text, nameCont.text, pasCont.text, groupCont.text);
                                  },
                                  backgroundColor: Colors.blueAccent[100],
                                  child: Text('Сохранить', style: TextStyle(color:  Colors.black)),
                                ),
                              )
                            )
                      ],
                    )))));
  }
}
