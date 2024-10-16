import 'dart:convert';

import 'package:fingen/src/data/models/base_model.dart';

class DespesaAssociada extends BaseModel {
  String idLancamento;
  String idPessoa;
  double? valorAtribuido;
  double? percentual;
  String situacao;
  DateTime? dataCadastro;

  DespesaAssociada({
    super.id,
    required this.idLancamento,
    required this.idPessoa,
    this.valorAtribuido,
    this.percentual,
    required this.situacao,
    this.dataCadastro,
  });

  factory DespesaAssociada.fromMap(Map<String, dynamic> map) => DespesaAssociada(
    id: map['id'],
    idLancamento: map['idLancamento'],
    idPessoa: map['idPessoa'],
    valorAtribuido: map['valorAtribuido'],
    percentual: map['percentual'],
    situacao: map['situacao'],
    dataCadastro: map['dataCadastro']?.toDate(),
  );

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idLancamento': idLancamento,
      'idPessoa': idPessoa,
      'valorAtribuido': valorAtribuido,
      'percentual': percentual,
      'situacao': situacao,
      'dataCadastro': dataCadastro?.toIso8601String(),
    };
  }

  @override
  String toJson() => json.encode(toMap());

  @override
  bool isValid() {
    return idLancamento.isNotEmpty
      && idPessoa.isNotEmpty
      && situacao.isNotEmpty;
  }
}