import 'dart:convert';
import 'package:fingen/src/data/models/base_model.dart';

class Usuario extends BaseModel {
  String nome;
  String email;
  String situacao;
  String tipo;
  int? diaFechamento;
  String? preferencia;
  DateTime? dataCadastro;

  Usuario({
    super.id,
    required this.nome,
    required this.email,
    required this.situacao,
    required this.tipo,
    this.diaFechamento,
    this.preferencia,
    this.dataCadastro,
  });

  factory Usuario.fromMap(Map<String, dynamic> map) => Usuario(
    id: map['id'],
    nome: map['nome'],
    email: map['email'],
    situacao: map['situacao'],
    tipo: map['tipo'],
    diaFechamento: map['diaFechamento'],
    preferencia: map['preferencia'],
    dataCadastro: map['dataCadastro']?.toDate(),
  );

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'situacao': situacao,
      'tipo': tipo,
      'diaFechamento': diaFechamento,
      'preferencia': preferencia,
      'dataCadastro': dataCadastro?.toIso8601String(),
    };
  }

  @override
  String toJson() => json.encode(toMap());

  @override
  bool isValid() {
    return nome.isNotEmpty
      && email.isNotEmpty
      && situacao.isNotEmpty
      && tipo.isNotEmpty;
  }
}