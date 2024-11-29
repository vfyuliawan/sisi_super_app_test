// ignore_for_file: unused_local_variable, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sisi_super_app/moduls/login/login_screen.dart';
import 'package:sisi_super_app/moduls/post-login/Homepage/main_menu_screen.dart';
import 'package:sisi_super_app/moduls/post-login/Perizinan/perizinan_screen.dart';
import 'package:sisi_super_app/moduls/pre-login/onboarding_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: "/",
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const OnboardingScreen();
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'login',
            builder: (BuildContext context, GoRouterState state) {
              return LoginScreen();
            },
          ),
          GoRoute(
              path: 'home/:id',
              builder: (BuildContext context, GoRouterState state) {
                final idParam = state.pathParameters['id']!;
                return MainMenuScreen(
                  id: idParam,
                );
              },
              routes: [
                GoRoute(
                  path: 'perizinan',
                  builder: (BuildContext context, GoRouterState state) {
                    return PerizinanScreen();
                  },
                ),
              ]),
        ],
      ),
    ],
  );
}
