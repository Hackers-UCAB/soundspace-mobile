enum UserRoles {
  guest,
  subscriber,
}

class UserRole {
  final UserRoles role;

  const UserRole({required this.role});
}
