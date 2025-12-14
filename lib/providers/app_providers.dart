import 'package:clipboard_manager/features/home/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

List<BlocProvider> appBlocProviders = [
  // Side Bar Cubit
  BlocProvider<SideBarCubit>(create: (context) => getIt<SideBarCubit>()),
];
