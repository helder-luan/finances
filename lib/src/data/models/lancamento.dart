import 'package:finances/src/data/models/base_model.dart';
import 'dart:convert';

class Lancamento extends BaseModel {
  // tipo lancamento
  static const receita = 'R';
  static const despesa = 'D';

  int? idLancamento;
  String descricao;
  String? detalhes;
  int? idCategoria;
  double valor;
  DateTime dataOcorrencia;
  String tipo;
  String recorrente;
  String situacao;
  DateTime created_at;

  Lancamento({
    this.idLancamento,
    required this.descricao,
    this.detalhes,
    this.idCategoria,
    required this.valor,
    required this.dataOcorrencia,
    required this.tipo,
    required this.recorrente,
    required this.situacao,
    required this.created_at,
  });

  factory Lancamento.fromMap(Map<String, dynamic> map) {
    return Lancamento(
      idLancamento: map['idLancamento'],
      descricao: map['descricao'],
      detalhes: map['detalhes'],
      idCategoria: map['idCategoria'],
      valor: map['valor'],
      dataOcorrencia: DateTime.parse(map['dataOcorrencia']),
      tipo: map['tipo'],
      recorrente: map['recorrente'],
      situacao: map['situacao'],
      created_at: DateTime.parse(map['created_at']),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'idLancamento': idLancamento,
      'descricao': descricao,
      'detalhes': detalhes,
      'idCategoria': idCategoria,
      'valor': valor,
      'dataOcorrencia': dataOcorrencia.toIso8601String(),
      'tipo': tipo,
      'recorrente': recorrente,
      'situacao': situacao,
      'created_at': created_at.toIso8601String(),
    };
  }

  @override
  String toJson() => json.encode(toMap());

  factory Lancamento.fromJson(String source) => Lancamento.fromMap(json.decode(source));

  @override
  bool isValid() {
    return
      descricao.isNotEmpty &&
      valor > 0;
  }
}
