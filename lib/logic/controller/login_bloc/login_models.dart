
import 'package:formz/formz.dart';

enum EmployeeIDValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template email}
/// Form input for an id input.
/// {@endtemplate}
class Username extends FormzInput<String, EmployeeIDValidationError> {
  const Username.pure() : super.pure('');
  const Username.dirty([String value = '']) : super.dirty(value);

  static final RegExp _employeeIDRegExp = RegExp(
    r'^[a-zA-Z0-9-]*$',
  );

  @override
  EmployeeIDValidationError? validator(String? value) {
    return _employeeIDRegExp.hasMatch(value ?? '')
        ? null
        : EmployeeIDValidationError.invalid;
  }
}

/// Validation errors for the [Email] [FormzInput].
enum EmailValidationError {
  /// Generic invalid error.
  invalid
}


/// {@template email}
/// Form input for an email input.
/// {@endtemplate}
class Email extends FormzInput<String, EmailValidationError> {
  const Email.pure() : super.pure('');
  const Email.dirty([String value = '']) : super.dirty(value);

  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  /*@override
  EmailValidationError? validator(String? value) {
    return _emailRegExp.hasMatch(value!) ? null : EmailValidationError.invalid;
  }*/

  @override
  EmailValidationError? validator(String? value) {
    return _emailRegExp.hasMatch(value ?? '')
        ? null
        : EmailValidationError.invalid;
  }
}

/// Validation errors for the [Password] [FormzInput].
enum PasswordValidationError {
  /// Generic invalid error.
  invalid
}


class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');
  const Password.dirty([String value = '']) : super.dirty(value);

  static final _passwordRegExp = RegExp(
      //r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$'
      r'(?=.*[a-zA-Z])(?=.*\d)'

  );

  @override
  PasswordValidationError? validator(String? value) {
    return _passwordRegExp.hasMatch(value ?? '')
        ? null
        : PasswordValidationError.invalid;
  }
}

