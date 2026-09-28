# Prática 3 — Diário de Hábitos

Esta pasta contém o documento da atividade e o projeto Flutter correspondente para a verificação em aula.

## Conteúdo

- `ATIVIDADE_PRATICA_3.md`: cinco requisitos funcionais, três não funcionais e tabela de mapeamento.
- `lib/`: código do aplicativo.
- `test/`: testes existentes da loja e do fluxo de detalhes e exclusão.
- `android/`, `web/` e `windows/`: arquivos das plataformas.
- `pubspec.yaml` e `pubspec.lock`: configuração e dependências.
- `analysis_options.yaml`: configuração da análise estática.

## Execução

Abra esta pasta no VS Code. Com o Flutter instalado, execute no terminal desta pasta:

```sh
flutter pub get
flutter run
```

Para executar as verificações existentes:

```sh
flutter analyze
flutter test
```

A primeira preparação das dependências pode exigir internet. Os hábitos ficam em memória durante a execução e não são mantidos após encerrar o aplicativo.

## Apresentação

Abra `ATIVIDADE_PRATICA_3.md` na visualização Markdown ao lado do projeto. Os caminhos da tabela são relativos a esta pasta.

1. Cadastre dois hábitos com nome e meta.
2. Confira a lista e abra os detalhes de um hábito.
3. Exclua esse hábito e confira o retorno à lista.
4. Abra Resumo e confira o total de um hábito.
5. Verifique os critérios não funcionais descritos no documento.

O código está organizado em `lib/ui/`, `lib/dominio/` e `lib/dados/`. A loja recebe o repositório pelo construtor; validação e contagem ficam no domínio. Para enviar somente Dart, selecione todos os arquivos `.dart` de `lib/`, mantendo as subpastas.

Esta pasta é uma cópia independente do projeto original. Caches, histórico Git e artefatos de compilação foram omitidos; os arquivos gerados necessários são recriados pelas ferramentas do Flutter.
