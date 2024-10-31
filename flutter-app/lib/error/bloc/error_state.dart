part of 'error_bloc.dart';

final class ErrorState with FormzMixin {
  final FormzSubmissionStatus status;
  final SentryUserFeedbackCommentsInput commentsInput;
  final SentryUserFeedbackEmailInput emailInput;
  final SentryUserFeedbackNameInput nameInput;

  const ErrorState({
    this.status = FormzSubmissionStatus.initial,
    this.commentsInput = const SentryUserFeedbackCommentsInput.pure(),
    this.emailInput = const SentryUserFeedbackEmailInput.pure(),
    this.nameInput = const SentryUserFeedbackNameInput.pure(),
  });

  ErrorState copyWith({
    FormzSubmissionStatus? status,
    SentryUserFeedbackCommentsInput? commentsInput,
    SentryUserFeedbackEmailInput? emailInput,
    SentryUserFeedbackNameInput? nameInput,
  }) {
    return ErrorState(
      status: status ?? this.status,
      commentsInput: commentsInput ?? this.commentsInput,
      emailInput: emailInput ?? this.emailInput,
      nameInput: nameInput ?? this.nameInput,
    );
  }

  @override
  List<FormzInput> get inputs => [commentsInput, emailInput, nameInput];
}
