import 'package:evira_e_commerce/features/home/domain/entities/home_app_bar_entity.dart';
import 'package:evira_e_commerce/features/home/domain/repos/home_app_bar_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetUserInfoUsecase {
  final HomeAppBarRepo homeAppBarRepo;
  GetUserInfoUsecase(this.homeAppBarRepo);
  HomeAppBarEntity call() => homeAppBarRepo.getUserInfo();
}
