class User {
  final String? createdAt;
  final String? username;
  final String? password;
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final String? email;
  final String? profileImage;
  final String? userId;

  User({
    this.createdAt,
    this.username,
    this.password,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.email,
    this.profileImage,
    this.userId,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      createdAt: json['createdAt'] as String?,
      username: json['username'] as String?,
      password: json['password'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      phoneNumber: json['phone_number'] as String?,
      email: json['email'] as String?,
      profileImage: json['profile_image'] as String?,
      userId: json['user_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'createdAt': createdAt,
      'username': username,
      'password': password,
      'first_name': firstName,
      'last_name': lastName,
      'phone_number': phoneNumber,
      'email': email,
      'profile_image': profileImage,
      'user_id': userId,
    };
  }
}
