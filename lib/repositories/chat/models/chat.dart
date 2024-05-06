class chat {
  String? name;
  String? id;

  chat({this.name, this.id});

  chat.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
  }
}