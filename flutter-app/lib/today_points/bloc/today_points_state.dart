part of 'today_points_bloc.dart';

@immutable
sealed class TodayPointsState {}

final class TodayPointsLoadingState extends TodayPointsState {}

final class TodayPointsLoadedState extends TodayPointsState {
  final List<LumpikEntity> lumpiks;
  final List<ChoreEntity> chores;

  TodayPointsLoadedState({required this.lumpiks, required this.chores});
}

final class TodayPointsError extends TodayPointsState {}
