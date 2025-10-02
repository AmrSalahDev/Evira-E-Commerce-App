import 'package:evira_e_commerce/features/fill_profile/domain/entities/fill_profile_entity.dart';

class FillProfileModel extends FillProfileEntity {
  FillProfileModel({
    required super.fullname,
    required super.nickname,
    required super.dateOfBirth,
    required super.anotherEmail,
    required super.phone,
    required super.gender,
    required super.profileImage,
  });

  /// Convert Entity -> JSON (for Supabase `data`)
  Map<String, dynamic> toJson() {
    return {
      "fullname": fullname,
      "nickname": nickname,
      "dateOfBirth": dateOfBirth,
      "anotherEmail": anotherEmail,
      "phone": phone,
      "gender": gender,
      "profileImage": profileImage,
    };
  }

  /// Convert JSON -> Entity (from Supabase `user_metadata`)
  factory FillProfileModel.fromJson(Map<String, dynamic> json) {
    return FillProfileModel(
      fullname: json["fullname"] ?? "",
      nickname: json["nickname"] ?? "",
      dateOfBirth: json["dateOfBirth"] ?? "",
      anotherEmail: json["anotherEmail"] ?? "",
      phone: json["phone"] ?? "",
      gender: json["gender"] ?? "",
      profileImage: json["profileImage"] ?? "",
    );
  }
}
