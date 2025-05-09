import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keno_plus/features/authentication/presentation/sign_up_bloc/sign_up_bloc.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final isSubmitting = context.select(
      (SignUpBloc bloc) => bloc.state.isSubmitting,
    );
    if (isSubmitting) {
      return const CircularProgressIndicator();
    } else {
      return const SizedBox();
    }
  }
}
