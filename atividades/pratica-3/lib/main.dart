import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dominio/habitos_store.dart';
import 'dados/habitos_repositorio.dart';
import 'ui/tela_habitos.dart';
import 'ui/tela_resumo.dart';
import 'ui/exemplo_receitas.dart' as exemplo;

void main() => runApp(
  ChangeNotifierProvider(
    create: (_) => HabitosStore(HabitosRepositorio())..carregar(),
    child: const DiarioApp(),
  ),
);

class DiarioApp extends StatelessWidget {
  const DiarioApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Diário de hábitos',
    debugShowCheckedModeBanner: false,
    home: const TelaPrincipal(),
  );
}

class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({super.key});
  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  int _indice = 0;
  static const _telas = [TelaHabitos(), TelaResumo(), TelaReceitas()];
  @override
  Widget build(BuildContext context) => Scaffold(
    body: IndexedStack(index: _indice, children: _telas),
    bottomNavigationBar: NavigationBar(
      selectedIndex: _indice,
      onDestinationSelected: (indice) => setState(() => _indice = indice),
      destinations: const [
        NavigationDestination(icon: Icon(Icons.checklist), label: 'Hábitos'),
        NavigationDestination(icon: Icon(Icons.bar_chart), label: 'Resumo'),
        NavigationDestination(icon: Icon(Icons.restaurant), label: 'Receitas'),
      ],
    ),
  );
}

class TelaReceitas extends StatelessWidget {
  const TelaReceitas({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Receitas')),
    body: ListView(
      children: [
        ListTile(title: Text('${exemplo.receitas.length} receitas')),
        for (final receita in exemplo.receitas)
          ListTile(
            leading: Icon(receita.icone),
            title: Text(receita.nome),
            subtitle: Text(receita.origem),
            trailing: Text('${receita.minutos} min'),
          ),
      ],
    ),
  );
}
