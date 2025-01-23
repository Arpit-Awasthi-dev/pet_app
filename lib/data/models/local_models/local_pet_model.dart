import 'package:pet_app/core/db/tables/adopted_pets_table.dart';

class LocalPetModel {
  final int id;
  final String category;
  final String name;
  final String age;
  final String price;
  final String image;
  bool adopted;

  LocalPetModel({
    int? id,
    required this.category,
    required this.name,
    required this.age,
    required this.price,
    required this.image,
    required this.adopted,
  }) : id = id ?? -1;

  Map<String, dynamic> toJson() => {
        PetTable().columnCategory: category,
        PetTable().columnName: name,
        PetTable().columnAge: age,
        PetTable().columnPrice: price,
        PetTable().columnImage: image,
        PetTable().columnAdopted: adopted ? 1 : 0,
      };

  factory LocalPetModel.fromJson(Map<String, dynamic> json) => LocalPetModel(
        id: json[PetTable().columnID],
        category: json[PetTable().columnCategory],
        name: json[PetTable().columnName],
        age: json[PetTable().columnAge],
        price: json[PetTable().columnPrice],
        image: json[PetTable().columnImage],
        adopted: json[PetTable().columnAdopted] == 1 ? true : false,
      );
}
