import 'dart:convert';
import 'package:finances/src/data/models/base_model.dart';

class TipoCartao extends BaseModel {
  String? descricao;

  TipoCartao({
    String? id,
    this.descricao
  }) : super(id: id);

  @override
  bool isValid() {
    return
    descricao != null &&
    descricao!.isNotEmpty;
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'descricao': descricao
    };
  }

  TipoCartao.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    descricao = map['descricao'];
  }

  @override
  String toJson() => json.encode(toMap());
}