import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoadingIndicator<B extends BlocBase<S>, S> extends StatelessWidget {
  const LoadingIndicator({super.key, required this.isSubmitting});

  final bool isSubmitting; // Selector function to determine loading state

  @override
  Widget build(BuildContext context) {
    if (isSubmitting) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return const SizedBox.shrink();
    }
  }
}
