import 'package:flutter/material.dart'; // Thêm import
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_door_app/core/auth/auth_controller.dart';
import 'package:smart_door_app/features/auth/login_page.dart';
import 'package:smart_door_app/features/auth/splash_screen.dart';
import 'package:smart_door_app/features/home/main_scaffold.dart';

final routerProvider = Provider<GoRouter>((ref) {
  // Lắng nghe trạng thái AuthController
  final authStateListenable = ValueNotifier<AsyncValue<String?>>(const AsyncLoading());
  ref.listen<AsyncValue<String?>>(authControllerProvider, (_, next) {
    authStateListenable.value = next;
  });

  return GoRouter(
    initialLocation: '/splash',
    // Cập nhật lại logic redirect
    refreshListenable: authStateListenable, // Lắng nghe thay đổi authState
    redirect: (context, state) {
      final authState = ref.read(authControllerProvider); // Đọc trạng thái hiện tại
      final location = state.uri.toString();

      // Trường hợp 1: Đang loading
      if (authState is AsyncLoading) {
        // Chỉ ở lại splash nếu đang ở splash, nếu không thì về splash
        return location == '/splash' ? null : '/splash';
      }

      // Trường hợp 2: Đã load xong, kiểm tra đăng nhập
      final isLoggedIn = authState.valueOrNull != null;

      // Nếu KHÔNG đăng nhập:
      if (!isLoggedIn) {
        // Chỉ cho phép ở trang login, nếu không thì về login
        return location == '/login' ? null : '/login';
      }

      // Nếu ĐÃ đăng nhập:
      // Và đang ở trang login hoặc splash -> về trang chủ '/'
      if (location == '/login' || location == '/splash') {
        return '/';
      }

      // Nếu đã đăng nhập và ở trang khác (ví dụ '/') -> giữ nguyên
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

