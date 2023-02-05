import 'dart:convert';

import 'package:finances/src/data/models/base_model.dart';

class TipoOperacao extends BaseModel {
  String? descricao;

  TipoOperacao({
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

  TipoOperacao.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    descricao = map['descricao'];
  }

  @override
  String toJson() => json.encode(toMap());
}