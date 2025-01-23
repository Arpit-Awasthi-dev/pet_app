class Pet {
  final int id;
  final String category;
  final String name;
  final String age;
  final String price;
  final String image;
  bool isAdopted;

  Pet({
    required this.id,
    required this.category,
    required this.name,
    required this.age,
    required this.price,
    required this.image,
    required this.isAdopted,
  });
}
