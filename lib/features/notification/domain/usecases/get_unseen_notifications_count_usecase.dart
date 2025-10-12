import 'package:evira_e_commerce/features/notification/domain/repo/notification_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetUnseenNotificationsCountUseCase {
  final NotificationRepo repo;

  GetUnseenNotificationsCountUseCase(this.repo);

  Future<int> call() async {
    return await repo.getUnseenCount();
  }
}
