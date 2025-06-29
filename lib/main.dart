import 'package:flutter/material.dart';
import 'core/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'App Đăng Nhập',
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
