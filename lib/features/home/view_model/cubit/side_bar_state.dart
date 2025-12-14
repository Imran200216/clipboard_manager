part of 'side_bar_cubit.dart';

sealed class SideBarState extends Equatable {
  const SideBarState();
}

final class SideBarInitial extends SideBarState {
  @override
  List<Object> get props => [];
}

// New state
final class SideBarChanged extends SideBarState {
  final int selectedIndex;

  const SideBarChanged({required this.selectedIndex});

  @override
  List<Object> get props => [selectedIndex];
}
