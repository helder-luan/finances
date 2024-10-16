import 'package:fingen/src/data/models/categoria/categoria.dart';
import 'package:fingen/src/data/providers/database_providers/categoria_firebase_provider.dart';
import 'package:fingen/src/data/repositories/base_repository.dart';

class CategoriaRepository extends BaseRepository<Categoria> {
  CategoriaRepository()
      : super(CategoriaFirebaseProvider(), (map) => Categoria.fromMap(map));
}