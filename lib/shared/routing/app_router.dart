import 'package:flutter/material.dart'; // Thêm import
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_door_app/core/auth/auth_controller.dart';
import 'package:smart_door_app/features/auth/login_page.dart';
import 'package:smart_door_app/features/auth/splash_screen.dart';
import 'package:smart_door_app/features/home/main_scaffold.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authControllerProvider);

  return GoRouter(
    initialLocation: '/splash',
    redirect: (context, state) {
      final location = state.uri.toString();
      final isLoading = authState is AsyncLoading;
      final isLoggedIn = authState.valueOrNull != null;

      // Giữ ở splash nếu đang loading và chưa ở splash
      if (isLoading && location != '/splash') return '/splash';
      // Nếu không đăng nhập và không ở trang login/splash -> về login
      if (!isLoggedIn && location != '/login' && location != '/splash') return '/login';
      // Nếu đã đăng nhập và đang ở login/splash -> về trang chủ
      if (isLoggedIn && (location == '/login' || location == '/splash')) return '/';

      // Các trường hợp khác giữ nguyên
      return null;
    },
    routes: [
      GoRoute(path: '/splash', builder: (context, state) => const SplashScreen()),
      GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
      GoRoute(
        path: '/',
        builder: (context, state) => const MainScaffold(),
      ),
    ],
  );
});

// Sửa lỗi: Xóa dấu } thừa
// } // <-- Xóa dòng này
