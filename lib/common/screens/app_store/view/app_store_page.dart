import 'package:flutter/material.dart';

import '../../calculadora/view/calculator.dart';
import '../viewmodel/app_store_view_model.dart';

class AppStorePage extends StatefulWidget {
  const AppStorePage({super.key});

  @override
  State<AppStorePage> createState() => _AppStorePageState();
}

class _AppStorePageState extends State<AppStorePage> {
  late AppStoreViewModel _viewModel;

  final Color _backgroundColor = const Color(0xFF2C211E);
  final Color _leftColumnBackgroundColor = const Color(0xFF372C29);

  @override
  void initState() {
    super.initState();
    _viewModel = AppStoreViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _viewModel,
      builder: (_, __) {
        return ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 1200,
            maxHeight: 800,
          ),
          child: Row(
            children: [
              // Primeira Coluna
              Container(
                color: _leftColumnBackgroundColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ActionRowButtons(
                      onClose: () {},
                      onMinimize: () {},
                      onMaximize: () {},
                    )
                  ],
                ),
              )
              // Fim Primeira Coluna
            ],
          ),
        );
      },
    );
  }
}
