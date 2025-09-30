import 'package:evira_e_commerce/features/fill_profile/domain/entities/fill_profile_entity.dart';
import 'package:evira_e_commerce/features/fill_profile/domain/repos/fill_profile_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class FillProfileUsecase {
  final FillProfileRepo fillProfileRepo;

  FillProfileUsecase(this.fillProfileRepo);

  Future<void> call(FillProfileEntity fillProfileEntity) =>
      fillProfileRepo.fillProfile(fillProfileEntity);
}
