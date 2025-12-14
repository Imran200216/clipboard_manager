import 'package:clipboard_manager/features/home/home.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

void initHomeInjection() {
  // Side Bar Cubit
  getIt.registerFactory<SideBarCubit>(() => SideBarCubit());
}
