import 'package:evira_e_commerce/features/notification/domain/enitites/notification_entity.dart';

class NotificationModel extends NotificationEntity {
  NotificationModel({
    super.id,
    required super.title,
    required super.message,
    required super.icon,
    required super.date,
    super.isSeen,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      title: json['title'] ?? '',
      message: json['message'] ?? '',
      icon: json['icon'],
      date: DateTime.parse(json['date']),
      isSeen: json['is_seen'] ?? false,
    );
  }

  Map<String, dynamic> toJson(String userId) => {
    'user_id': userId,
    'title': title,
    'message': message,
    'icon': icon,
    'is_seen': isSeen,
  };
}
