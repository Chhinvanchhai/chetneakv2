class Users {
  final String? id;
  final int? age;
  final bool isActive;
  final String name;
  final String? avatar;
  final String? phone;
  final String email;
  final String? docGroupId;

  Users(
      {this.id,
      this.isActive = false,
      this.age,
      this.avatar,
      required this.email,
      required this.name,
      this.phone,
      this.docGroupId});
  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
        id: json['id'],
        age: json['age'],
        email: json['email'],
        name: json['name'],
        avatar: json['avatar'],
        isActive: json['isActive'],
        docGroupId: json['docGroupId'],
        phone: json['phone']);
  }
}
