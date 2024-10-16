import 'dart:convert';

import 'package:fingen/src/data/models/base_model.dart';

class FormaPagamento extends BaseModel {
  String descricao;
  String situacao;
  DateTime? dataCadastro;

  FormaPagamento({
    super.id,
    required this.descricao,
    required this.situacao,
    this.dataCadastro,
  });

  factory FormaPagamento.fromMap(Map<String, dynamic> map) => FormaPagamento(
    id: map['id'],
    descricao: map['descricao'],
    situacao: map['situacao'],
    dataCadastro: map['dataCadastro']?.toDate(),
  );

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'descricao': descricao,
      'situacao': situacao,
      'dataCadastro': dataCadastro?.toIso8601String(),
    };
  }

  @override
  String toJson() => json.encode(toMap());

  @override
  bool isValid() {
    return [descricao, situacao].every((value) => value.isNotEmpty);
  }
}