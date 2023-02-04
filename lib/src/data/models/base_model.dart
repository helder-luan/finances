import 'dart:convert';

abstract class BaseModel {
  String? id;

  BaseModel({this.id});

  String toJson() => json.encode(toMap());
  BaseModel.fromMap(Map<String, dynamic> map);
  Map<String, dynamic> toMap();

  bool isValid();
}
