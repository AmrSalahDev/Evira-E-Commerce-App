import 'package:evira_e_commerce/features/notification/domain/enitites/notification_entity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationUtils {
  static Map<String, List<NotificationEntity>> groupNotificationsByDate(
    List<NotificationEntity> notifications,
  ) {
    final Map<String, List<NotificationEntity>> grouped = {};

    for (final notification in notifications) {
      final date = notification.date;
      final now = DateTime.now();
      String label;

      if (DateUtils.isSameDay(date, now)) {
        label = "Today";
      } else if (DateUtils.isSameDay(
        date,
        now.subtract(const Duration(days: 1)),
      )) {
        label = "Yesterday";
      } else {
        label = DateFormat(
          'MMMM d, yyyy',
        ).format(date); // e.g. December 22, 2024
      }

      grouped.putIfAbsent(label, () => []);
      grouped[label]!.add(notification);
    }

    // Sort by date (most recent first)
    final sortedKeys = grouped.keys.toList()
      ..sort((a, b) {
        DateTime parse(String label) {
          if (label == "Today") return DateTime.now();
          if (label == "Yesterday") {
            return DateTime.now().subtract(const Duration(days: 1));
          }
          return DateFormat('MMMM d, yyyy').parse(label);
        }

        return parse(b).compareTo(parse(a));
      });

    return {for (var key in sortedKeys) key: grouped[key]!};
  }
}
