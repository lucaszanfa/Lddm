import 'package:flutter/material.dart';

void main() => runApp(const DiarioApp());

class Habito {
  final String nome;
  final String meta;
  final IconData icone;

  const Habito(this.nome, this.meta, this.icone);
}

const habitos = [
  Habito('Beber água', 'Meta: 8 copos por dia', Icons.local_drink),
  Habito('Ler', 'Meta: 20 páginas por dia', Icons.menu_book),
  Habito('Caminhar', 'Meta: 30 minutos por dia', Icons.directions_walk),
  Habito('Dormir cedo', 'Meta: antes das 23h', Icons.bedtime),
];

class Receita {
  final String nome;
  final String origem;
  final int minutos;
  final IconData icone;

  const Receita(this.nome, this.origem, this.minutos, this.icone);
}

const receitas = [
  Receita('Pão de queijo', 'Minas Gerais', 40, Icons.circle),
  Receita('Moqueca', 'Bahia', 55, Icons.lunch_dining_sharp),
  Receita(
    'Arroz carreteiro',
    'Rio Grande do Sul',
    35,
    Icons.lunch_dining_rounded,
  ),
];

class DiarioApp extends StatelessWidget {
  const DiarioApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Receitas',
    home: Scaffold(
      appBar: AppBar(
        title: const Text('Receitas'),
        backgroundColor: const Color.fromARGB(255, 15, 80, 133),
        foregroundColor: Colors.white,
        actions: [const Icon(Icons.search), const SizedBox(width: 16)],
      ),
      body: ListView(
        children: [
          Container(
            height: 35,
            color: Colors.grey.shade300,
            padding: const EdgeInsets.all(8),
            child: const Text(
              '3 Receitas',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
          ),
          for (final r in receitas)
            ListTile(
              leading: Icon(r.icone),
              title: Text(
                r.nome,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(r.origem),
              trailing: Text('${r.minutos} min'),
            ),
        ],
      ),
    ),
  );
}
