import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'habitos_store.dart';
import 'tela_detalhe_habito.dart';
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
              itemBuilder: (context, indice) {
                final habito = habitos[indice];
                return ListTile(
                  title: Text(habito.nome),
                  subtitle: Text(habito.meta),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push<void>(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TelaDetalheHabito(habito: habito),
                      ),
                    );
                  },
                );
              },
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
