
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
//import 'package:exploress/data/app_bloc/authentication_bloc/auth_repository/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'package:qmt_manager/logic/controller/authentication_bloc/auth_repository/setup.dart';

import 'package:qmt_manager/logic/controller/login_bloc/login_models.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authenticationRepository)
      : /*assert(_authenticationRepository != null),*/
        super(const LoginState());

  /// [AuthenticationRepository]
  final AuthenticationRepository _authenticationRepository;

  /// [employeeIDChanged]
  void employeeIDChanged(String value) {
    final employeeID = EmployeeID.dirty(value);
    emit(state.copyWith(
      employeeID: employeeID,
      status: Formz.validate([employeeID, state.email, state.password]),
    ));
  }

  /// [emailChanged]
  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([email, state.employeeID, state.password]),
    ));
  }
  /// [passwordChanged]
  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([state.email, state.employeeID, password]),
    ));
  }

  /// [logInWithCredentials]

  Future<void> logInWithCredentials() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _authenticationRepository.logInWithEmailAndPassword(
        employeeID: state.employeeID.value,
        email: state.email.value,
        password: state.password.value,
      );
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on Exception {
      if (kDebugMode) {
        print("Exception : logInWithCredentials() => $Exception  [login_cubit.dart:L52]");
      }
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

  /// [logInWithGoogle]

  Future<void> logInWithGoogle() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _authenticationRepository.logInWithGoogle();
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on Exception {
      if (kDebugMode) {
        print("Exception : logInWithGoogle() => $Exception [login_cubit.dart:L67]");
        print("Exception +++ LOGIN FAILED  +++");
      }
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    } on NoSuchMethodError {
      emit(state.copyWith(status: FormzStatus.pure));
    }
  }
}
