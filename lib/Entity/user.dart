import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final UserInformation user;
  final String token;
  final String role;

  User({required this.user, required this.token, required this.role});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class UserInformation {
  final int userId;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String citizenIdentity;
  final DateTime dateOfBirth;

  UserInformation({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.citizenIdentity,
    required this.dateOfBirth,
  });

  factory UserInformation.fromJson(Map<String, dynamic> json) =>
      _$UserInformationFromJson(json);

  Map<String, dynamic> toJson() => _$UserInformationToJson(this);
}
