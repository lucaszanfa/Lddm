import 'package:flutter/foundation.dart';

import 'habito.dart';

class HabitosStore extends ChangeNotifier {
  final List<Habito> _habitos = [];
  List<Habito> get habitos => List.unmodifiable(_habitos);

  void adicionar(Habito habito) {
    _habitos.add(habito);
    notifyListeners();
  }

  void remover(Habito habito) {
    if (_habitos.remove(habito)) {
      notifyListeners();
    }
  }
}
