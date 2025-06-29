import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/login/login_screen.dart';
import '../screens/main_tab/main_tab_screen.dart';
import '../screens/my_tickets/my_tickets_screen.dart';
import '../screens/profile/edit/profile_edit_screen.dart';
import '../screens/register/register_screen.dart';
import '../screens/support/support_screen.dart';


final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MainTabScreen(),

    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/profile/edit',
      builder: (context, state) => const ProfileEditScreen(),
    ),
    GoRoute(
      path: '/my_tickets',
      builder: (context, state) => const MyTicketsScreen(),
    ),
    GoRoute(
      path: '/support',
      builder: (context, state) => const SupportScreen(),
    ),
    // GoRoute(
    //   path: '/booking',
    //   builder: (context, state) => const BookingScreen(),
    // ),
  ],
);
