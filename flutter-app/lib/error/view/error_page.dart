import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:lumpikometr/error/bloc/error_bloc.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  static Route route() => MaterialPageRoute(builder: (_) => const ErrorPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => ErrorBloc(),
        child: BlocListener<ErrorBloc, ErrorState>(
          listener: (context, state) {
            if(state.status.isSuccess) {
              SystemNavigator.pop();
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Error occurred',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                Text(
                  'Please give us valuable feedback.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                const _NameInput(),
                const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                const _EmailInput(),
                const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                const _CommentsInput(),
                const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                const _SubmitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NameInput extends StatelessWidget {
  const _NameInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ErrorBloc, ErrorState>(
      buildWhen: (p, c) => p.nameInput != c.nameInput,
      builder: (BuildContext context, ErrorState state) => TextField(
        textCapitalization: TextCapitalization.words,
        key: const Key('sentry_feedback_form_name'),
        onChanged: (name) =>
            context.read<ErrorBloc>().add(SentryUserFeedbackNameChanged(name)),
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Name',
        ),
      ),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ErrorBloc, ErrorState>(
      builder: (context, state) => OutlinedButton(
        onPressed: state.status == FormzSubmissionStatus.initial
            ? () => context.read<ErrorBloc>().add(SentryUserFeedbackSubmitted())
            : null,
        child: state.status == FormzSubmissionStatus.initial
            ? const Text('Submit & Restart')
            : const Padding(
                padding: EdgeInsets.all(6.0),
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ErrorBloc, ErrorState>(
      buildWhen: (p, c) => p.emailInput.value != c.emailInput.value,
      builder: (BuildContext context, ErrorState state) => TextField(
        key: const Key('sentry_feedback_form_email'),
        onChanged: (email) => context
            .read<ErrorBloc>()
            .add(SentryUserFeedbackEmailChanged(email)),
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Email',
        ),
      ),
    );
  }
}

class _CommentsInput extends StatelessWidget {
  const _CommentsInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ErrorBloc, ErrorState>(
      buildWhen: (p, c) => p.commentsInput.value != c.commentsInput.value,
      builder: (BuildContext context, ErrorState state) => TextField(
        textCapitalization: TextCapitalization.sentences,
        key: const Key('sentry_feedback_form_comments'),
        onChanged: (comments) => context
            .read<ErrorBloc>()
            .add(SentryUserFeedbackCommentsChanged(comments)),
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Message',
        ),
        minLines: 3,
        maxLines: null,
      ),
    );
  }
}
