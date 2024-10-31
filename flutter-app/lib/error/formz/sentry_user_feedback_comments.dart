import 'package:formz/formz.dart';
import 'package:lumpikometr/common/common.dart';

final class SentryUserFeedbackCommentsInput
    extends FormzInput<String, UndefinedErrorEnum> {
  const SentryUserFeedbackCommentsInput.pure() : super.pure('');

  const SentryUserFeedbackCommentsInput.dirty([super.value = ''])
      : super.dirty();

  @override
  UndefinedErrorEnum? validator(String value) {
    return null;
  }
}
