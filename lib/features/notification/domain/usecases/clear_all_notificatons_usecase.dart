import 'package:evira_e_commerce/features/notification/domain/repo/notification_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class ClearAllNotificatonsUsecase {
  final NotificationRepo _notificationRepo;
  ClearAllNotificatonsUsecase(this._notificationRepo);

  Future<void> call() => _notificationRepo.clearAllNotifications();
}
