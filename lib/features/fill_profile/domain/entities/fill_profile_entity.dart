class FillProfileEntity {
  final String fullname;
  final String nickname;
  final String dateOfBirth;
  final String anotherEmail;
  final String phone;
  final String gender;
  final String profileImage;

  FillProfileEntity({
    required this.fullname,
    required this.nickname,
    required this.dateOfBirth,
    required this.anotherEmail,
    required this.phone,
    required this.gender,
    required this.profileImage,
  });

  FillProfileEntity copyWith({
    String? fullname,
    String? nickname,
    String? dateOfBirth,
    String? anotherEmail,
    String? phone,
    String? gender,
    String? profileImage,
  }) {
    return FillProfileEntity(
      fullname: fullname ?? this.fullname,
      nickname: nickname ?? this.nickname,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      anotherEmail: anotherEmail ?? this.anotherEmail,
      phone: phone ?? this.phone,
      gender: gender ?? this.gender,
      profileImage: profileImage ?? this.profileImage,
    );
  }
}
