import 'package:finances/src/data/models/base_model.dart';
import 'dart:convert';

class Categoria extends BaseModel {
  int? idCategoria;
  String descricao;
  String? icone;
  String situacao;

  Categoria({
    this.idCategoria,
    required this.descricao,
    this.icone,
    required this.situacao,
  });

  factory Categoria.fromMap(Map<String, dynamic> map) {
    return Categoria(
      idCategoria: map['idCategoria'],
      descricao: map['descricao'],
      icone: map['icone'],
      situacao: map['situacao'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'idCategoria': idCategoria,
      'descricao': descricao,
      'icone': icone,
      'situacao': situacao,
    };
  }

  @override
  String toJson() => json.encode(toMap());

  factory Categoria.fromJson(String source) => Categoria.fromMap(json.decode(source));

  @override
  bool isValid() {
    return descricao.isNotEmpty;
  }
}