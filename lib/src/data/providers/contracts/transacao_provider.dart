import 'package:finances/src/data/providers/contracts/crud_provider.dart';

abstract class TransacaoProvider extends CRUDProvider {
  Future<List<Map<String, dynamic>>> recoverAllByCard(String cardId);
  Future<List<Map<String, dynamic>>> recoverAllByDate(DateTime date);
  Future<List<Map<String, dynamic>>> recoverAllByDateRange(DateTime startDate, DateTime endDate);
  Future<List<Map<String, dynamic>>> recoverAllByDateAndCard(DateTime date, String cardId);
  Future<List<Map<String, dynamic>>> recoverAllByDateRangeAndCard(DateTime startDate, DateTime endDate, String cardId);
}