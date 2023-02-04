import 'package:finances/src/data/models/base_model.dart';
import 'dart:convert';

class Transaction extends BaseModel{
  String? description;
  double? value;
  String? details;
  DateTime? date;
  String? type;
  bool? refound;
  String? cardId;
  bool? monthlyExpense;
  bool? paymentInstallments;
  String? totalInstallments;
  String? currentInstallments;

  Transaction(
    String? id,
    this.description,
    this.value,
    this.details,
    this.date,
    this.type,
    this.refound,
    this.cardId,
    this.monthlyExpense,
    this.paymentInstallments,
    this.totalInstallments,
    this.currentInstallments,
  ) : super(id: id);

  Transaction.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    description = map['description'];
    value = map['value'];
    details = map['details'];
    date = map['date'];
    type = map['type'];
    refound = map['refound'];
    cardId = map['cardId'];
    monthlyExpense = map['monthlyExpense'];
    paymentInstallments = map['paymentInstallments'];
    totalInstallments = map['totalInstallments'];
    currentInstallments = map['currentInstallments'];
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'value': value,
      'details': details,
      'date': date,
      'type': type,
      'refound': refound,
      'cardId': cardId,
      'monthlyExpense': monthlyExpense,
      'paymentInstallments': paymentInstallments,
      'totalInstallments': totalInstallments,
      'currentInstallments': currentInstallments,
    };
  }

  @override
  String toJson() => json.encode(toMap());

  factory Transaction.fromJson(String source) => Transaction.fromMap(json.decode(source));

  @override
  bool isValid() {
    return
    description != null &&
    value != null &&
    details != null &&
    date != null &&
    type != null;
  }
}
