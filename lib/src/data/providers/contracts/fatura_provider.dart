import 'package:finances/src/data/providers/contracts/crud_provider.dart';

abstract class FaturaProvider extends CRUDProvider {
  Future<Map<String, dynamic>> recoverByCardId(String cardId);
  Future<Map<String, dynamic>> recoverByCardIdAndRefMonth(String cardId, String refMonth);
  Future<void> updateByCardIdAndRefMonth(String cardId, String refMonth, String valorTotal);
}