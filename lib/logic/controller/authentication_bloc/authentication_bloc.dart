import 'dart:async';


import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:pedantic/pedantic.dart';

import 'package:qmt_manager/logic/controller/authentication_bloc/auth_repository/setup.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthBloc extends HydratedBloc<AuthEvent, AuthState> {
  AuthBloc(
      {required AuthRepository authRepository})
      : _authenticationRepository = authRepository,
        super(
          authRepository.currentUser.isNotEmpty
              ? AuthState.authenticated(authRepository.currentUser)
              : const AuthState.unauthenticated(),
        ) {
    on<AuthUserChanged>(_onUserChanged);
    on<AuthLogoutRequested>(_onLogoutRequested);
    _userSubscription = _authenticationRepository.user.listen(
      (user) => add(AuthUserChanged(user)),
    );
  }

  final AuthRepository _authenticationRepository;
  late final StreamSubscription<User> _userSubscription;


  bool get isSignedIn => state.status == AuthenticationStatus.authenticated;
  bool get isNotSignedIn => !isSignedIn;

  bool get isLogged => isSignedIn;
  bool get isNotLogged => !isLogged;

  void _onUserChanged(
      AuthUserChanged event, Emitter<AuthState> emit) {
    emit(
      event.user.isNotEmpty
          ? AuthState.authenticated(event.user)
          : const AuthState.unauthenticated(),
    );
  }

  void updateUser(User user) {
    add(AuthUserChanged(user));
  }

  void _onLogoutRequested(
      AuthLogoutRequested event, Emitter<AuthState> emit) {
    unawaited(_authenticationRepository.logOut());
  }

  void logout(){
    add(AuthLogoutRequested());
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }

  @override
  AuthState? fromJson(Map<String, dynamic> json)
    => AuthState.authenticated(User.fromMap(json));


  @override
  Map<String, dynamic>? toJson(AuthState state) => state.user.toMap();
}
