import 'package:form_bloc/src/blocs/field/field_bloc.dart';

class FieldBlocValidatorsErrors {
  FieldBlocValidatorsErrors._();

  static const String required = 'Required - Validator Error';

  static const String email = 'Email - Validator Error';
  static const String emailMax = 'Email Max Chars - Validator Error';
  static const String emailMin = 'Email Min Chars - Validator Error';

  static const String password = 'Password - Validator Error';
  static const String passwordMax = 'Password Max Chars - Validator Error';
  static const String passwordMin = 'Password Min Chars - Validator Error';
  static const String passwordMin6Chars = 'Password Min 6 Chars - Validator Error';

  static const String confirmPassword = 'Confirm Password - Validator Error';
}

class ConfirmPasswordValidatorWrapper<Value> extends ValidatorWrapper<Value> {
  late TextFieldBloc confirmPasswordFieldBloc;
}

class EmailValidatorWrapper<Value> extends ValidatorWrapper<Value> {
  late int max;
  late int min;
  late RegExp? regex;
}

class PasswordValidatorWrapper<Value> extends ValidatorWrapper<Value> {
  late int max;
  late int min;
  late RegExp? regex;
}

class ValidatorWrapperResults {
  final String error;
  final Map<String, String> params = Map();

  ValidatorWrapperResults(this.error);
}

class FieldBlocValidators {
  FieldBlocValidators._();

  /// Check if the [value] is is not null, not empty or false.
  ///
  /// Returns `null` if is valid.
  ///
  /// Returns [FieldBlocValidatorsErrors.required]
  /// if is not valid.
  static ValidatorWrapper<Value> required<Value>() {
    ValidatorWrapper<Value> validator = ValidatorWrapper<Value>();
    validator.validator = (ValidatorWrapper wrapper, dynamic value) {
      if (value == null || value == false || ((value is Iterable || value is String || value is Map) && value.length == 0)) {
        return FieldBlocValidatorsErrors.required;
      }
      return null;
    };
    return validator;
  }
  // static String? required(dynamic value) {
  //   if (value == null || value == false || ((value is Iterable || value is String || value is Map) && value.length == 0)) {
  //     return FieldBlocValidatorsErrors.required;
  //   }
  //   return null;
  // }

  /// Check if the [string] is an email
  /// if [string] is not null and not empty.
  ///
  /// Returns `null` if is valid.
  ///
  /// Returns [FieldBlocValidatorsErrors.email]
  /// if is not valid.
  static ValidatorWrapper<String> email({int min = 0, int max = 512, RegExp? regex = null}) {
    EmailValidatorWrapper<String> validator = EmailValidatorWrapper<String>();
    validator.validator = (ValidatorWrapper wrapper, dynamic value) {
      EmailValidatorWrapper wrapper2 = wrapper as EmailValidatorWrapper;

      if (!(value is String)) {
        return FieldBlocValidatorsErrors.email;
      }

      String? string = value as String;
      if (string == null || string.isEmpty) {
        return null;
      }
      if (string.runes.length < wrapper2.min) {
        ValidatorWrapperResults results = ValidatorWrapperResults(FieldBlocValidatorsErrors.emailMin);
        results.params['min'] = wrapper2.min.toString();
        return results;
        // return FieldBlocValidatorsErrors.emailMin;
      }
      if (string.runes.length > wrapper2.max) {
        ValidatorWrapperResults results = ValidatorWrapperResults(FieldBlocValidatorsErrors.emailMax);
        results.params['max'] = wrapper2.max.toString();
        return results;
        // return FieldBlocValidatorsErrors.emailMax;
      }

      final emailRegExp = (wrapper2.regex != null ? wrapper2.regex! : RegExp(r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$'));
      if (emailRegExp.hasMatch(string)) {
        return null;
      }

      return FieldBlocValidatorsErrors.email;
    };
    validator.min = min;
    validator.max = max;
    validator.regex = regex;
    return validator;
  }
  // static String? email(String? string) {
  //   final emailRegExp = RegExp(r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$');
  //   if (string == null || string.isEmpty || emailRegExp.hasMatch(string)) {
  //     return null;
  //   }

  //   return FieldBlocValidatorsErrors.email;
  // }

  /// Check if the [string] has min 6 chars
  /// if [string] is not null and not empty.
  ///
  /// Returns `null` if is valid.
  ///
  /// Returns [FieldBlocValidatorsErrors.passwordMin6Chars]
  /// if is not valid.
  static ValidatorWrapper<String> passwordMin6Chars() {
    return password(min: 6);
  }

  static ValidatorWrapper<String> password({int min = 0, int max = 512, RegExp? regex = null}) {
    PasswordValidatorWrapper<String> validator = PasswordValidatorWrapper<String>();
    validator.validator = (ValidatorWrapper wrapper, dynamic value) {
      PasswordValidatorWrapper wrapper2 = wrapper as PasswordValidatorWrapper;

      if (!(value is String)) {
        return FieldBlocValidatorsErrors.password;
      }
      String? string = value as String;
      if (string == null || string.isEmpty) {
        return null;
      }
      if (string.runes.length < wrapper2.min) {
        ValidatorWrapperResults results = ValidatorWrapperResults(FieldBlocValidatorsErrors.passwordMin);
        results.params['min'] = wrapper2.min.toString();
        return results;
        // return FieldBlocValidatorsErrors.passwordMin;
      }
      if (string.runes.length > wrapper2.max) {
        ValidatorWrapperResults results = ValidatorWrapperResults(FieldBlocValidatorsErrors.passwordMax);
        results.params['max'] = wrapper2.max.toString();
        return results;
        // return FieldBlocValidatorsErrors.passwordMax;
      }

      if (wrapper2.regex != null) {
        if (wrapper2.regex!.hasMatch(string)) {
          return null;
        }
      }

      return FieldBlocValidatorsErrors.password;
    };
    validator.min = min;
    validator.max = max;
    return validator;
  }
  // static String? passwordMin6Chars(String? string) {
  //   if (string == null || string.isEmpty || string.runes.length >= 6) {
  //     return null;
  //   }
  //   return FieldBlocValidatorsErrors.passwordMin6Chars;
  // }

  /// Check if the `value` of the current [TextFieldBloc] is equals
  /// to [passwordTextFieldBloc.value].
  ///
  /// Returns a [Validator] `String Function(String string)`.
  ///
  /// This validator check if the `string` is equal to the current
  /// value of the [TextFieldBloc]
  /// if [string] is not null and not empty.
  ///
  /// Returns `null` if is valid.
  ///
  /// Returns [FieldBlocValidatorsErrors.email]
  /// if is not valid.
  ///
  /// Returns [FieldBlocValidatorsErrors.passwordMin6Chars]
  /// if is not valid.

  static ValidatorWrapper<String> confirmPassword(TextFieldBloc confirmPasswordFieldBloc) {
    ConfirmPasswordValidatorWrapper<String> validator = ConfirmPasswordValidatorWrapper<String>();
    validator.validator = (ValidatorWrapper wrapper, dynamic value) {
      ConfirmPasswordValidatorWrapper wrapper2 = wrapper as ConfirmPasswordValidatorWrapper;
      String? string = value as String;
      if (value == null || string.isEmpty || wrapper.confirmPasswordFieldBloc == string) {
        return null;
      }
      return FieldBlocValidatorsErrors.confirmPassword;
    };
    validator.confirmPasswordFieldBloc = confirmPasswordFieldBloc;
    return validator;
  }
  // static Validator<String?> confirmPassword2(
  //   TextFieldBloc passwordTextFieldBloc,
  // ) {
  //   return (String? confirmPassword) {
  //     if (confirmPassword == null || confirmPassword.isEmpty || confirmPassword == passwordTextFieldBloc.value) {
  //       return null;
  //     }
  //     return FieldBlocValidatorsErrors.confirmPassword;
  //   };
  // }
}
