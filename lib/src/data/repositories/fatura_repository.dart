import 'package:finances/src/data/models/fatura.dart';
import 'package:finances/src/data/providers/database_providers/Fatura_db_provider.dart';
import 'package:finances/src/data/repositories/base_repository.dart';

class FaturaRepository extends BaseRepository<Fatura> {
  FaturaRepository()
      : super(FaturaDbProvider(), (map) => Fatura.fromMap(map));
}