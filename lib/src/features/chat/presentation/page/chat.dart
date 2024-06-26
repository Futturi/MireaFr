import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:raspisanie/src/features/chat/data/models/chat.dart';
import 'package:raspisanie/src/features/chat/data/api/chat_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/io.dart';
import 'package:intl/intl.dart';
import 'package:get_it/get_it.dart';

class Chat extends StatefulWidget{
  @override
  _Chat createState() => _Chat();
}

class _Chat extends State<Chat>{
  List<chat>? chats;
  String? token;
  chat cha = chat(name: "");
  TextEditingController contr = TextEditingController();
  Future<List<chat>?> GetPair() async{
    return await ChatRepo().GetChats();
}
String? id;
  @override
  void initState() {
    SetupLoc();
    super.initState();
    GetPair().then((value) {
      setState(() {
        chats = value;
      });
    });
    getId();
    getToken();
  }
  void getId() async{
  final prefs = await SharedPreferences.getInstance();
  id = prefs.getString('id');
  print(id);
}
  void getToken() async{
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString('jwt_token');
  }

  void _showDialog(BuildContext context, List<chat> chats) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Введите название чата"),
          content: TextField(
            decoration: const InputDecoration(hintText: "Название"),
            controller: contr,
          ),
          actions: <Widget>[
            FloatingActionButton(
              child: CachedNetworkImage(
                imageUrl: 'https://imgtr.ee/images/2024/05/16/c339cc86f92fcee1fdcee2984634e290.png',
              ),
              onPressed: () async {
                cha = await ChatRepo().CreateChat(contr.text); // TODO: на беке поменять ручку
                setState(() {
                  chats.add(cha);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
                  leading: CachedNetworkImage(
                    imageUrl: 'https://imgtr.ee/images/2024/05/16/336bea3643aa17f2835241f8051f9902.png',
                  ),
                  title: Text(chats?[index].name ?? '', style: TextStyle(fontSize: 25)),
                  trailing: Text("Кол-во пользователей: " + (chats?[index].count ?? ''), style: TextStyle(color: Colors.black, fontSize: 20),),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> ChatOne(name: chats?[index].name ?? "", token: token ?? "", id: id ?? ""))),
                ) ,
              ),
            );
          },
          itemCount: chats?.length ?? 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() {
          _showDialog(context, chats ?? List.empty());
        }),
        backgroundColor: Colors.deepPurple,
        child: CachedNetworkImage(
          imageUrl: 'https://imgtr.ee/images/2024/05/16/c339cc86f92fcee1fdcee2984634e290.png',
        ),
      ),
    );
  }
}
class ChatOneInheritedWidget extends InheritedWidget {
  final String name;

  const ChatOneInheritedWidget({
    Key? key,
    required this.name,
    required Widget child,
  }) : super(key: key, child: child);

  static ChatOneInheritedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ChatOneInheritedWidget>();
  }

  @override
  bool updateShouldNotify(ChatOneInheritedWidget oldWidget) {
    return name != oldWidget.name;
  }
}
final GetIt getIt = GetIt.instance;

class ChatModel{
  void getid() async{
    final prefs = await SharedPreferences.getInstance();
    id = prefs.getString('id');
  }
  void gettoken() async{
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString('jwt_token');
  }
  String? token;
  String? id;
}

void SetupLoc() {
  getIt.registerSingleton<ChatModel>(ChatModel());
}

class ChatOne extends StatefulWidget{
  String name;
  String token;
  String id;
  ChatOne({required this.name, required this.token, required this.id});
  @override
  _ChatOne createState() => _ChatOne(name: name, token: token, id: id);
}

class _ChatOne extends State<ChatOne>{
  String name;
  String token;
  String id;
  _ChatOne({required this.name, required this.token, required this.id});
  List<message> list = [];
  IOWebSocketChannel? channel;

  final cont = TextEditingController();
  Stream<dynamic> connect(String? token){
    final conn = IOWebSocketChannel.connect('ws://localhost:8080/api/joinroom/$name', headers: {
      "Authorization": "Bearer $token",
    }).stream.map((event) => event);
    return conn;
  }
  @override
  Widget build(BuildContext build){
    final appmodel = getIt<ChatModel>();
    appmodel.token = token;
    appmodel.id = id;
    final chan = IOWebSocketChannel.connect('ws://localhost:8080/api/joinroom/$name', headers: {
    "Authorization": "Bearer $token",
    });
    void send(String data) {
      chan.sink.add(data);
    }
    void disconnect() {
      chan.sink.close();
    }
    return ChatOneInheritedWidget(name: name, child: Scaffold(
      appBar: AppBar(
        leading: FloatingActionButton(
          backgroundColor: Colors.transparent,
          onPressed: (){
            Navigator.pop(context);
            disconnect();
          },
          child: Icon(Icons.arrow_back, color: Colors.white,),
        ),
        title: Text(ChatOneInheritedWidget.of(context)?.name ?? "first", style: TextStyle(color: Colors.white70),),
      ),
      body: StreamBuilder(
        stream: chan.stream.map((event) => event),
        builder: (context, snapshot){
          if (snapshot.data != null && snapshot.data is String) {
            try {
              List<dynamic> jsonList = jsonDecode(snapshot.data);
              List<message> messages = jsonList.map((item) => message.fromJson(item)).toList();
              list.addAll(messages);
            } catch (e) {
              try {
                Map<String, dynamic> jsonMap = Map<String, dynamic>.from(jsonDecode(snapshot.data));
                message msg = message.fromJson(jsonMap);
                list.add(msg);
              } catch (e) {
                print("Unable to decode data: $e");
              }
            }
          } else {
            return SizedBox();
          }
          return Column(
            children: [
              Expanded(
                  child: ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (build, ind){
                        if (list[ind].clientid == id){
                          return Container(
                            padding: EdgeInsets.fromLTRB(300, 15, 0, 0),
                            child: Card(
                              color: Colors.blueAccent,
                              child: ListTile(
                                subtitle: Text(list[ind].username ?? "", style: TextStyle(color: Colors.black),),
                                title: Text(list[ind].content ?? ""),
                                trailing: Text(DateFormat("HH:mm").format(list[ind].dat ?? DateTime(1970)), style: TextStyle(color: Colors.black),),
                                leading: Text(DateFormat("dd.MM.yy").format(list[ind].dat ?? DateTime(1970)) + 'г', style: TextStyle(color: Colors.black),),
                              ) ,
                              shape:  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          );

                        }else{
                          return Container(
                            padding: EdgeInsets.fromLTRB(0, 15, 300, 0),
                            child: Card(
                              color: Colors.deepPurple,
                              child: ListTile(
                                subtitle: Text(list[ind].username ?? "", style: TextStyle(color: Colors.black),),
                                title: Text(list[ind].content ?? ""),
                                trailing: Text(DateFormat("HH:mm").format(list[ind].dat ?? DateTime(1970)), style: TextStyle(color: Colors.black),),
                                leading: Text(DateFormat("dd.MM.yy").format(list[ind].dat ?? DateTime(1970)) + 'г', style: TextStyle(color: Colors.black),),
                              ) ,
                              shape:  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          );
                        }
                      }
                  )
              ),
              Container(
                color: Colors.black26,
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                          decoration: const InputDecoration(
                              hintText: "Введите сообщение",
                              hintStyle: TextStyle(color: Colors.white70)
                          ),
                          controller: cont,
                          style: TextStyle(
                              color: Colors.white
                          ),
                        )
                    ),
                    IconButton(onPressed: (){
                      send(cont.text);
                      cont.text = "";
                    }, icon: const Icon(Icons.arrow_right), color: Colors.white,)
                  ],
                ),
              )
            ],
          );
        },
      ),
    )
    );
  }
}