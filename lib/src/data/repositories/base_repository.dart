import 'package:fingen/src/data/models/base_model.dart';
import 'package:fingen/src/data/providers/contracts/crud_provider.dart';

abstract class BaseRepository<T extends BaseModel> {
  late CRUDProvider provider;
  T Function(Map<String, dynamic> map) instanceFromMap;

  BaseRepository(this.provider, this.instanceFromMap);

  Future<T?> insert(T registro) async {
    if (registro.isValid()) {
      var map = await provider.insert(registro.toMap());
      return instanceFromMap(map);
    }
    return null;
  }

  Future<T?> update(T registro) async {
    if (registro.isValid()) {
      var map = await provider.update(registro.toMap());
      return instanceFromMap(map);
    }
    return null;
  }

  Future<T> recover(String id) async {
    var map = await provider.recover(id);
    return instanceFromMap(map);
  }

  Future<List<T>> recoverAll() async {
    var maps = await provider.recoverAll();
    var lista = <T>[];
    for (var item in maps) {
      lista.add(instanceFromMap(item));
    }
    return lista;
  }

  Future<bool> delete(String id) async {
    return await provider.delete(id);
  }
}
