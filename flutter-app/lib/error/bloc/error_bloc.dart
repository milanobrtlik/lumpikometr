import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../formz/formz.dart';

part 'error_event.dart';
part 'error_state.dart';

class ErrorBloc extends Bloc<ErrorEvent, ErrorState> {
  ErrorBloc() : super(const ErrorState()) {
    on<SentryUserFeedbackSubmitted>(_onFeedbackSubmitted);
    on<SentryUserFeedbackCommentsChanged>(_onCommentsChanged);
    on<SentryUserFeedbackNameChanged>(_onNameChanged);
    on<SentryUserFeedbackEmailChanged>(_onEmailChanged);
  }

  FutureOr<void> _onFeedbackSubmitted(
    SentryUserFeedbackSubmitted event,
    Emitter<ErrorState> emit,
  ) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    final feedback = SentryUserFeedback(
      eventId: await Sentry.captureMessage('Error feedback'),
      comments: state.commentsInput.value,
      email: state.emailInput.value,
      name: state.nameInput.value,
    );
    await Sentry.captureUserFeedback(feedback);
    emit(state.copyWith(status: FormzSubmissionStatus.success));
  }

  FutureOr<void> _onNameChanged(
    SentryUserFeedbackNameChanged event,
    Emitter<ErrorState> emit,
  ) async {
    emit(state.copyWith(
      nameInput: SentryUserFeedbackNameInput.dirty(event.name),
    ));
  }

  FutureOr<void> _onCommentsChanged(
    SentryUserFeedbackCommentsChanged event,
    Emitter<ErrorState> emit,
  ) async {
    emit(state.copyWith(
      commentsInput: SentryUserFeedbackCommentsInput.dirty(event.comments),
    ));
  }

  FutureOr<void> _onEmailChanged(
    SentryUserFeedbackEmailChanged event,
    Emitter<ErrorState> emit,
  ) async {
    emit(state.copyWith(
      emailInput: SentryUserFeedbackEmailInput.dirty(event.email),
    ));
  }
}
