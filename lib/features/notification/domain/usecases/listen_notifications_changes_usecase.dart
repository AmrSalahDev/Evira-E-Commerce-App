import 'package:evira_e_commerce/features/notification/domain/repo/notification_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class ListenNotificationsChangesUsecase {
  final NotificationRepo repo;
  ListenNotificationsChangesUsecase(this.repo);
  Stream<void> call() => repo.onNotificationsChanged();
}
