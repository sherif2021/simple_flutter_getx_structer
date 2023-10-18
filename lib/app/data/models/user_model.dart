import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String name;
  final String phone;
  final String countryCode;
  final String email;
  final String? token;
  final DateTime? tokenExpiry;

  const UserModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.countryCode,
    required this.email,
    required this.token,
    required this.tokenExpiry,
  });

  @override
  String toString() {
    return 'UserModel{ id: $id, name: $name, phone: $phone, countryCode: $countryCode, email: $email, token: $token, tokenExpiry: $tokenExpiry,}';
  }

  String get fullPhoneNumber => '$countryCode$phone';

  UserModel copyWith({
    String? id,
    String? name,
    String? phone,
    String? countryCode,
    String? email,
    String? token,
    DateTime? tokenExpiry,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      countryCode: countryCode ?? this.countryCode,
      email: email ?? this.email,
      token: token ?? this.token,
      tokenExpiry: tokenExpiry ?? this.tokenExpiry,
      phone: phone ?? this.phone,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'country_code': countryCode,
      'email': email,
      'token': token,
      'token_expiry': tokenExpiry.toString(),
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      name: map['name'] as String,
      countryCode: map['country_code'] as String,
      email: map['email'] as String,
      token: map['token'] as String?,
      phone: map['phone'] as String,
      tokenExpiry: map['token_expiry'] != null
          ? DateTime.parse(map['token_expiry'] as String)
          : null,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        countryCode,
        email,
        token,
        tokenExpiry,
      ];
}
