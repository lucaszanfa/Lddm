import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'habito.dart';
import 'habitos_store.dart';

class TelaNovoHabito extends StatefulWidget {
  const TelaNovoHabito({super.key});
  @override
  State<TelaNovoHabito> createState() => _TelaNovoHabitoState();
}

class _TelaNovoHabitoState extends State<TelaNovoHabito> {
  final _formulario = GlobalKey<FormState>();
  late final TextEditingController _nome;
  late final TextEditingController _meta;
  @override
  void initState() {
    super.initState();
    _nome = TextEditingController();
    _meta = TextEditingController();
  }

  @override
  void dispose() {
    _nome.dispose();
    _meta.dispose();
    super.dispose();
  }

  void _salvar() {
    if (!_formulario.currentState!.validate()) return;
    context.read<HabitosStore>().adicionar(
      Habito(nome: _nome.text.trim(), meta: _meta.text.trim()),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Novo hábito')),
    body: Form(
      key: _formulario,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextFormField(
            controller: _nome,
            decoration: const InputDecoration(labelText: 'Nome do hábito'),
            textInputAction: TextInputAction.next,
            validator: (valor) => valor == null || valor.trim().isEmpty
                ? 'Informe o nome do hábito.'
                : null,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _meta,
            decoration: const InputDecoration(labelText: 'Meta'),
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) => _salvar(),
            validator: (valor) => valor == null || valor.trim().isEmpty
                ? 'Informe a meta.'
                : null,
          ),
          const SizedBox(height: 24),
          FilledButton(onPressed: _salvar, child: const Text('Salvar')),
        ],
      ),
    ),
  );
}
