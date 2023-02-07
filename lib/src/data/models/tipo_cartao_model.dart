import 'dart:convert';
import 'package:finances/src/data/models/base_model.dart';

class TipoCartao extends BaseModel {
  int? idTipoCartao;
  String? descricao;

  TipoCartao({
    this.idTipoCartao,
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
      'idTipoCartao': idTipoCartao,
      'descricao': descricao
    };
  }

  TipoCartao.fromMap(Map<String, dynamic> map) {
    idTipoCartao = map['idTipoCartao'];
    descricao = map['descricao'];
  }

  @override
  String toJson() => json.encode(toMap());
}