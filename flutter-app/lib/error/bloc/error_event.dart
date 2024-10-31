part of 'error_bloc.dart';

@immutable
sealed class ErrorEvent {}

final class SentryUserFeedbackCommentsChanged extends ErrorEvent {
  final String comments;

  SentryUserFeedbackCommentsChanged(this.comments);
}

final class OnSentryUserFeedbackCommentsUnfocused extends ErrorEvent {}

final class SentryUserFeedbackEmailChanged extends ErrorEvent {
  final String email;

  SentryUserFeedbackEmailChanged(this.email);
}

final class OnSentryUserFeedbackEmailUnfocused extends ErrorEvent {}

final class SentryUserFeedbackNameChanged extends ErrorEvent {
  final String name;

  SentryUserFeedbackNameChanged(this.name);
}

final class OnSentryUserFeedbackNameUnfocused extends ErrorEvent {}

final class SentryUserFeedbackSubmitted extends ErrorEvent {}
