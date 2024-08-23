import 'package:flutter/material.dart';

import '../viewmodel/games_view_model.dart';

class GamesPage extends StatefulWidget {
  const GamesPage({super.key});

  @override
  State<GamesPage> createState() => _GamesPageState();
}

class _GamesPageState extends State<GamesPage> {
  late GamesViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = GamesViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: AnimatedBuilder(
        animation: _viewModel,
        builder: (_, __) {
          return ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 700,
              maxHeight: 450,
            ),
            child: SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    // PRIMEIRA COLUNA
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Games"),
                        const SizedBox(height: 20),
                        Container(
                          height: 120,
                          width: 120,
                          color: Colors.red,
                          child: const Text("Memória"),
                        ),
                      ],
                    ),
                    // FIM DA SEGUNDA COLUNA

                    // TELA DO JOGO EM SI
                    Expanded(
                      child: Column(
                        children: [
                          // SEGUNDA COLUNA
                          Row(
                            children: [
                              Container(
                                height: 120,
                                width: 120,
                                color: Colors.red,
                                child: const Text("Jogo da Velha"),
                              ),
                              const SizedBox(width: 20),
                              Container(
                                height: 120,
                                width: 120,
                                color: Colors.red,
                                child: const Text("Jogo da Memória"),
                              ),
                            ],
                          ),
                          // FIM DA SEGUNDA COLUNA
                          const SizedBox(height: 20),
                          // TERCEIRA COLUNA
                          Row(
                            children: [
                              Container(
                                height: 120,
                                width: 120,
                                color: Colors.red,
                                child: const Text("Jogo da Forca"),
                              ),
                              const SizedBox(width: 20),
                              Container(
                                height: 120,
                                width: 120,
                                color: Colors.red,
                                child: const Text("Jogo da Memória"),
                              ),
                            ],
                          ),
                        ],
                        // FIM DA TERCEIRA COLUNA
                      ),
                    ),
                    // FIM DA TELA DO JOGO
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
