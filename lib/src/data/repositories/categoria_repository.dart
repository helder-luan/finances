import 'package:finances/src/data/models/categoria.dart';
import 'package:finances/src/data/providers/database_providers/categoria_db_provider.dart';
import 'package:finances/src/data/repositories/base_repository.dart';

class CategoriaRepository extends BaseRepository<Categoria> {
  CategoriaRepository()
      : super(CategoriaDbProvider(), (map) => Categoria.fromMap(map));
}