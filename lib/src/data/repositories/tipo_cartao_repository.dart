import 'package:finances/src/data/models/tipo_cartao_model.dart';
import 'package:finances/src/data/providers/database_providers/tipo_cartao_db_provider.dart';
import 'package:finances/src/data/repositories/base_repository.dart';

class TipoCartaoRepository extends BaseRepository<TipoCartao> {
  TipoCartaoRepository()
      : super(TipoCartaoDbProvider(), (map) => TipoCartao.fromMap(map));
}