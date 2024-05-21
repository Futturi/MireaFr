class User{
   String? Email;
   String? Name;
   String? Password;
   String? Groupa;
  User.fromJson(Map<String, dynamic> json){
    Email = json['email'];
    Name = json['name'];
    Password = json['password'];
    Groupa = json['group'];
  }
}