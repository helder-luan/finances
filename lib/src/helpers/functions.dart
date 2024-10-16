import 'package:intl/intl.dart';

class Functions {
  static String fullMonthName(int month) {
    switch (month) {
      case 1:
        return 'Janeiro';
      case 2:
        return 'Fevereiro';
      case 3:
        return 'Março';
      case 4:
        return 'Abril';
      case 5:
        return 'Maio';
      case 6:
        return 'Junho';
      case 7:
        return 'Julho';
      case 8:
        return 'Agosto';
      case 9:
        return 'Setembro';
      case 10:
        return 'Outubro';
      case 11:
        return 'Novembro';
      case 12:
        return 'Dezembro';
      default:
        return '';
    }
  }

  static String toCurrency(double value) {
    String formattedValue = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(value);

    return formattedValue;
  }

  static double? formataValor(valor) {
    var parteReal = valor.toString().substring(0, valor.toString().length - 2);

    var parteCentavos = valor.toString().substring(valor.toString().length - 2, valor.toString().length);

    return double.tryParse("$parteReal.$parteCentavos");
  }

  static String dataPt(String data) {
    var dataFormatada = data.split(' ')[0];

    var dataSeparada = dataFormatada.split('-');

    return "${dataSeparada[2]}/${dataSeparada[1]}/${dataSeparada[0]}";
  }

  static String dataEn(String data) {
    var dataFormatada = data.split(' ')[0];

    var dataSeparada = dataFormatada.split('/');

    return "${dataSeparada[2]}-${dataSeparada[1]}-${dataSeparada[0]}";
  }
}