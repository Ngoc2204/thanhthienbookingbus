enum UserRole { customer, staff, admin }

class User {
  final String id;          // Có thể là email hoặc SĐT hoặc auto-gen
  final String name;
  final String email;
  final String phone;
  final String password;
  final UserRole role;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    this.role = UserRole.customer,
  });

}
