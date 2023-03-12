class Category {
  final String? id;
  final String? descricao;
  final String? imageURL;

  const Category(
      {
      //O id do usuário não será obrigatório pois pode ser gerado
      //randomicamente.

      required this.id,
      required this.descricao,
      required this.imageURL});
}
