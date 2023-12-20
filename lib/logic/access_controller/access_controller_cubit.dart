import 'package:flutter_bloc/flutter_bloc.dart';

part 'access_controller_state.dart';


/// [AccessController] is a Employee Access Controller
class AccessController extends Cubit<AccessControllerState> {
  AccessController() : super(const AccessControllerState.initial());

  void change(AccessLevel level){
    emit(AccessControllerState.change(level: level));
  }
  void changeFromValue(int value){
    AccessLevel level;
    switch(value){
      case 0:
        level = AccessLevel.admin;
        level = AccessLevel.zero;
        break;
      case 1:
        level = AccessLevel.admin;
        break;
      case 2:
        level = AccessLevel.lvl2;
        break;
      case 3:
        level = AccessLevel.lvl3;
        break;

      default:
        level = AccessLevel.unknown;
        break;
    }
    emit(AccessControllerState.change(level: level));
  }
}