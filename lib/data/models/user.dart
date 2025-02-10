class User {
  final UserInformation user;
  final String token;
  final String role;

  User({
    required this.user,
    required this.token,
    required this.role
  });
}

class UserInformation {
  final int userId;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String citizenIdentity;
  final String dateOfBirth;

  UserInformation({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.citizenIdentity,
    required this.dateOfBirth,
  });
}