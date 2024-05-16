class chat {
  String? name;
  String? id;
  String? count;

  chat({this.name, this.id, this.count});

  chat.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    count = json['count'];
  }
}

class message {
  String? clientid;
  String? content;
  String? roomid;
  String? username;
  int? data;
  DateTime? dat;
  message({this.clientid  ,this.content, this.roomid, this.username, this.data, this.dat});
  message.fromJson(Map<String, dynamic> json) {
    clientid = json['clientid'];
    content = json['content'];
    roomid = json['roomId'];
    username = json['username'];
    data = json['time'];
    print(data);
    if (data != null) {
      dat = DateTime.fromMillisecondsSinceEpoch(data ! * 1000);
    }
  }
}