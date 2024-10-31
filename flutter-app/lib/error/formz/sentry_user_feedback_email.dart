import 'package:formz/formz.dart';
import 'package:lumpikometr/common/common.dart';

final class SentryUserFeedbackEmailInput
    extends FormzInput<String, UndefinedErrorEnum> {
  const SentryUserFeedbackEmailInput.pure() : super.pure('');

  const SentryUserFeedbackEmailInput.dirty([super.value = '']) : super.dirty();

  @override
  UndefinedErrorEnum? validator(String value) {
    return null;
  }
}
