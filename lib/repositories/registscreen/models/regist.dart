class regist {
  int? id;
  regist({this.id});

  regist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

}