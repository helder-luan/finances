import 'dart:convert';

import 'package:fingen/src/data/models/base_model.dart';

class Cartao extends BaseModel {
  String? nome;
  String? ultimosDigitos;
  String tipo;
  String idUsuario;
  String situacao;
  DateTime dataCadastro;

  Cartao({
    super.id,
    required this.nome,
    required this.ultimosDigitos,
    required this.tipo,
    required this.idUsuario,
    required this.situacao,
    required this.dataCadastro,
  });

  factory Cartao.fromMap(Map<String, dynamic> map) => Cartao(
    id: map['id'],
    nome: map['nome'],
    ultimosDigitos: map['ultimosDigitos'],
    tipo: map['tipo'],
    idUsuario: map['idUsuario'],
    situacao: map['situacao'],
    dataCadastro: DateTime.parse(map['dataCadastro']),
  );

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'ultimosDigitos': ultimosDigitos,
      'tipo': tipo,
      'idUsuario': idUsuario,
      'situacao': situacao,
      'dataCadastro': dataCadastro.toString(),
    };
  }

  @override
  String toJson() => json.encode(toMap());

  @override
  bool isValid() {
    return nome!.isNotEmpty
      && ultimosDigitos!.isNotEmpty
      && tipo.isNotEmpty
      && idUsuario.isNotEmpty
      && situacao.isNotEmpty;
  } 
}