import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'side_bar_state.dart';

class SideBarCubit extends Cubit<SideBarState> {
  SideBarCubit() : super(SideBarInitial());

  void changeIndex(int index) {
    emit(SideBarChanged(selectedIndex: index));
  }
}
