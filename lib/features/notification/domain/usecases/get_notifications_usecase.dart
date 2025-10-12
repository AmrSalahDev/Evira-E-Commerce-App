import 'package:evira_e_commerce/features/notification/domain/enitites/notification_entity.dart';
import 'package:evira_e_commerce/features/notification/domain/repo/notification_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetNotificationsUsecase {
  final NotificationRepo notificationRepo;
  GetNotificationsUsecase(this.notificationRepo);
  Future<List<NotificationEntity>> call() =>
      notificationRepo.getNotifications();
}
