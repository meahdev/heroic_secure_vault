import 'package:flutter_bloc/flutter_bloc.dart';

class InactivityCubit extends Cubit<int> {
  InactivityCubit() : super(0);

  // Call this to notify listeners to reset the timer
  void userActivity() => emit(state+1);
}
