import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'habito.dart';
import 'habitos_store.dart';

class TelaDetalheHabito extends StatelessWidget {
  const TelaDetalheHabito({super.key, required this.habito});

  final Habito habito;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(habito.nome)),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Nome: ${habito.nome}'),
          const SizedBox(height: 12),
          Text('Meta: ${habito.meta}'),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: () {
              context.read<HabitosStore>().remover(habito);
              Navigator.pop(context);
            },
            child: const Text('Excluir'),
          ),
        ],
      ),
    ),
  );
}
