import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/habito.dart';
import 'package:flutter_application_1/habitos_store.dart';

void main() {
  test('A loja protege a lista e notifica adições e remoções', () {
    final loja = HabitosStore();
    addTearDown(loja.dispose);
    var notificacoes = 0;
    loja.addListener(() => notificacoes++);
    const primeiro = Habito(nome: 'Ler', meta: '20 páginas');
    const segundo = Habito(nome: 'Ler', meta: '30 páginas');
    loja.adicionar(primeiro);
    loja.adicionar(segundo);
    expect(() => loja.habitos.clear(), throwsUnsupportedError);
    loja.remover(segundo);
    expect(loja.habitos, [primeiro]);
    expect(notificacoes, 3);
  });

  testWidgets('Detalhes mostram o item tocado e exclusão atualiza lista e resumo',
      (tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => HabitosStore()
          ..adicionar(const Habito(nome: 'Ler', meta: '20 páginas'))
          ..adicionar(const Habito(nome: 'Caminhar', meta: '30 minutos')),
        child: const DiarioApp(),
      ),
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
  });
}
