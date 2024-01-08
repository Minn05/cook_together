// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/domain/blocs/blocs.dart';
import 'package:recipes/ui/helpers/helpers.dart';
import 'package:recipes/ui/screens/login/login_page.dart';
import 'package:recipes/ui/themes/colors_theme.dart';
import 'package:recipes/ui/widgets/widgets.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late TextEditingController fullNameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController ageController;
  late TextEditingController genderController;
  late TextEditingController heightController;
  late TextEditingController weightController;

  final _keyForm = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    fullNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    ageController = TextEditingController();
    genderController = TextEditingController();
    heightController = TextEditingController();
    weightController = TextEditingController();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    ageController.dispose();
    genderController.dispose();
    heightController.dispose();
    weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final userBloc = BlocProvider.of<UserBloc>(context);

    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is LoadingUserState) {
          modalLoading(context, 'Vui lòng đợi...');
        } else if (state is SuccessUserState) {
          Navigator.pop(context);
          modalSuccess(context, 'Tài khoản đã được đăng ký',
              onPressed: () => Navigator.pushAndRemoveUntil(context,
                  routeSlide(page: const LoginPage()), (route) => false));
        } else if (state is FailureUserState) {
          Navigator.pop(context);
          errorMessageSnack(context, state.error);
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: ColorsCustom.primary,
          title: const Text('Đăng ký'),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _keyForm,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 5.5,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          ColorsCustom.primary,
                          ColorsCustom.primary.withOpacity(0.2),
                        ],
                      ),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(200),
                      ),
                    ),
                    child: const Column(
                      children: [
                        Image(
                          image: AssetImage('assets/asset/images/firstUI.png'),
                          height: 140,
                        ),
                      ],
                    ),
                  ),
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 30,
                        bottom: 10,
                      ),
                      child: Text(
                        'Đăng ký',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                    ),
                  ),

                  //Họ và tên
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: TextFieldCustom(
                      controller: fullNameController,
                      hintText: 'Họ và tên',
                      isPassword: false,
                      validator: fullNameVaidator,
                    ),
                  ),

                  //Email
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: TextFieldCustom(
                      controller: emailController,
                      hintText: 'Địa chí email',
                      isPassword: false,
                      validator: validatedEmail,
                    ),
                  ),
                  //Password
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: TextFieldCustom(
                      controller: passwordController,
                      hintText: 'Mật khẩu',
                      isPassword: false,
                      validator: passwordValidator,
                    ),
                  ),
                  //Age and Gender
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.42,
                          child: TextFieldCustom(
                            controller: ageController,
                            hintText: 'Ngày sinh',
                            isPassword: false,
                            validator: ageVaidator,
                            suffixIcon: IconButton(
                              icon: Icon(
                                Icons.calendar_today_outlined,
                                color: ColorsCustom.primary.withOpacity(0.4),
                              ),
                              onPressed: () async {
                                DateTime? pickTime = await showDatePicker(
                                    context: context,
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime(2050),
                                    initialDate: DateTime.now());
                                if (pickTime != null) {
                                  setState(() {
                                    ageController.text =
                                        DateFormat("dd/MM/yyyy")
                                            .format(pickTime);
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        // Gender
                      ],
                    ),
                  ),

                  //Height and Weight
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.42,
                          child: TextFieldCustom(
                            controller: heightController,
                            hintText: 'Chiều cao',
                            isPassword: false,
                            validator: heightVaidator,
                          ),
                        ),
                        const SizedBox(width: 10),
                        //Weight

                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.42,
                          child: TextFieldCustom(
                            controller: weightController,
                            hintText: 'Cân nặng',
                            isPassword: false,
                            validator: weightVaidator,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20.0),
                  //Register button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 100),
                    child: Btn(
                        text: 'Đăng ký',
                        width: size.width,
                        onPressed: () {
                          if (_keyForm.currentState!.validate()) {
                            userBloc.add(
                              OnRegisterUserEvent(
                                fullNameController.text.trim(),
                                emailController.text.trim(),
                                passwordController.text.trim(),
                                ageController.text.trim(),
                                heightController.text.trim(),
                                weightController.text.trim(),
                              ),
                            );
                          }
                        }),
                  ),

                  //Loginpage
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Bạn chưa đã có tài khoản? ',
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 16,
                              color: ColorsCustom.secondary),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.push(
                              context, routeSlide(page: const LoginPage())),
                          child: const Text(
                            'Đăng nhập ',
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 16,
                                color: Color(0xff62A2FD)),
                          ),
                        ),
                        const Text(
                          'tại đây',
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 16,
                              color: ColorsCustom.secondary),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
