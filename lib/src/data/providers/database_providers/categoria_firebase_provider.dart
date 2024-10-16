import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fingen/src/data/providers/contracts/categoria_provider.dart';

class CategoriaFirebaseProvider extends CategoriaProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String nameCollection = 'fnc_categoria';

  @override
  Future<Map<String, dynamic>> insert(Map<String, dynamic> registro) async {
    registro.remove('id');
    var ret = await _firestore.collection(nameCollection).add(registro);
    registro['id'] = ret.id;
    return registro;
  }

  @override
  Future<Map<String, dynamic>> recover(String id) async {
    DocumentSnapshot<Map<String, dynamic>> ds = await _firestore.collection(nameCollection).doc(id).get();

    return ds.data() ?? <String, dynamic>{};
  }

  @override
  Future<List<Map<String, dynamic>>> recoverAll() async {
    QuerySnapshot qs = await _firestore.collection(nameCollection).get();

    var retorno = <Map<String, dynamic>>[];
    for (var item in qs.docs) {
      var map = _toMap(item.data());
      map['id'] = item.id;
      retorno.add(map);
    }
    return retorno;
  }

  @override
  Future<bool> delete(String id) async {
    await _firestore.collection(nameCollection).doc(id).delete();
    return true;
  }

  @override
  Future<Map<String, dynamic>> update(Map<String, dynamic> registro) async {
    var id = registro['id'];
    registro.remove('id');
    await _firestore.collection(nameCollection).doc(id).update(registro);
    registro['id'] = id;
    return registro;
  }

  Map<String, dynamic> _toMap(Object? data) {
    if (data == null) return <String, dynamic>{};
    return {
      'nome': (data as Map<String, dynamic>)['nome'],
      'tipo': data['tipo'],
      'situacao': data['situacao'],
      'dataCadastro': data['dataCadastro'],
    };
  }
}