import 'package:finances/src/data/models/fatura.dart';
import 'package:finances/src/data/providers/database_providers/Fatura_db_provider.dart';
import 'package:finances/src/data/repositories/base_repository.dart';

class FaturaRepository extends BaseRepository<Fatura> {
  FaturaRepository()
      : super(FaturaDbProvider(), (map) => Fatura.fromMap(map));

  Future<Fatura?> recoverByCardId(String cardId) async {
    var result = await (provider as FaturaDbProvider).recoverByCardId(cardId);

    return result.isNotEmpty ? instanceFromMap(result) : null;
  }

  Future<Fatura?> recoverByCardIdAndRefMonth(String cardId, String refMonth) async {
    var result = await (provider as FaturaDbProvider).recoverByCardIdAndRefMonth(cardId, refMonth);

    return result.isNotEmpty ? instanceFromMap(result) : null;
  }

  Future<void> updateValueByCardIdAndRefMonth(String cardId, String refMonth, double valorTotal) async {
    await (provider as FaturaDbProvider).updateValueByCardIdAndRefMonth(cardId, refMonth, valorTotal);
  }
}