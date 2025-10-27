import 'package:flutter/material.dart'; // Thêm import
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_door_app/core/auth/auth_controller.dart';
import 'package:smart_door_app/features/auth/login_page.dart'; // Import sẽ tạo
import 'package:smart_door_app/features/auth/splash_screen.dart'; // Import sẽ tạo
import 'package:smart_door_app/features/home/main_scaffold.dart'; // Import sẽ tạo

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authControllerProvider);

  return GoRouter(
    initialLocation: '/splash',
    // ... (Copy toàn bộ logic redirect) ...
    redirect: (context, state) {
      final location = state.uri.toString();
      final isLoading = authState is AsyncLoading;
      final isLoggedIn = authState.valueOrNull != null;

      if (isLoading && location != '/splash') return '/splash';
      if (!isLoggedIn && location != '/login') return '/login';
      if (isLoggedIn && (location == '/login' || location == '/splash')) return '/';

      return null;
    },
    routes: [
      // ... (Copy toàn bộ routes) ...
      GoRoute(path: '/splash', builder: (context, state) => const SplashScreen()),
      GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
      GoRoute(
        path: '/',
        builder: (context, state) => const MainScaffold(),
      ),
    ],
  );
});