import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:recipes/domain/blocs/blocs.dart';
import 'package:recipes/ui/helpers/helpers.dart';
import 'package:recipes/ui/screens/profile/widgets/text_form_profile.dart';
import 'package:recipes/ui/themes/colors_theme.dart';
import 'package:recipes/ui/widgets/widgets.dart';

class AccountProfilePage extends StatefulWidget {
  const AccountProfilePage({Key? key}) : super(key: key);

  @override
  State<AccountProfilePage> createState() => _AccountProfilePageState();
}

class _AccountProfilePageState extends State<AccountProfilePage> {
  late TextEditingController _userController;
  late TextEditingController _emailController;
  late TextEditingController _fullNameController;
  late TextEditingController _heightController;
  late TextEditingController _weightController;
  final _keyForm = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    final userBloc = BlocProvider.of<UserBloc>(context).state;

    _userController = TextEditingController(text: userBloc.user?.username);
    _emailController = TextEditingController(text: userBloc.user?.email);
    _fullNameController = TextEditingController(text: userBloc.user?.fullname);
    _heightController =
        TextEditingController(text: userBloc.user?.height.toString());
    _weightController =
        TextEditingController(text: userBloc.user?.weight.toString());
  }

  @override
  void dispose() {
    _userController.dispose();
    _emailController.dispose();
    _fullNameController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);

    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is LoadingEditUserState) {
          modalLoading(context, 'Đang cập nhật...');
        }
        if (state is FailureUserState) {
          Navigator.pop(context);
          errorMessageSnack(context, state.error);
        }
        if (state is SuccessUserState) {
          Navigator.pop(context);
          modalSuccess(context, 'Cập nhật thành công!',
              onPressed: () => Navigator.pop(context));
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const TextCustom(text: 'Thông tin cá nhân', fontSize: 19),
          elevation: 0,
          leading: IconButton(
            highlightColor: Colors.transparent,
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: Colors.black),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  if (_keyForm.currentState!.validate()) {
                    userBloc.add(OnUpdateProfileEvent(
                        _userController.text.trim(),
                        _fullNameController.text.trim(),
                        _weightController.text.trim(),
                        _heightController.text.trim()));
                  }
                },
                child: const TextCustom(
                    text: 'Cập nhật',
                    color: ColorsCustom.primary,
                    fontSize: 14))
          ],
        ),
        body: Form(
          key: _keyForm,
          child: SafeArea(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              children: [
                const SizedBox(height: 20.0),
                TextFormProfile(
                    controller: _userController,
                    labelText: 'Tên người dùng',
                    validator: MultiValidator([])),
                const SizedBox(height: 10.0),
                TextFormProfile(
                    controller: _fullNameController,
                    labelText: 'Fullname',
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Vui lòng nhập họ và tên'),
                      MinLengthValidator(3, errorText: 'Ít nhất 5 ký tự')
                    ])),
                // const SizedBox(height: 20.0),
                // TextFormProfile(
                //   controller: _emailController,
                //   isReadOnly: true,
                //   labelText: 'Email',
                // ),
                const SizedBox(height: 20.0),
                TextFormProfile(
                    controller: _heightController,
                    labelText: 'Chiều cao của bạn',
                    validator: MultiValidator([])),
                const SizedBox(height: 20.0),
                TextFormProfile(
                    controller: _weightController,
                    labelText: 'Cân nặng của bạn',
                    validator: MultiValidator([])),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
