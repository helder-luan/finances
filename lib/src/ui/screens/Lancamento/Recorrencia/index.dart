import 'package:fingen/src/core/app_colors.dart';
import 'package:flutter/material.dart';

class ListaRecorrencia extends StatefulWidget {
  const ListaRecorrencia({super.key});

  @override
  State<ListaRecorrencia> createState() => _ListaRecorrenciaState();
}

class _ListaRecorrenciaState extends State<ListaRecorrencia> {
  var recorrencias = [
    {
      'id': 1,
      'descricao': 'Mensalidade da academia',
      'situacao': 'A'
    },
    {
      'id': 2,
      'descricao': 'Conta de luz',
      'situacao': 'I'
    },
    {
      'id': 3,
      'descricao': 'Salário',
      'situacao': 'A'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recorrências'),
        backgroundColor: AppColors.purple,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                itemCount: recorrencias.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  final recorrencia = recorrencias[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            recorrencia['descricao'].toString(),
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Switch(
                          value: recorrencia['situacao'] == 'A',
                          onChanged: (bool isChecked) {
                            setState(() {
                              recorrencias[index]['situacao'] = isChecked ? 'A' : 'I';
                            });
                          },
                          activeColor: Colors.green,
                          inactiveThumbColor: Colors.red,
                          inactiveTrackColor: Color.fromARGB(127, 244, 67, 54),
                        ),
                      ],
                    ),
                  );
                },
              )
            ],
          )
        ),
      ),
    );
  }
}