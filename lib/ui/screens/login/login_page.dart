import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/domain/blocs/blocs.dart';
import 'package:recipes/ui/helpers/helpers.dart';
import 'package:recipes/ui/screens/login/forgot_password_page.dart';
import 'package:recipes/ui/screens/login/register_page.dart';
import 'package:recipes/ui/screens/login/verify_email_page.dart';
import 'package:recipes/ui/themes/colors_theme.dart';
import 'package:recipes/ui/widgets/widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  final _keyForm = GlobalKey<FormState>();
  bool hidePassword = true;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.clear();
    emailController.dispose();
    passwordController.clear();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final userBloc = BlocProvider.of<UserBloc>(context);

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoadingAuthentication) {
          modalLoading(context, 'Vui lòng chờ...');
        } else if (state is FailureAuthentication) {
          Navigator.pop(context);

          if (state.error == 'Vui lòng kiểm tra email') {
            Navigator.push(
                context,
                routeSlide(
                    page: VerifyEmailPage(email: emailController.text.trim())));
          }

          errorMessageSnack(context, state.error);
        } else if (state is SuccessAuthentication) {
          userBloc.add(OnGetUserAuthenticationEvent());
          Navigator.pop(context);
          Navigator.pushAndRemoveUntil(context,
              routeSlide(page: const BottomNavigation()), (_) => false);
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: ColorsCustom.primary,
          title: const Text("Đăng nhập"),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _keyForm,
            child: Column(
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
                        image: AssetImage('assets/asset/images/bg.png'),
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
                      'Đăng nhập',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                  ),
                ),
                //email
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: TextFieldCustom(
                    controller: emailController,
                    hintText: 'Email',
                    isPassword: false,
                    validator: validatedEmail,
                  ),
                ),
                //password

                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: TextFieldCustom(
                    controller: passwordController,
                    hintText: 'Mật khẩu',
                    isPassword: true,
                    validator: passwordValidator,
                  ),
                ),

                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                  child: Btn(
                    text: 'Đăng nhập',
                    width: size.width,
                    onPressed: () {
                      print(emailController.text);
                      if (_keyForm.currentState!.validate()) {
                        authBloc.add(OnLoginEvent(emailController.text.trim(),
                            passwordController.text.trim()));
                      }
                    },
                  ),
                ),
                //Quên mật khẩu
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () => Navigator.push(
                          context,
                          routeSlide(page: const ForgotPasswordPage()),
                        ),
                        child: const Text(
                          'Quên mật khẩu?',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 15,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                    ],
                  ),
                ),
                //Register page
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Bạn chưa có tài khoản? Tạo tại ',
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 16,
                            color: ColorsCustom.secondary),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                            context, routeSlide(page: const RegisterPage())),
                        child: const Text(
                          'đây',
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 16,
                              color: Color(0xff62A2FD)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // ],
        ),
      ),
    );
  }
}
