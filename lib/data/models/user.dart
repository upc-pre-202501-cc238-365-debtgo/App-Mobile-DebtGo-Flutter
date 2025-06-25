class User {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String planType;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.planType,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      planType: json['planType'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'planType': planType,
    };
  }
}
