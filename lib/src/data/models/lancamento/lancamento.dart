import 'dart:convert';

import 'package:fingen/src/data/models/base_model.dart';

class Lancamento extends BaseModel {
  double valorTotal;
  DateTime dataOcorrencia;
  String descricao;
  String tipo;
  String? observacao;
  String? idFormaPamento;
  String parcelado;
  int? numeroParcelas;
  String recorrente;
  String? idCategoria;
  String? idCartao;
  String? despesaAssociada;
  String idUsuario;
  DateTime? dataCadastro;

  Lancamento({
    super.id,
    required this.valorTotal,
    required this.dataOcorrencia,
    required this.descricao,
    required this.tipo,
    this.observacao,
    this.idFormaPamento,
    this.parcelado = 'N',
    this.numeroParcelas,
    this.recorrente = 'N',
    this.idCategoria,
    this.idCartao,
    this.despesaAssociada,
    required this.idUsuario,
    this.dataCadastro,
  });

  factory Lancamento.fromMap(Map<String, dynamic> map) => Lancamento(
    id: map['id'],
    valorTotal: map['valorTotal'],
    dataOcorrencia: map['dataOcorrencia']?.toDate(),
    descricao: map['descricao'],
    tipo: map['tipo'],
    idFormaPamento: map['idFormaPamento'],
    parcelado: map['parcelado'],
    numeroParcelas: map['numeroParcelas'],
    recorrente: map['recorrente'],
    idCategoria: map['idCategoria'],
    idCartao: map['idCartao'],
    despesaAssociada: map['despesaAssociada'],
    idUsuario: map['idUsuario'],
    dataCadastro: map['dataCadastro']?.toDate(),
  );

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'valorTotal': valorTotal,
      'dataOcorrencia': dataOcorrencia.toIso8601String(),
      'descricao': descricao,
      'tipo': tipo,
      'observacao': observacao,
      'idFormaPamento': idFormaPamento,
      'parcelado': parcelado,
      'numeroParcelas': numeroParcelas,
      'recorrente': recorrente,
      'idCategoria': idCategoria,
      'idCartao': idCartao,
      'despesaAssociada': despesaAssociada,
      'idUsuario': idUsuario,
      'dataCadastro': dataCadastro?.toIso8601String(),
    };
  }

  @override
  String toJson() => json.encode(toMap());

  @override
  bool isValid() {
    return valorTotal > 0
      && dataOcorrencia.isBefore(DateTime.now())
      && descricao.isNotEmpty
      && tipo.isNotEmpty
      && idUsuario.isNotEmpty;
  }
}