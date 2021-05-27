// To parse this JSON data, do
//
//     final car = carFromJson(jsonString);

import 'dart:convert';

Car carFromJson(String str) => Car.fromJson(json.decode(str));

String carToJson(Car data) => json.encode(data.toJson());

class Car {
  Car({
    this.id,
    this.name,
    this.link,
    this.mileage,
    this.cost,
    this.type,
    this.rating,
    this.company,
  });

  String id;
  String name;
  String link;
  String mileage;
  String cost;
  String type;
  String rating;
  String company;

  factory Car.fromJson(Map<String, dynamic> json) => Car(
    id: json["_id"],
    name: json["name"],
    link: json["link"],
    mileage: json["mileage"],
    cost: json["cost"],
    type: json["type"],
    rating: json["rating"],
    company: json["company"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "link": link,
    "mileage": mileage,
    "cost": cost,
    "type": type,
    "rating": rating,
    "company": company,
  };
}
