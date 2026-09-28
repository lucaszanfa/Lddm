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
    const habito = Habito(nome: 'Ler', meta: '20 páginas');
    loja.adicionar(habito);
    loja.adicionar(habito);
    expect(() => loja.habitos.clear(), throwsUnsupportedError);
    loja.removerEm(1);
    expect(loja.habitos, [habito]);
    expect(notificacoes, 3);
  });

  testWidgets('Cadastro e remoção atualizam lista e resumo', (tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => HabitosStore(),
        child: const DiarioApp(),
      ),
    );
    await tester.tap(find.text('Resumo'));
    await tester.pumpAndSettle();
    expect(find.text('0 hábitos cadastrados'), findsOneWidget);
    await tester.tap(find.text('Hábitos'));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Salvar'));
    await tester.pumpAndSettle();
    expect(find.text('Informe o nome do hábito.'), findsOneWidget);
    await tester.enterText(find.byType(TextFormField).at(0), 'Ler');
    await tester.enterText(find.byType(TextFormField).at(1), '20 páginas');
    await tester.tap(find.text('Salvar'));
    await tester.pumpAndSettle();
    expect(find.text('Ler'), findsOneWidget);
    await tester.tap(find.text('Resumo'));
    await tester.pumpAndSettle();
    expect(find.text('1 hábito cadastrado'), findsOneWidget);
    await tester.tap(find.text('Hábitos'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Remover hábito'));
    await tester.pumpAndSettle();
    expect(find.text('Nenhum hábito cadastrado.'), findsOneWidget);
    await tester.tap(find.text('Resumo'));
    await tester.pumpAndSettle();
    expect(find.text('0 hábitos cadastrados'), findsOneWidget);
  });
}
