import 'dart:convert';

import 'package:finances/src/data/models/base_model.dart';

class TipoOperacao extends BaseModel {
  int? idTipoOperacao;
  String? descricao;

  TipoOperacao({
    this.idTipoOperacao,
    this.descricao
  });

  @override
  bool isValid() {
    return
    descricao != null &&
    descricao!.isNotEmpty;
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'idTipoOperacao': idTipoOperacao,
      'descricao': descricao
    };
  }

  TipoOperacao.fromMap(Map<String, dynamic> map) {
    idTipoOperacao = map['idTipoOperacao'];
    descricao = map['descricao'];
  }

  @override
  String toJson() => json.encode(toMap());
}