import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../dominio/habito.dart';
import '../dominio/habitos_store.dart';

class TelaNovoHabito extends StatefulWidget {
  const TelaNovoHabito({super.key});
  @override
  State<TelaNovoHabito> createState() => _TelaNovoHabitoState();
}

class _TelaNovoHabitoState extends State<TelaNovoHabito> {
  final _formulario = GlobalKey<FormState>();
  late final TextEditingController _nome;
  late final TextEditingController _meta;
  bool _salvando = false;
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

  Future<void> _salvar() async {
    if (_salvando || !_formulario.currentState!.validate()) return;
    setState(() => _salvando = true);
    await context.read<HabitosStore>().adicionar(
      Habito(nome: _nome.text.trim(), meta: _meta.text.trim()),
    );
    if (!mounted) return;
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
            validator: (valor) =>
                !Habito.campoValido(valor) ? 'Informe o nome do hábito.' : null,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _meta,
            decoration: const InputDecoration(labelText: 'Meta'),
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) => _salvar(),
            validator: (valor) =>
                !Habito.campoValido(valor) ? 'Informe a meta.' : null,
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: _salvando ? null : _salvar,
            child: const Text('Salvar'),
          ),
        ],
      ),
    ),
  );
}
