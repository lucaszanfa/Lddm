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

Os caminhos são relativos a `atividades/pratica-3`. Todos os arquivos citados existem neste projeto.

| RF | Interface | Domínio | Dados |
| --- | --- | --- | --- |
| RF01 — Cadastrar hábito | `lib/ui/tela_novo_habito.dart`: formulário, mensagens e `_salvar()`. | `lib/dominio/habito.dart`: `campoValido()`; `lib/dominio/habitos_store.dart`: `adicionar()`, validação e atualização do estado. | `lib/dados/habitos_repositorio.dart`: `salvar()` e `carregar()`, armazenamento em memória. |
| RF02 — Listar hábitos | `lib/ui/tela_habitos.dart`: lista com nome e meta, ou mensagem de lista vazia. | `lib/dominio/habitos_store.dart`: `carregar()` e getter `habitos`, que fornece lista não modificável. | `lib/dados/habitos_repositorio.dart`: `carregar()`, que devolve uma cópia dos registros. |
| RF03 — Consultar detalhes | `lib/ui/tela_habitos.dart`: seleção; `lib/ui/tela_detalhe_habito.dart`: apresentação. | `lib/dominio/habito.dart`: objeto selecionado, com nome e meta. | |
| RF04 — Excluir hábito | `lib/ui/tela_detalhe_habito.dart`: botão Excluir e retorno após a remoção. | `lib/dominio/habitos_store.dart`: `remover()`, atualização da lista e notificação das telas. | `lib/dados/habitos_repositorio.dart`: `remover()` e `carregar()`. |
| RF05 — Consultar resumo | `lib/ui/tela_resumo.dart`: apresentação do total, no singular ou plural. | `lib/dominio/habitos_store.dart`: getter `total`, que calcula a quantidade, e notificações de alteração. | `lib/dados/habitos_repositorio.dart`: `carregar()`, origem dos registros mantidos pela loja e usados na contagem. |

A célula de dados do RF03 está vazia porque a tela recebe o objeto já selecionado; não há nova consulta nem gravação ao abrir os detalhes. No RF05, a tela consulta o estado carregado pela loja, sem fazer uma nova leitura diretamente no repositório.

O repositório mantém os dados somente em memória. O aplicativo não promete conservar os hábitos após seu encerramento. A inicialização em `lib/main.dart` injeta o repositório na loja e chama `carregar()` uma vez, fora de `build()`.