part of 'access_controller_cubit.dart';


enum AccessLevel {admin, lvl3, lvl2, lvl1, zero, unknown}

class AccessControllerState {
  final AccessLevel level;

  const AccessControllerState._(this.level);
  const AccessControllerState.initial() : this._(AccessLevel.unknown);
  const AccessControllerState.change({required AccessLevel level}) : this._(level);
}


