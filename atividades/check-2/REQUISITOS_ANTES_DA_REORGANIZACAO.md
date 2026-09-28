# Atividade Prática 3 — Requisitos do Diário de Hábitos

## Parte 1 — Requisitos numerados

### Requisitos funcionais

- **RF01 — Cadastrar hábito:** o usuário cadastra um hábito informando nome e meta, ambos obrigatórios, para incluí-lo na lista da sessão atual.
- **RF02 — Listar hábitos:** o usuário consulta a lista de hábitos cadastrados, com o nome e a meta de cada um. Quando não há cadastros, o aplicativo exibe “Nenhum hábito cadastrado.”.
- **RF03 — Consultar detalhes:** o usuário seleciona um hábito da lista para consultar seu nome e sua meta na tela de detalhes.
- **RF04 — Excluir hábito:** o usuário exclui um hábito pela tela de detalhes, removendo-o da lista da sessão atual e retornando à tela de hábitos.
- **RF05 — Consultar resumo:** o usuário consulta, na aba Resumo, o total de hábitos cadastrados na sessão atual, atualizado após cadastros e exclusões.

### Requisitos não funcionais

- **RNF01 — Funcionamento sem internet:** com o aplicativo instalado e aberto, os cinco requisitos funcionais devem funcionar com Wi-Fi e dados móveis desligados. **Verificação:** cadastrar dois hábitos, consultar a lista e os detalhes, excluir um hábito e conferir o total de um hábito no resumo, sem conectar o dispositivo à internet.
- **RNF02 — Conservação do estado durante a navegação:** durante a mesma execução do aplicativo, alternar dez vezes entre as abas Hábitos, Resumo e Receitas deve preservar 100% dos hábitos cadastrados e seus respectivos nomes e metas. **Verificação:** cadastrar três hábitos, realizar as alternâncias e conferir os três registros e o total no resumo. Este requisito não exige conservação após encerrar o aplicativo.
- **RNF03 — Acessibilidade dos campos do formulário:** os dois campos do cadastro devem apresentar rótulos textuais visíveis, “Nome do hábito” e “Meta”, inclusive quando preenchidos, sem depender apenas de ícones ou cores para identificar sua finalidade. **Verificação:** abrir o cadastro, preencher os dois campos e conferir a identificação textual de ambos antes de salvar.

Os critérios dos requisitos não funcionais descrevem como verificar a entrega; não representam resultados de testes executados neste documento.

## Parte 2 — Mapeamento dos requisitos funcionais

Os caminhos abaixo são relativos à pasta `atividades/check-2`, que contém o arquivo `pubspec.yaml`. Todos os arquivos citados existem na versão analisada.

| RF | Interface | Domínio | Dados |
| --- | --- | --- | --- |
| RF01 — Cadastrar hábito | `lib/tela_novo_habito.dart`: formulário, mensagens de validação e método `_salvar()`. | `lib/habito.dart`: modelo `Habito`, com nome e meta; `lib/habitos_store.dart`: método `adicionar()`, que atualiza o estado e notifica os observadores. | `lib/habitos_store.dart`: lista `_habitos` e operação `_habitos.add(habito)`, que armazenam o cadastro em memória. |
| RF02 — Listar hábitos | `lib/tela_habitos.dart`: leitura do estado com `context.watch`, apresentação por `ListView.builder` e mensagem de lista vazia. | `lib/habitos_store.dart`: getter `habitos`, que disponibiliza uma lista não modificável; `lib/habito.dart`: nome e meta de cada hábito. | `lib/habitos_store.dart`: lista `_habitos`, fonte dos registros disponibilizados pelo getter. |
| RF03 — Consultar detalhes | `lib/tela_habitos.dart`: toque no item e abertura da tela; `lib/tela_detalhe_habito.dart`: apresentação do nome e da meta. | `lib/habito.dart`: objeto `Habito` selecionado, recebido pela tela de detalhes. | |
| RF04 — Excluir hábito | `lib/tela_detalhe_habito.dart`: botão “Excluir”, chamada de `remover()` e retorno à lista. | `lib/habitos_store.dart`: método `remover()`, que notifica os observadores quando a remoção acontece. | `lib/habitos_store.dart`: operação `_habitos.remove(habito)`, que remove o registro da memória. |
| RF05 — Consultar resumo | `lib/tela_resumo.dart`: apresentação do total e escolha entre o texto no singular ou no plural. | `lib/habitos_store.dart`: getter `habitos` e notificações após alterações, utilizados pelo resumo. Atualmente, a contagem `.length` é feita em `lib/tela_resumo.dart`. | `lib/habitos_store.dart`: lista `_habitos`, que fornece os registros usados na contagem. |

**Observações sobre a arquitetura atual:**

- O projeto ainda concentra responsabilidades de domínio e dados em `lib/habitos_store.dart`. Por isso, o mesmo arquivo aparece nas duas colunas. O armazenamento é somente em memória e não mantém os cadastros após encerrar o aplicativo.
- A célula de dados do RF03 está vazia porque a tela recebe o objeto já selecionado na lista. Consultar seus detalhes não faz uma nova leitura do armazenamento nem modifica os dados.
- A regra de obrigatoriedade de nome e meta está atualmente nos validadores de `lib/tela_novo_habito.dart`. Na separação em camadas proposta pelo roteiro, essa regra deve ficar no domínio, mantendo a apresentação dos erros na interface. Da mesma forma, o cálculo do total deve sair de `lib/tela_resumo.dart` e ficar no domínio.
- O mapeamento descreve os arquivos atuais, sem pressupor pastas `ui/`, `dominio/` ou `dados/` que ainda não existem. Cada requisito funcional envolve pelo menos interface e domínio.
