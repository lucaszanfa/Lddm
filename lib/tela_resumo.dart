import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'habitos_store.dart';

class TelaResumo extends StatelessWidget {
  const TelaResumo({super.key});
  @override
  Widget build(BuildContext context) {
    final total = context.watch<HabitosStore>().habitos.length;
    return Scaffold(
      appBar: AppBar(title: const Text('Resumo')),
      body: Center(
        child: Text(
          total == 1 ? '1 hábito cadastrado' : '$total hábitos cadastrados',
        ),
      ),
    );
  }
}
