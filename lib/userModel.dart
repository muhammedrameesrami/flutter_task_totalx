class UserModel {
  final String name;
  final String image;
  final int age;
  final List search;
  final String uid;

//<editor-fold desc="Data Methods">
  const UserModel({
    required this.name,
    required this.uid,
    required this.image,
    required this.age,
    required this.search,
  });

  UserModel copyWith({
    String? name,
    String? image,
    String ?uid,
    int? age,
    List? search,
  }) {
    return UserModel(
      name: name ?? this.name,
      uid: uid??this.uid,
      image: image ?? this.image,
      age: age ?? this.age,
      search: search ?? this.search,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'uid':this.uid,
      'image': this.image,
      'age': this.age,
      'search': this.search,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name']??'',
      image: map['image'] ??'',
      uid:map['uid']??'',
      age: map['age'] ??1,
      search: map['search']??[],
    );
  }

//</editor-fold>
}