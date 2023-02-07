import 'package:finances/src/data/providers/contracts/crud_provider.dart';

abstract class TransacaoProvider extends CRUDProvider {
  Future<List<Map<String, dynamic>>> recoverAllByCard(String cardId);
  Future<List<Map<String, dynamic>>> recoverAllByDate(String date);
  Future<List<Map<String, dynamic>>> recoverAllByDateRange(String startDate, String endDate);
  Future<List<Map<String, dynamic>>> recoverAllByDateAndCard(String date, String cardId);
  Future<List<Map<String, dynamic>>> recoverAllByDateRangeAndCard(String startDate, String endDate, String cardId);
}