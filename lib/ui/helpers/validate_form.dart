import 'package:form_field_validator/form_field_validator.dart';

final validatedEmail = MultiValidator([
  RequiredValidator(errorText: 'Vui lòng nhập Email'),
  EmailValidator(errorText: 'Email không hợp lệ')
]);

final passwordValidator = MultiValidator([
  RequiredValidator(errorText: 'Vui lòng nhập mật khẩu'),
  MinLengthValidator(8, errorText: 'Mật khẩu phải có ít nhất 8 ký tự')
]);

final fullNameVaidator = MultiValidator([
  RequiredValidator(errorText: 'Vui lòng nhập họ và tên'),
]);

final ageVaidator = MultiValidator([
  RequiredValidator(errorText: 'Vui lòng nhập tuổi'),
]);

final usernameVaidator = MultiValidator([
  RequiredValidator(errorText: 'Vui lòng nhập tền người dùng'),
]);

final heightVaidator = MultiValidator([
  RequiredValidator(errorText: 'Vui lòng nhập chiều cao'),
]);

final weightVaidator = MultiValidator([
  RequiredValidator(errorText: 'Vui lòng nhập cân nặng'),
]);
