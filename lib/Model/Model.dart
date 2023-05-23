import 'dart:convert';

Res resFromJson(String str) => Res.fromJson(json.decode(str));
String resToJson(Res data) => json.encode(data.toJson());

class Res {
  List<Person> data;

  Res({
    required this.data,
  });

  factory Res.fromJson(Map<String, dynamic> json) => Res(
        data: List<Person>.from(json["data"].map((x) => Person.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

////Person
Person personFromJson(String str) => Person.fromJson(json.decode(str));
String personToJson(Person data) => json.encode(data.toJson());

class Person {
  String name;
  int age;

  Person({
    required this.name,
    required this.age,
  });

  factory Person.fromJson(Map<String, dynamic> json) => Person(
        name: json["Name"],
        age: json["age"],
      );

  Map<String, dynamic> toJson() => {
        "Name": name,
        "age": age,
      };
}

////Home
Home homeFromJson(String str) => Home.fromJson(json.decode(str));
String homeToJson(Home data) => json.encode(data.toJson());

class Home {
  int price;
  String floor;
  String phone;

  Home({
    required this.price,
    required this.floor,
    required this.phone,
  });

  factory Home.fromJson(Map<String, dynamic> json) => Home(
        price: json["price"],
        floor: json["floor"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "price": price,
        "floor": floor,
        "phone": phone,
      };
}
