import 'package:chat_app/core/chat_user_bloc/chat_user_bloc.dart';
import 'package:chat_app/core/user_bloc/user_bloc.dart';
import 'package:chat_app/features/splash_screen/views/splash_screen.dart';
import 'package:chat_app/screen_distributor.dart';
import 'package:chat_app/services/firebase_service.dart';
import 'package:chat_app/core/app_status_bloc/app_status_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp();
    runApp(MyApp());
  } catch (e) {
    runApp(ErrorApp(e.toString()));
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppStatusBloc>(
          create: (context) => AppStatusBloc(FirebaseService.instance),
        ),
        BlocProvider<UserBloc>(
          create: (context) => UserBloc(FirebaseService.instance),
        ),
        BlocProvider<ChatUserBloc>(
          create: (context) => ChatUserBloc(FirebaseService.instance),
        )
      ],
      child: MaterialApp(
        home: ScreenUtilInit(
          designSize: Size(375, 800),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return Scaffold(
              body: SafeArea(
                child: PageBase(child: SplashScreen(),),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ErrorApp extends StatelessWidget {
  final String errorMessage;

  const ErrorApp(this.errorMessage);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(
            'Failed to initialize Firebase: $errorMessage',
            style: TextStyle(
              fontSize: 18,
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
