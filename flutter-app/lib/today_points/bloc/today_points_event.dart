part of 'today_points_bloc.dart';

@immutable
sealed class TodayPointsEvent {}

final class TodayPointsEnteredEvent extends TodayPointsEvent {}

final class TodayPointsLoadedEvent extends TodayPointsEvent {
  final List<LumpikEntity> lumpiks;
  final List<ChoreEntity> chores;

  TodayPointsLoadedEvent({required this.lumpiks, required this.chores});
}
