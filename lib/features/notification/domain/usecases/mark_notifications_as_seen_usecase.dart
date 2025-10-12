import 'package:evira_e_commerce/features/notification/domain/repo/notification_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class MarkNotificationsAsSeenUsecase {
  final NotificationRepo repo;

  MarkNotificationsAsSeenUsecase(this.repo);

  Future<void> call() async {
    await repo.markAllAsSeen();
  }
}
