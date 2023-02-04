import 'package:finances/src/data/models/base_model.dart';
import 'dart:convert';

class Card extends BaseModel{
  String? name;
  String? finalNumber;
  String? dueDay;
  String? hexColor;
  String? type;

  Card(
    String? id,
    this.name,
    this.finalNumber,
    this.dueDay,
    this.hexColor,
    this.type,
  ) : super(id: id);

  Card.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    finalNumber = map['finalNumber'];
    dueDay = map['dueDay'];
    hexColor = map['hexColor'];
    type = map['type'];
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'finalNumber': finalNumber,
      'dueDay': dueDay,
      'hexColor': hexColor,
      'type': type,
    };
  }

  @override
  String toJson() => json.encode(toMap());

  factory Card.fromJson(String source) => Card.fromMap(json.decode(source));

  @override
  bool isValid() {
    return
    name != null &&
    dueDay != null &&
    hexColor != null &&
    type != null;
  }
}
