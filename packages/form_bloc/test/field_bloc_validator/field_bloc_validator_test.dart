import 'package:form_bloc/form_bloc.dart';
import 'package:test/test.dart';

void main() {
  group('FieldBlocValidator', () {
    group('required:', () {
      group('not valid:', () {
        test('null', () {
          expect(
            // FieldBlocValidators.required(null),
            FieldBlocValidators.required<dynamic>().validator(FieldBlocValidators.required<dynamic>(), null),
            FieldBlocValidatorsErrors.required,
          );
        });

        test('false', () {
          expect(
            // FieldBlocValidators.required(false),
            FieldBlocValidators.required<bool>().validator(FieldBlocValidators.required<bool>(), false),
            FieldBlocValidatorsErrors.required,
          );
        });

        test('empty String', () {
          expect(
            // FieldBlocValidators.required(''),
            FieldBlocValidators.required<String>().validator(FieldBlocValidators.required<String>(), ''),
            FieldBlocValidatorsErrors.required,
          );
        });

        test('empty List', () {
          expect(
            // FieldBlocValidators.required(<dynamic>[]),
            FieldBlocValidators.required<dynamic>().validator(FieldBlocValidators.required<dynamic>(), <dynamic>[]),
            FieldBlocValidatorsErrors.required,
          );
        });

        test('empty Map', () {
          expect(
            // FieldBlocValidators.required(<dynamic, dynamic>{}),
            FieldBlocValidators.required<dynamic>().validator(FieldBlocValidators.required<dynamic>(), <dynamic, dynamic>{}),
            FieldBlocValidatorsErrors.required,
          );
        });
      });

      group('valid:', () {
        test('Object', () {
          expect(
            // FieldBlocValidators.required(Object()),
            FieldBlocValidators.required<dynamic>().validator(FieldBlocValidators.required<dynamic>(), Object()),
            isNull,
          );
        });

        test('true', () {
          expect(
            // FieldBlocValidators.required(true),
            FieldBlocValidators.required<dynamic>().validator(FieldBlocValidators.required<dynamic>(), true),
            isNull,
          );
        });

        test('not empty String', () {
          expect(
            // FieldBlocValidators.required(' '),
            FieldBlocValidators.required<dynamic>().validator(FieldBlocValidators.required<dynamic>(), ' '),
            isNull,
          );
        });

        test('not empty List', () {
          expect(
            // FieldBlocValidators.required(<dynamic>[1]),
            FieldBlocValidators.required<dynamic>().validator(FieldBlocValidators.required<dynamic>(), <dynamic>[1]),
            isNull,
          );
        });

        test('not empty Map', () {
          expect(
            // FieldBlocValidators.required(<dynamic, dynamic>{1: 1}),
            FieldBlocValidators.required<dynamic>().validator(FieldBlocValidators.required<dynamic>(), <dynamic, dynamic>{1: 1}),
            isNull,
          );
        });
      });
    });

    group('email:', () {
      group('not valid:', () {
        var emails = <String?>[
          ' ',
          'example',
          'example@',
          'example@domain',
          'example@domain.',
          'example@domain.com ',
        ];

        for (var email in emails) {
          test('${email == null ? null : '"$email"'} ', () {
            expect(
              FieldBlocValidators.email(), // (email)
              FieldBlocValidatorsErrors.email,
            );
          });
        }
      });

      group('valid:', () {
        var emails = [
          null,
          '',
          'example@domain.c',
          'example@domain.com',
        ];

        for (var email in emails) {
          test('${email == null ? null : '"$email"'} ', () {
            expect(
              FieldBlocValidators.email(), // (email)
              isNull,
            );
          });
        }
      });
    });

    group('passwordMin6Chars:', () {
      group('not valid:', () {
        var passwords = <String?>[
          '1',
          '12345',
        ];

        for (var password in passwords) {
          test('${password == null ? null : '"$password"'} ', () {
            expect(
              FieldBlocValidators.passwordMin6Chars(), // (password)
              FieldBlocValidatorsErrors.passwordMin6Chars,
            );
          });
        }
      });

      group('valid:', () {
        var passwords = [
          null,
          '',
          '123456',
          '1234567',
        ];

        for (var password in passwords) {
          test('${password == null ? null : '"$password"'} ', () {
            expect(
              FieldBlocValidators.passwordMin6Chars(), // (password)
              isNull,
            );
          });
        }
      });
    });

    group('confirmPassword:', () {
      group('not valid:', () {
        test('not equals', () {
          expect(
            FieldBlocValidators.confirmPassword(
              TextFieldBloc<Object>(initialValue: ''),
            ), // (' ')
            FieldBlocValidatorsErrors.confirmPassword,
          );
          expect(
            FieldBlocValidators.confirmPassword(
              TextFieldBloc<Object>(initialValue: '123'),
            ), // (' '),
            FieldBlocValidatorsErrors.confirmPassword,
          );
          expect(
            FieldBlocValidators.confirmPassword(
              TextFieldBloc<Object>(initialValue: ''),
            ), //  ('123'),
            FieldBlocValidatorsErrors.confirmPassword,
          );
        });
      });

      group('valid:', () {
        test('empty String', () {
          expect(
            FieldBlocValidators.confirmPassword(
              TextFieldBloc<Object>(initialValue: '123'),
            ), // (''),
            isNull,
          );
        });

        test('null', () {
          expect(
            FieldBlocValidators.confirmPassword(
              TextFieldBloc<Object>(initialValue: ''),
            ), // (null),
            isNull,
          );
        });

        test('equals', () {
          expect(
            FieldBlocValidators.confirmPassword(
              TextFieldBloc<Object>(initialValue: '123'),
            ), // ('123'),
            isNull,
          );
        });
      });
    });
  });
}
