import 'dart:convert';

class User {
  User({
    this.id,
    required this.address,
    required this.email,
    required this.name,
    required this.phone,
    required this.photo,
  });
  String? id;
  String address;
  String email;
  String phone;
  String name;
  String photo;

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        address: json["address"],
        email: json["email"],
        phone: json["phone"],
        name: json["name"],
        photo: json["photo"],
      );

  Map<String, dynamic> toMap() => {
        "address": address,
        "email": email,
        "phone": phone,
        "name": name,
        "photo": photo,
      };

  User copy() => User(address: address, email: email, name: name, phone: phone, photo: photo, id: id);
}
