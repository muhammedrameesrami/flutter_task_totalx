class UserModel{
  final String id;
  final int age;
  final String name;
  final String profile;
  final int phoneNumber;
  final DateTime dateTime;

//<editor-fold desc="Data Methods">
  const UserModel({
    required this.id,
    required this.age,
    required this.name,
    required this.profile,
    required this.phoneNumber,
    required this.dateTime,
  });



  UserModel copyWith({
    String? id,
    int? age,
    String? name,
    String? profile,
    int? phoneNumber,
    DateTime? dateTime,
  }) {
    return UserModel(
      id: id ?? this.id,
      age: age ?? this.age,
      name: name ?? this.name,
      profile: profile ?? this.profile,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'age': this.age,
      'name': this.name,
      'profile': this.profile,
      'phoneNumber': this.phoneNumber,
      'dateTime': this.dateTime,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      age: map['age'] as int,
      name: map['name'] as String,
      profile: map['profile'] as String,
      phoneNumber: map['phoneNumber'] as int,
      dateTime: map['dateTime'] as DateTime,
    );
  }

//</editor-fold>
}