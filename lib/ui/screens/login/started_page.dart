import 'package:flutter/material.dart';
import 'package:recipes/ui/helpers/helpers.dart';
import 'package:recipes/ui/screens/login/login_page.dart';
import 'package:recipes/ui/screens/login/register_page.dart';
import 'package:recipes/ui/themes/colors_theme.dart';
import 'package:recipes/ui/themes/logo.dart';
import 'package:recipes/ui/widgets/widgets.dart';

class StartedPage extends StatelessWidget {
  const StartedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xffE7E7E7),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  height: 55,
                  width: size.width,
                  child: const Logo(),
                ),
              ),
              const SizedBox(height: 40),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                child: SizedBox(
                  width: size.width,
                  child: Image.asset('assets/asset/images/started.png'),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Cùng nhau tạo nên các món ăn thật tuyệt vời nào! ',
                  style: TextStyle(
                    letterSpacing: 2.0,
                    color: ColorsCustom.secondary,
                    fontWeight: FontWeight.w600,
                    fontSize: 30,
                  ),
                ),
              ),
              const SizedBox(height: 10.0),

              //Đăng nhập button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Container(
                  height: 50,
                  width: size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    // border: Border.all(color: Color(0xFF4A47F5), width: 1.5),
                    gradient: LinearGradient(
                      colors: [
                        ColorsCustom.primary,
                        ColorsCustom.primary.withOpacity(0.5),
                      ],
                    ),
                  ),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      // backgroundColor: ColorsCustom.secundary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0)),
                    ),
                    child: const TextCustom(
                        text: 'Đăng nhập', color: Colors.white, fontSize: 20),
                    onPressed: () => Navigator.push(
                        context, routeSlide(page: const LoginPage())),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              //Đăng ký button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Container(
                  height: 50,
                  width: size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                      color: ColorsCustom.primary.withOpacity(0.7),
                      width: 1.5,
                    ),
                  ),
                  child: TextButton(
                    child: const TextCustom(
                      text: 'Đăng Ký',
                      fontSize: 20,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context, routeSlide(page: const RegisterPage()));
                    },
                  ),
                ),
              ),

              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
