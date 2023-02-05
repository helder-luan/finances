import 'package:finances/src/data/providers/database_providers/cartao_db_provider.dart';
import 'package:finances/src/data/repositories/base_repository.dart';
import 'package:finances/src/data/models/cartao.dart';

class CartaoRepository extends BaseRepository<Cartao> {
  CartaoRepository()
      : super(CartaoDbProvider(), (map) => Cartao.fromMap(map));
}
