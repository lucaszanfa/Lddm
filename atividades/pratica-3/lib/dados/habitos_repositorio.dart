import '../dominio/habito.dart';

/// Armazenamento da sessão; não persiste após encerrar o aplicativo.
class HabitosRepositorio {
  final List<Habito> _memoria = [];

  Future<List<Habito>> carregar() async => List.of(_memoria);

  Future<void> salvar(Habito habito) async {
    _memoria.add(habito);
  }

  Future<bool> remover(Habito habito) async => _memoria.remove(habito);
}
