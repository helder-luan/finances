import 'package:fingen/src/data/models/lancamento/lancamento.dart';
import 'package:fingen/src/data/providers/database_providers/lancamento_firebase_provider.dart';
import 'package:fingen/src/data/repositories/base_repository.dart';

class LancamentoRepository extends BaseRepository<Lancamento> {
  LancamentoRepository()
      : super(LancamentoFirebaseProvider(), (map) => Lancamento.fromMap(map));
}
