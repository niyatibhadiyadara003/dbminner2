class Animalmodel {
  String name;
  String description;
  String image;

  Animalmodel({
    required this.image,
    required this.name,
    required this.description,
  });

  factory Animalmodel.frommap(Map data) {
    return Animalmodel(
        image: data['image'],
        name: data['name'],
        description: data['description']);
  }
}

class Mammalmodel {
  String id;
  String name;
  String description;
  String image;

  Mammalmodel({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
  });

  factory Mammalmodel.frommap(Map data) {
    return Mammalmodel(
        id: data['id'],
        image: data['image'],
        name: data['name'],
        description: data['description']);
  }
}
