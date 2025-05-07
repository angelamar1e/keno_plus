// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:keno_plus/features/authentication/data/models/user_model.dart';
import 'package:keno_plus/features/authentication/domain/usecases/create_user_usecase.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final CreateUser createUser;

  SignUpBloc({required this.createUser}) : super(SignUpState()) {
    on<CreatingUser>(_onCreatingUser);
  }

  _onCreatingUser(CreatingUser event, Emitter<SignUpState> emit) async {
    emit(state.copyWith(status: SignUpStatus.loading));
    final result = await createUser(event.user);
    result.fold(
      (l) {
        emit(
          state.copyWith(
            status: SignUpStatus.failure,
            errorMessage: l.failure.toString(),
          ),
        );
      },
      (r) {
        emit(state.copyWith(status: SignUpStatus.success, user: event.user));
      },
    );
  }
}
