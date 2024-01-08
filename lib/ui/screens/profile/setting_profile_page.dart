import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/colors.dart';
import 'package:recipes/domain/blocs/blocs.dart';
import 'package:recipes/ui/helpers/helpers.dart';
import 'package:recipes/ui/screens/login/started_page.dart';
import 'package:recipes/ui/screens/profile/account_profile_page.dart';
import 'package:recipes/ui/screens/profile/change_password_page.dart';
import 'package:recipes/ui/screens/profile/privacy_profile_page.dart';
import 'package:recipes/ui/screens/profile/theme_profile_page.dart';
import 'package:recipes/ui/screens/profile/widgets/item_profile.dart';
import 'package:recipes/ui/themes/button.dart';
import 'package:recipes/ui/themes/colors_theme.dart';
import 'package:recipes/ui/widgets/widgets.dart';

class SettingProfilePage extends StatelessWidget {
  const SettingProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);
    final authBloc = BlocProvider.of<AuthBloc>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const TextCustom(
            text: 'Cài đặt', fontSize: 19, fontWeight: FontWeight.w500),
        elevation: 0,
        leading: Button(
            height: 40,
            width: 40,
            bg: bgGrey,
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: Colors.black),
            onPress: () => Navigator.pop(context)),
        //  IconButton(
        //   onPressed: () => Navigator.pop(context),
        //   icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black)
        // ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          children: [
            ItemProfile(
                text: 'Quyền riêng tư',
                icon: Icons.lock_outline_rounded,
                onPressed: () => Navigator.push(
                    context, routeSlide(page: const PrivacyProgilePage()))),
            ItemProfile(
                text: 'Đổi mật khẩu',
                icon: Icons.security_outlined,
                onPressed: () => Navigator.push(
                    context, routeSlide(page: const ChangePasswordPage()))),
            ItemProfile(
                text: 'Tài khoản',
                icon: Icons.account_circle_outlined,
                onPressed: () => Navigator.push(
                    context, routeSlide(page: const AccountProfilePage()))),
            ItemProfile(
                text: 'Trợ giúp',
                icon: Icons.help_outline_rounded,
                onPressed: () {}),

            ItemProfile(
                text: 'Chủ đề',
                icon: Icons.palette_outlined,
                onPressed: () => Navigator.push(
                    context, routeSlide(page: const ThemeProfilePage()))),

            const SizedBox(height: 20.0),

            // const SizedBox(height: 10.0),
            // ItemProfile(
            //   text: 'Thêm hoặc thay đổi tài khoản',
            //   icon: Icons.add,
            //   colorText: ColorsCustom.primary,
            //   onPressed: () {}
            // ),
            ItemProfile(
                text: 'Đăng xuất',
                icon: Icons.logout_rounded,
                colorText: ColorsCustom.primary,
                onPressed: () {
                  authBloc.add(OnLogOutEvent());
                  userBloc.add(OnLogOutUser());
                  Navigator.pushAndRemoveUntil(context,
                      routeSlide(page: const StartedPage()), (_) => false);
                }),
          ],
        ),
      ),
    );
  }
}
