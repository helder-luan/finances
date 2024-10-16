import 'package:fingen/src/core/app_colors.dart';
import 'package:fingen/src/ui/components/QuickActionsMenu/index.dart';
import 'package:fingen/src/ui/components/QuickActionsMenu/quick_action.dart';
import 'package:fingen/src/ui/screens/Home/components/card_gasto.dart';
import 'package:fingen/src/ui/screens/Home/components/lista_cartao.dart';
import 'package:fingen/src/ui/screens/Home/components/lista_lancamento.dart';
import 'package:fingen/src/ui/screens/Lancamento/Despesa/index.dart';
import 'package:fingen/src/ui/screens/Lancamento/Receita/index.dart';
import 'package:fingen/src/ui/screens/Lancamento/Recorrencia/index.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: Future.delayed(const Duration(seconds: 2)),
          builder: (context, snapshot) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  // Container(
                  //   decoration: const BoxDecoration(
                  //     image: DecorationImage(
                  //       image: AssetImage('assets/images/background_cartao.jpg'),
                  //       fit: BoxFit.cover,
                  //       alignment: Alignment.bottomLeft,
                  //       opacity: 0.7
                  //     )
                  //   ),
                  //   child: Column(
                  //     children: [
                  //       // header
                  //       Padding(
                  //         padding: const EdgeInsets.all(8),
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //             ElevatedButton(
                  //               onPressed: () {
                  //               },
                  //               style: ElevatedButton.styleFrom(
                  //                 shape: const CircleBorder(),
                  //                 padding: const EdgeInsets.all(0),
                  //                 backgroundColor: Colors.transparent,
                  //               ),
                  //               child: const ClipOval(
                  //                 child: Image(image: AssetImage('assets/upload/gary-final-space.jpg'), height: 32, width: 32, fit: BoxFit.cover),
                  //               ),
                  //             ),
                  //           ]
                  //         ),
                  //       ),
                  //     ]
                  //   ),
                  // ),
                  const CardGasto(),
                  const ListaCartao(cartoes: []),
                  const ListaLancamento(lancamentos: [])
                ],
              ),
            );
          },
        ),
      ),
      // bottomNavigationBar: const BottomMenu(),
      floatingActionButton: QuickActionMenu(
        onTap: () {},
        icon: Icons.menu,
        backgroundColor: AppColors.primary,
        actions: [
          QuickAction(
            // receita
            icon: Icons.trending_up_outlined,
            iconColor: Colors.white,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CadastroReceita(),
                ),
              );
            },
            backgroundColor: AppColors.success,
          ),
          QuickAction(
            icon: Icons.trending_down_outlined,
            iconColor: Colors.white,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CadastroDespesa(),
                ),
              );
            },
            backgroundColor: AppColors.danger,
          ),
          QuickAction(
            icon: Icons.repeat,
            iconColor: Colors.white,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ListaRecorrencia(),
                ),
              );
            },
            backgroundColor: AppColors.purple,
          ),
        ],
        child: const Icon(
          Icons.menu,
          color: Colors.white
        ),
      ),
    );
  }
}