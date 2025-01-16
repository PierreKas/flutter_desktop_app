class User {
  String fullName;
  String phoneNumber;
  String email;
  String address;
  String password;
  String userStatus;

  User({
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    required this.address,
    required this.password,
    this.userStatus = 'NON AUTORISE',
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      fullName: json['full_name'],
      phoneNumber: json['phone_number'],
      email: json['email'],
      address: json['address'],
      password: json['password'],
      userStatus: json['user_status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'full_name': fullName,
      'phone_number': phoneNumber,
      'email': email,
      'address': address,
      'password': password,
      'user_status': userStatus,
    };
  }
}
