import 'package:evira_e_commerce/features/home/domain/entities/home_app_bar_entity.dart';
import 'package:evira_e_commerce/features/home/domain/repos/home_app_bar_repo.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton(as: HomeAppBarRepo)
class HomeAppBarRepoImpl extends HomeAppBarRepo {
  @override
  HomeAppBarEntity getUserInfo() {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;

    return HomeAppBarEntity(
      name: user?.userMetadata?['fullname'],
      imageUrl: user?.userMetadata?['profileImage'],
    );
  }
}
