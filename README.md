# LDDM — Atividades práticas

Repositório das atividades Flutter do Diário de Hábitos.

| Atividade | Projeto | Documento |
| --- | --- | --- |
| Check 2 | [atividades/check-2](atividades/check-2) | Versão anterior à separação em camadas |
| Prática 3 | [atividades/pratica-3](atividades/pratica-3) | [Requisitos e mapeamento](atividades/pratica-3/ATIVIDADE_PRATICA_3.md) |

Cada pasta de atividade é um projeto Flutter independente. Abra a pasta desejada no editor e execute nela:

```sh
flutter pub get
flutter run
```

Para verificar o projeto, execute `flutter analyze` e `flutter test` na mesma pasta.

## Prática 3

- `lib/ui/`: telas e apresentação.
- `lib/dominio/`: modelo, validação e estado dos hábitos.
- `lib/dados/`: repositório em memória.
- `lib/main.dart`: inicialização e composição do aplicativo.
- `test/`: testes automatizados.

Para o envio solicitado apenas em Dart, envie todos os arquivos `.dart` de `atividades/pratica-3/lib/`, preservando suas subpastas. O documento Markdown deve estar disponível para a conferência em aula junto do projeto.

O armazenamento da Prática 3 é em memória: os hábitos duram somente durante a execução do aplicativo.
