import 'package:finances/src/data/providers/contracts/crud_provider.dart';

abstract class LancamentoProvider extends CRUDProvider {
  Future<List<Map<String, dynamic>>> recoverAllByMonthReference(int monthReference);
  Future<List<Map<String, dynamic>>> recoverAllByDate(DateTime date);
  Future<List<Map<String, dynamic>>> recoverAllByDateRange(DateTime startDate, DateTime endDate);
  Future<List<Map<String, dynamic>>> recoverAllGastoMensal();
}