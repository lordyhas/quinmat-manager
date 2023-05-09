part of 'login_cubit.dart';

class LoginState extends Equatable {
  const LoginState({
    this.employeeID = const EmployeeID.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
  });

  final EmployeeID employeeID;
  final Email email;
  final Password password;
  final FormzStatus status;

  @override
  List<Object> get props => [email, password, status];

  LoginState copyWith({
    EmployeeID? employeeID,
    Email? email,
    Password? password,
    FormzStatus? status,
  }) {
    return LoginState(
      employeeID: employeeID ?? this.employeeID,
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }
}
