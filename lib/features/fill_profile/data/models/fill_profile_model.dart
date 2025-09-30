import 'package:evira_e_commerce/features/fill_profile/domain/entities/fill_profile_entity.dart';

class FillProfileModel extends FillProfileEntity {
  FillProfileModel({
    required super.uid,
    required super.fullname,
    required super.nickname,
    required super.dateOfBirth,
    required super.anotherEmail,
    required super.phone,
    required super.gender,
    required super.profileImage,
  });

  factory FillProfileModel.fromMap(Map<String, dynamic> map) {
    return FillProfileModel(
      uid: map['uid'] ?? '',
      fullname: map['fullname'] ?? '',
      nickname: map['nickname'] ?? '',
      dateOfBirth: map['dateOfBirth'] ?? '',
      anotherEmail: map['anotherEmail'] ?? '',
      phone: map['phone'] ?? '',
      gender: map['gender'] ?? '',
      profileImage: map['profileImage'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "fullname": fullname,
      "nickname": nickname,
      "dateOfBirth": dateOfBirth,
      "anotherEmail": anotherEmail,
      "phone": phone,
      "gender": gender,
      "profileImage": profileImage,
    };
  }

  factory FillProfileModel.fromEntity(FillProfileEntity entity) =>
      FillProfileModel(
        uid: entity.uid,
        fullname: entity.fullname,
        nickname: entity.nickname,
        dateOfBirth: entity.dateOfBirth,
        anotherEmail: entity.anotherEmail,
        phone: entity.phone,
        gender: entity.gender,
        profileImage: entity.profileImage,
      );
}
