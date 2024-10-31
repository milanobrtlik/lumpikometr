import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:lumpikometr/tmp_repo/chore_repository.dart';
import 'package:lumpikometr/tmp_repo/lumpik_repository.dart';
import 'package:meta/meta.dart';

part 'today_points_event.dart';
part 'today_points_state.dart';

class TodayPointsBloc extends Bloc<TodayPointsEvent, TodayPointsState> {
  TodayPointsBloc({
    required this.lumpikRepository,
    required this.choreRepository,
  }) : super(TodayPointsLoadingState()) {
    on<TodayPointsEnteredEvent>(_onEntered);
  }

  final LumpikRepository lumpikRepository;
  final ChoreRepository choreRepository;

  FutureOr<void> _onEntered(
    TodayPointsEnteredEvent event,
    Emitter<TodayPointsState> emit,
  ) async {
    emit(TodayPointsLoadingState());
    final data =
        await Future.wait([lumpikRepository.getAll(), choreRepository.getAll()]);
    emit(
      TodayPointsLoadedState(
        lumpiks: data[0] as List<LumpikEntity>,
        chores: data[1] as List<ChoreEntity>,
      ),
    );
  }
}
