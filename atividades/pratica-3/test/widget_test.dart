import 'package:flutter/material.dart';
import 'package:flutter_application_1/dados/habitos_repositorio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/dominio/habito.dart';
import 'package:flutter_application_1/dominio/habitos_store.dart';

void main() {
  testWidgets('Cadastro valida campos e atualiza lista e resumo', (
    tester,
  ) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => HabitosStore(HabitosRepositorio())..carregar(),
        child: const DiarioApp(),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Novo hábito'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Salvar'));
    await tester.pumpAndSettle();
    expect(find.text('Informe o nome do hábito.'), findsOneWidget);
    expect(find.text('Informe a meta.'), findsOneWidget);
    await tester.enterText(find.byType(TextFormField).at(0), 'Ler');
    await tester.enterText(find.byType(TextFormField).at(1), '20 páginas');
    await tester.tap(find.text('Salvar'));
    await tester.pumpAndSettle();
    expect(find.text('Ler'), findsOneWidget);
    await tester.tap(find.text('Resumo'));
    await tester.pumpAndSettle();
    expect(find.text('1 hábito cadastrado'), findsOneWidget);
  });

  test('A loja protege a lista e notifica adições e remoções', () async {
    final loja = HabitosStore(HabitosRepositorio());
    addTearDown(loja.dispose);
    var notificacoes = 0;
    loja.addListener(() => notificacoes++);
    const primeiro = Habito(nome: 'Ler', meta: '20 páginas');
    const segundo = Habito(nome: 'Ler', meta: '30 páginas');
    await loja.adicionar(primeiro);
    await loja.adicionar(segundo);
    expect(() => loja.habitos.clear(), throwsUnsupportedError);
    await loja.remover(segundo);
    expect(loja.habitos, [primeiro]);
    expect(notificacoes, 3);
  });

  testWidgets(
    'Detalhes mostram o item tocado e exclusão atualiza lista e resumo',
    (tester) async {
      final loja = HabitosStore(HabitosRepositorio());
      await loja.adicionar(const Habito(nome: 'Ler', meta: '20 páginas'));
      await loja.adicionar(const Habito(nome: 'Caminhar', meta: '30 minutos'));
      await tester.pumpWidget(
        ChangeNotifierProvider(create: (_) => loja, child: const DiarioApp()),
      );

      await tester.tap(find.text('Caminhar'));
      await tester.pumpAndSettle();
      expect(find.text('Nome: Caminhar'), findsOneWidget);
      expect(find.text('Meta: 30 minutos'), findsOneWidget);
      expect(find.text('Meta: 20 páginas'), findsNothing);

      await tester.pageBack();
      await tester.pumpAndSettle();
      expect(find.text('Caminhar'), findsOneWidget);

      await tester.tap(find.text('Caminhar'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Excluir'));
      await tester.pumpAndSettle();
      expect(find.text('Caminhar'), findsNothing);
      expect(find.text('Ler'), findsOneWidget);

      await tester.tap(find.text('Resumo'));
      await tester.pumpAndSettle();
      expect(find.text('1 hábito cadastrado'), findsOneWidget);
    },
  );
}
