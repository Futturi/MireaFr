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