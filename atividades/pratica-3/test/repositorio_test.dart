import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/dados/habitos_repositorio.dart';
import 'package:flutter_application_1/dominio/habito.dart';
import 'package:flutter_application_1/dominio/habitos_store.dart';

void main() {
  test(
    'Carregamento devolve cópia e outra loja recupera a mesma sessão',
    () async {
      final repo = HabitosRepositorio();
      final loja = HabitosStore(repo);
      final outraLoja = HabitosStore(repo);
      addTearDown(loja.dispose);
      addTearDown(outraLoja.dispose);
      const habito = Habito(nome: 'Ler', meta: '20 páginas');
      await loja.adicionar(habito);
      final copia = await repo.carregar();
      copia.clear();
      await outraLoja.carregar();
      expect(outraLoja.habitos, [habito]);
      expect(outraLoja.total, 1);
      await outraLoja.remover(habito);
      await loja.carregar();
      expect(loja.total, 0);
    },
  );

  test(
    'Domínio rejeita nome e meta vazios sem gravar no repositório',
    () async {
      final repo = HabitosRepositorio();
      final loja = HabitosStore(repo);
      addTearDown(loja.dispose);
      for (final habito in [
        const Habito(nome: '   ', meta: '20 páginas'),
        const Habito(nome: 'Ler', meta: ''),
      ]) {
        await expectLater(loja.adicionar(habito), throwsArgumentError);
      }
      expect(await repo.carregar(), isEmpty);
      expect(loja.total, 0);
    },
  );
}
