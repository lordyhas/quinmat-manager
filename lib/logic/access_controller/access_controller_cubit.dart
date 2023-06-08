import 'package:flutter_bloc/flutter_bloc.dart';

part 'access_controller_state.dart';


/// [AccessController] is a Employee Access Controller
class AccessController extends Cubit<AccessControllerState> {
  AccessController() : super(const AccessControllerState.initial());

  void change(AccessLevel level){
    emit(AccessControllerState.change(level: level));
  }
}