import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class User {
  final UserInformation user;
  final String token;
  final String role;

  User({required this.user, required this.token, required this.role});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        role: json['role'],
        token: json['token'],
        user: UserInformation.fromJson(json['user'])
    );
  }
}

@JsonSerializable()
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

  factory UserInformation.fromJson(Map<String, dynamic> json) {
    return UserInformation(
        userId: json['userId'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        phoneNumber: json['phoneNumber'],
        citizenIdentity: json['citizenIdentity'],
        dateOfBirth: json['dateOfBirth']
    );
  }
}
