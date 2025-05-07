import 'package:flutter_bloc/flutter_bloc.dart';

part 'log_in_event.dart';
part 'log_in_state.dart';

class LogInBloc extends Bloc<LogInEvent, LogInState> {
  LogInBloc() : super(LogInState()) {
    on<LogInEvent>((event, emit) {});
  }
}
