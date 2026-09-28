class Habito {
  final String nome;
  final String meta;
  const Habito({required this.nome, required this.meta});
  static bool campoValido(String? valor) =>
      valor != null && valor.trim().isNotEmpty;
}
