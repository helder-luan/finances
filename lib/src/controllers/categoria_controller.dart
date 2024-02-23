import 'package:finances/src/data/models/categoria.dart';
import 'package:finances/src/data/repositories/categoria_repository.dart';
import 'package:flutter/cupertino.dart';

class CategoriaController extends ChangeNotifier {
  
  set dataSourceCategoria(value) => dataSourceCategoriaNotifier.value = value;
  List<Categoria> get dataSourceCategoria => dataSourceCategoriaNotifier.value;

  ValueNotifier<List<Categoria>> dataSourceCategoriaNotifier =
      ValueNotifier(<Categoria>[]);

  final CategoriaRepository _categoriaRepository = CategoriaRepository();

  final TextEditingController descricao = TextEditingController(text: '');

  Future<void> getCategorias() async {
    await _categoriaRepository.recoverAll().then((value) {
      dataSourceCategoria = value;
    });
  }
}