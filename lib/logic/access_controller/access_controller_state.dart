part of 'access_controller_cubit.dart';


enum AccessLevel {admin, sudo, lvl2, lvl3, zero, unknown}

class AccessControllerState {
  final AccessLevel _level;

  const AccessControllerState._(this._level);
  const AccessControllerState.initial() : this._(AccessLevel.unknown);
  const AccessControllerState.change({required AccessLevel level}) : this._(level);


}

extension AccessLevelHelper on AccessLevel {
  int get value {
    switch(this){
      case AccessLevel.admin: return 0;
      case AccessLevel.lvl3: return 3;
      case AccessLevel.lvl2: return 2;
      case AccessLevel.sudo: return 1;
      case AccessLevel.zero: return 0;
      case AccessLevel.unknown: return -1;
    }

  }
}


