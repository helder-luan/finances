import 'package:fingen/src/helpers/functions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LancamentoComponente extends StatefulWidget {
  final String descricao;
  final String data;
  final double valor;

  const LancamentoComponente({
    super.key,
    required this.descricao,
    required this.data,
    required this.valor,
  });

  @override
  State<LancamentoComponente> createState() => _LancamentoComponenteState();
}

class _LancamentoComponenteState extends State<LancamentoComponente> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      onLongPress: () {},
      child: Container(
        margin: const EdgeInsets.only(bottom: 16.0),
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.descricao,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(Functions.toCurrency(widget.valor)),
                ]
              ),
              Text(DateFormat.yMd().format(DateTime.parse(widget.data))),
            ]
          ),
        ),
      ),
    );
  }
}