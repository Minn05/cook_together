import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:recipes/domain/blocs/blocs.dart';
import 'package:recipes/ui/helpers/helpers.dart';
import 'package:recipes/ui/screens/login/started_page.dart';
import 'package:recipes/ui/themes/colors_theme.dart';
import 'package:recipes/ui/widgets/widgets.dart';

class VerifyEmailPage extends StatelessWidget {
  final String email;

  const VerifyEmailPage({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final userBloc = BlocProvider.of<UserBloc>(context);

    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is LoadingUserState) {
          modalLoading(context, 'Vui lòng kiểm tra email...');
        } else if (state is SuccessUserState) {
          Navigator.pop(context);
          modalSuccess(context, 'Chào mừng!',
              onPressed: () => Navigator.pushAndRemoveUntil(context,
                  routeSlide(page: const StartedPage()), (_) => false));
        } else if (state is FailureUserState) {
          Navigator.pop(context);
          errorMessageSnack(context, state.error);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    height: 300,
                    width: size.width,
                    decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(.1),
                        borderRadius: BorderRadius.circular(8.0)),
                    child:
                        SvgPicture.asset('assets/svg/undraw_opened_email.svg'),
                  ),
                  const SizedBox(height: 20.0),
                  const TextCustom(
                      text: 'Xác thực email của bạn',
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                  const SizedBox(height: 20.0),
                  TextCustom(
                    text: 'Vui lòng nhập mã xác thực. $email',
                    maxLines: 3,
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 30.0),
                  PinCodeTextField(
                      appContext: context,
                      length: 5,
                      keyboardType: TextInputType.number,
                      pinTheme: PinTheme(
                          inactiveColor: ColorsCustom.secondary,
                          activeColor: ColorsCustom.primary),
                      onChanged: (value) {},
                      onCompleted: (value) =>
                          userBloc.add(OnVerifyEmailEvent(email, value)))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
