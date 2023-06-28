part of 'login_cubit.dart';

class LoginState extends Equatable {
  const LoginState({
    this.username = const Username.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
  });

  final Username username;
  final Email email;
  final Password password;
  final FormzStatus status;

  @override
  List<Object> get props => [email, password, status];

  LoginState copyWith({
    Username? username,
    Email? email,
    Password? password,
    FormzStatus? status,
  }) {
    return LoginState(
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }
}
