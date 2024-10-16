import 'dart:math';

import 'package:fingen/src/data/models/lancamento/lancamento.dart';
import 'package:fingen/src/ui/screens/Home/components/lancamento.dart';
import 'package:flutter/material.dart';

class ListaLancamento extends StatefulWidget {
  final List<Lancamento> lancamentos;

  const ListaLancamento({
    super.key,
    this.lancamentos = const [],
  });

  @override
  State<ListaLancamento> createState() => _ListaLancamentoState();
}

class _ListaLancamentoState extends State<ListaLancamento> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(color: Colors.black12, offset: Offset(0, 0), blurRadius: 10)
        ]
      ),
      padding: EdgeInsets.all(8),
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 16.0),
            child: const Text(
              'Transações recentes',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          Builder(
            builder: (context) {
              return Container(
                margin: const EdgeInsets.only(bottom: 40),
                child: Column(
                  children: [
                    for (int i = 0; i < 5; i++)
                      LancamentoComponente(
                        descricao: 'Descrição do lançamento $i',
                        data: '2024-01-0${i + 1} 0$i:0$i:0$i',
                        valor: 100.0 + (i * Random().nextDouble() * 100.0),
                      )
                  ],
                ),
              );
            }
          ),
        ],
      ),
    );
  }
}