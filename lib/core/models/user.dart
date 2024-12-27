class User {
  final String? password;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? gender;
  final String? image;

  User({
    this.password,
    this.email,
    this.firstName,
    this.lastName,
    this.gender,
    this.image,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      gender: json['gender'],
      image: json['image'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (password != null) data['password'] = password;
    if (email != null) data['email'] = email;
    if (firstName != null) data['firstName'] = firstName;
    if (lastName != null) data['lastName'] = lastName;
    if (gender != null) data['gender'] = gender;
    if (image != null) data['image'] = image;
    return data;
  }
}
