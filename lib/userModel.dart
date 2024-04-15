class UserModel {
  final String name;
  final String image;
  final int age;
  final List search;

//<editor-fold desc="Data Methods">
  const UserModel({
    required this.name,
    required this.image,
    required this.age,
    required this.search,
  });

  UserModel copyWith({
    String? name,
    String? image,
    int? age,
    List? search,
  }) {
    return UserModel(
      name: name ?? this.name,
      image: image ?? this.image,
      age: age ?? this.age,
      search: search ?? this.search,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'image': this.image,
      'age': this.age,
      'search': this.search,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      image: map['image'] as String,
      age: map['age'] as int,
      search: map['search'] as List,
    );
  }

//</editor-fold>
}