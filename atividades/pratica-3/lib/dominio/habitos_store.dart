import 'package:flutter/foundation.dart';

import 'habito.dart';
import '../dados/habitos_repositorio.dart';

class HabitosStore extends ChangeNotifier {
  HabitosStore(this._repositorio);

  final HabitosRepositorio _repositorio;
  List<Habito> _habitos = [];
  List<Habito> get habitos => List.unmodifiable(_habitos);
  int get total => _habitos.length;

  Future<void> carregar() async {
    _habitos = await _repositorio.carregar();
    notifyListeners();
  }

  Future<void> adicionar(Habito habito) async {
    if (!Habito.campoValido(habito.nome) || !Habito.campoValido(habito.meta)) {
      throw ArgumentError('Nome e meta são obrigatórios.');
    }
    await _repositorio.salvar(habito);
    await carregar();
  }

  Future<void> remover(Habito habito) async {
    if (await _repositorio.remover(habito)) {
      await carregar();
    }
  }
}
