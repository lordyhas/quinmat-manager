import 'dart:async';


import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pedantic/pedantic.dart';

import 'package:qmt_manager/logic/controller/authentication_bloc/auth_repository/setup.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(
      {required AuthenticationRepository authRepository})
      : _authenticationRepository = authRepository,
        super(
          authRepository.currentUser.isNotEmpty
              ? AuthenticationState.authenticated(authRepository.currentUser)
              : const AuthenticationState.unauthenticated(),
        ) {
    on<AuthenticationUserChanged>(_onUserChanged);
    on<AuthenticationLogoutRequested>(_onLogoutRequested);
    _userSubscription = _authenticationRepository.user.listen(
      (user) => add(AuthenticationUserChanged(user)),
    );
  }

  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription<User> _userSubscription;


  bool get isSignedIn => state.status == AuthenticationStatus.authenticated;
  bool get isNotSignedIn => !isSignedIn;

  void _onUserChanged(
      AuthenticationUserChanged event, Emitter<AuthenticationState> emit) {
    emit(
      event.user.isNotEmpty
          ? AuthenticationState.authenticated(event.user)
          : const AuthenticationState.unauthenticated(),
    );
  }

  void updateUser(User user) {
    add(AuthenticationUserChanged(user));
  }

  void _onLogoutRequested(
      AuthenticationLogoutRequested event, Emitter<AuthenticationState> emit) {
    unawaited(_authenticationRepository.logOut());
  }

  void logout(){
    add(AuthenticationLogoutRequested());
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
