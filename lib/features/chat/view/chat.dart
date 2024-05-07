import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:raspisanie/repositories/chat/models/chat.dart';
import 'package:raspisanie/repositories/chat/chat_repo.dart';

class Chat extends StatefulWidget{
  @override
  _Chat createState() => _Chat();
}

class _Chat extends State<Chat>{
  List<chat>? chats;

  Future<List<chat>?> GetPair() async{
    return await ChatRepo().GetChats();
}
  @override
  void initState() {
    super.initState();
    GetPair().then((value) {
      setState(() {
        chats = value;
      });
    });
  }
  @override
  Widget build(BuildContext build){
    return Scaffold(
      appBar: AppBar(
        title: const Text("Чаты"),
      ),
      body: (chats == null)
        ? const SizedBox()
        :
      ListView.builder(
          itemBuilder: (context, index){
            return Container(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Card(
                shape:  RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: Colors.deepPurple,
                child: ListTile(
                  leading: Text(chats![index].id!, style: TextStyle(color: Colors.black, fontSize: 15),),
                  title: Text(chats![index].name!, style: TextStyle(fontSize: 25)),
                  trailing: Text("Кол-во пользователей: " + chats![index].count!, style: TextStyle(color: Colors.black, fontSize: 20),),
                  onTap: () => Navigator.pushNamed(context, '/chat'),
                ) ,
              ),
            );
          },
          itemCount: chats!.length,
      ),
    );
  }
}