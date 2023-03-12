class User {
  final String? id;
  final String? nome;
  final String? email;
  final String? cpf;
  final String? senha;

  const User({
    //O id do usuário não será obrigatório pois pode ser gerado
    //randomicamente.

    this.id,
    required this.nome,
    required this.email,
    required this.cpf,
    required this.senha,
  });
}
