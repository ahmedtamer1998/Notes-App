import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note_app/view/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Todo App",
        theme: ThemeData(
          brightness: Brightness.dark,
          useMaterial3: true,
          appBarTheme:  const AppBarTheme(
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.black,
            )
        ),
        home: WelcomeScreen(),
      ),
    );
  }
}
