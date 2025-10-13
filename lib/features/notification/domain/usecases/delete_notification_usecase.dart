import 'package:evira_e_commerce/features/notification/domain/repo/notification_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteNotificationUsecase {
  final NotificationRepo notificationRepo;
  DeleteNotificationUsecase({required this.notificationRepo});

  Future<void> call(int id) => notificationRepo.deleteNotification(id);
}
