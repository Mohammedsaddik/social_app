class UserModel {

  late String uId;
  late String name;
  late String email;
  late String phone;
  late String image;
  late String cover;
  late String bio;
  late bool isEmailVerfied;


  UserModel({
    required this.image,
    required this.cover,
    required this.bio,
    required this.uId,
    required this.name,
    required this.email,
    required this.phone,
    required this.isEmailVerfied,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    bio = json!['bio'];
    image = json['image'];
    cover = json['cover'];
    uId = json['uId'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    isEmailVerfied = json['isEmailVerfied'] ?? '';
  }

  Map<String, dynamic> toMap() {
    return {
      'cover': cover,
      'bio': bio,
      'uId': uId,
      'name': name,
      'email': email,
      'phone': phone,
      'image': image,
      'isEmailVerfied':isEmailVerfied,
    };
  }
}