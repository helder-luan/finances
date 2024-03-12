import 'package:finances/src/core/app_colors.dart';
import 'package:finances/src/core/app_images.dart';
import 'package:finances/src/ui/components/BottomMenu/index.dart';
import 'package:finances/src/ui/components/Button/index.dart';
import 'package:finances/src/ui/components/TextComponent/index.dart';
import 'package:finances/src/ui/screens/Gasto/GastoFlow/EntradaScreen/index.dart';
import 'package:finances/src/ui/screens/Gasto/GastoFlow/Recorrente/index.dart';
import 'package:finances/src/ui/screens/Gasto/GastoFlow/SaidaScreen/index.dart';
import 'package:flutter/material.dart';

class GastoScreen extends StatefulWidget {
  const GastoScreen({super.key});

  @override
  State<GastoScreen> createState() => _GastoScreenState();
}

class _GastoScreenState extends State<GastoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
              gradient: AppColors.gradient,
            ),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 32.0),
                  padding: const EdgeInsets.all(16.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.0),
                      topRight: Radius.circular(16.0),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 24.0),
                        child: const TextComponent(text: 'Gerenciar Gastos', style: 'title'),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 16.0),
                        child: const TextComponent(text: 'Cadastrar', style: 'subtitle'),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 16.0),
                        height: 60,
                        width: MediaQuery.of(context).size.width-32,
                        child: ButtonComponent(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const EntradaScreen()),
                            );
                          },
                          style: 'success',
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const EntradaScreen()),
                                  );
                                },
                                icon: Image(image: AssetImage(AppImages.entrada)),
                                iconSize: 32,
                              ),
                              const TextComponent(
                                text: 'Entrada',
                                color: Colors.white,
                                weight: FontWeight.bold,
                                size: 24.0,
                              )
                            ],
                          ),
                        ), 
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 16.0),
                        height: 60,
                        width: MediaQuery.of(context).size.width-32,
                        child: ButtonComponent(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const SaidaScreen()),
                            );
                          },
                          style: 'danger',
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const SaidaScreen()),
                                  );
                                },
                                icon: Image(image: AssetImage(AppImages.saida)),
                                iconSize: 32,
                              ),
                              const TextComponent(
                                text: 'Saída',
                                color: Colors.white,
                                weight: FontWeight.bold,
                                size: 24.0,
                              ),
                            ],
                          ),
                        ), 
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 16.0),
                        height: 60,
                        width: MediaQuery.of(context).size.width - 32,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            backgroundColor: AppColors.primary
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const CobrancaRecorrenteScreen()),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const CobrancaRecorrenteScreen()),
                                  );
                                },
                                icon: const Icon(Icons.repeat, color: Colors.white),
                                iconSize: 32,
                              ),
                              const TextComponent(
                                text: 'Recorrente',
                                color: Colors.white,
                                weight: FontWeight.bold,
                                size: 24.0,
                              ),
                            ],
                          ),
                        ), 
                      ),
                    ],
                  )
                )
              ],
            )
          ),
        ),
      ),
      bottomNavigationBar: const BottomMenu(),
    );
  }
}