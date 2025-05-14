// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      user: UserInformation.fromJson(json['user'] as Map<String, dynamic>),
      token: json['token'] as String,
      role: json['role'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'user': instance.user,
      'token': instance.token,
      'role': instance.role,
    };

UserInformation _$UserInformationFromJson(Map<String, dynamic> json) =>
    UserInformation(
      userId: (json['userId'] as num).toInt(),
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      phoneNumber: json['phoneNumber'] as String,
      citizenIdentity: json['citizenIdentity'] as String,
      dateOfBirth: DateTime.parse(json['dateOfBirth'] as String),
    );

Map<String, dynamic> _$UserInformationToJson(UserInformation instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'phoneNumber': instance.phoneNumber,
      'citizenIdentity': instance.citizenIdentity,
      'dateOfBirth': instance.dateOfBirth.toIso8601String(),
    };
