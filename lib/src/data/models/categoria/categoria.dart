import 'dart:convert';

import 'package:fingen/src/data/models/base_model.dart';

class Categoria extends BaseModel {
  String nome;
  String tipo;
  String situacao;
  DateTime? dataCadastro;

  Categoria({
    super.id,
    required this.nome,
    required this.tipo,
    required this.situacao,
    this.dataCadastro,
  });

  factory Categoria.fromMap(Map<String, dynamic> map) => Categoria(
    id: map['id'],
    nome: map['nome'],
    tipo: map['tipo'],
    situacao: map['situacao'],
    dataCadastro: map['dataCadastro']?.toDate(),
  );

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'tipo': tipo,
      'situacao': situacao,
      'dataCadastro': dataCadastro?.toIso8601String(),
    };
  }

  @override
  String toJson() => json.encode(toMap());

  @override
  bool isValid() {
    return [nome, tipo, situacao].every((value) => value.trim().isNotEmpty);
  } 
}