import 'package:finances/src/data/models/tipo_operacao_model.dart';
import 'package:finances/src/data/providers/database_providers/tipo_operacao_db_provider.dart';
import 'package:finances/src/data/repositories/base_repository.dart';

class TipoOperacaoRepository extends BaseRepository<TipoOperacao> {
  TipoOperacaoRepository()
      : super(TipoOperacaoDbProvider(), (map) => TipoOperacao.fromMap(map));
}