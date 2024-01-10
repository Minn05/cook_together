import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/domain/blocs/chat/chat_bloc.dart';
import 'package:recipes/ui/screens/intro/checking_login_page.dart';
import 'package:recipes/domain/blocs/blocs.dart';
import 'package:recipes/domain/blocs/post/post_bloc.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'domain/blocs/call/call_bloc.dart';

void main() {
  timeago.setLocaleMessages('vi', timeago.ViMessages());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc()..add(OnCheckingLoginEvent())),
        BlocProvider(create: (_) => UserBloc()),
        BlocProvider(create: (_) => PostBloc()),
        BlocProvider(create: (_) => RecipeBloc()),
        BlocProvider(create: (_) => ChatBloc()),
        BlocProvider(create: (_) => CallBloc()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Nấu cùng nhau nào',
        home: CheckingLoginPage(),
      ),
    );
  }
}
