import 'dart:convert';

import 'package:fingen/src/data/models/base_model.dart';

class Pessoa extends BaseModel {
  String nome;
  String? relacionamento;
  String? grauParentesco;
  String idUsuario;
  String situacao;
  DateTime? dataCadastro;

  Pessoa({
    super.id,
    required this.nome,
    this.relacionamento,
    this.grauParentesco,
    required this.idUsuario,
    required this.situacao,
    this.dataCadastro,
  });

  factory Pessoa.fromMap(Map<String, dynamic> map) => Pessoa(
    id: map['id'],
    nome: map['nome'],
    relacionamento: map['relacionamento'],
    grauParentesco: map['grauParentesco'],
    idUsuario: map['idUsuario'],
    situacao: map['situacao'],
    dataCadastro: map['dataCadastro']?.toDate(),
  );

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'relacionamento': relacionamento,
      'grauParentesco': grauParentesco,
      'idUsuario': idUsuario,
      'situacao': situacao,
      'dataCadastro': dataCadastro?.toIso8601String(),
    };
  }

  @override
  String toJson() => json.encode(toMap());

  @override
  bool isValid() {
    return nome.isNotEmpty
      && idUsuario.isNotEmpty
      && situacao.isNotEmpty;
  } 
}