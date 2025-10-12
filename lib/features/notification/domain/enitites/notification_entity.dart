class NotificationEntity {
  final int id;
  final String title;
  final String message;
  final String icon;
  final DateTime date;
  final bool isSeen;

  NotificationEntity({
    this.id = 0,
    required this.title,
    required this.message,
    required this.icon,
    required this.date,
    this.isSeen = false,
  });
}
