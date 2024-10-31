import 'package:formz/formz.dart';
import 'package:lumpikometr/common/common.dart';

final class SentryUserFeedbackNameInput
    extends FormzInput<String, UndefinedErrorEnum> {
  const SentryUserFeedbackNameInput.pure() : super.pure('');

  const SentryUserFeedbackNameInput.dirty([super.value = '']) : super.dirty();

  @override
  UndefinedErrorEnum? validator(String value) {
    return null;
  }
}
