import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'habitos_store.dart';
import 'tela_novo_habito.dart';

class TelaHabitos extends StatelessWidget {
  const TelaHabitos({super.key});
  @override
  Widget build(BuildContext context) {
    final habitos = context.watch<HabitosStore>().habitos;
    return Scaffold(
      appBar: AppBar(title: const Text('Meus hábitos')),
      body: habitos.isEmpty
          ? const Center(child: Text('Nenhum hábito cadastrado.'))
          : ListView.builder(
              itemCount: habitos.length,
              itemBuilder: (context, indice) => ListTile(
                title: Text(habitos[indice].nome),
                subtitle: Text(habitos[indice].meta),
                trailing: IconButton(
                  tooltip: 'Remover hábito',
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () =>
                      context.read<HabitosStore>().removerEm(indice),
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Novo hábito',
        onPressed: () {
          Navigator.push<void>(
            context,
            MaterialPageRoute(builder: (_) => const TelaNovoHabito()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
