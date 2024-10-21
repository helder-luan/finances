import 'package:fingen/src/theme/color_scheme.dart';
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
            return const SingleChildScrollView(
              child: Column(
                children: [
                  CardGasto(),
                  ListaCartao(cartoes: []),
                  ListaLancamento(lancamentos: [])
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
        backgroundColor: ColorSchemeCustom.primary,
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
            backgroundColor: ColorSchemeCustom.success,
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
            backgroundColor: ColorSchemeCustom.danger,
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
            backgroundColor: ColorSchemeCustom.info,
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