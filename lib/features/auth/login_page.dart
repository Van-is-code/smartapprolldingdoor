import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:smart_door_app/core/auth/auth_controller.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});
  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _handleLogin() {
    final username = _usernameController.text;
    final password = _passwordController.text;
    if (username.isNotEmpty && password.isNotEmpty) {
      ref.read(authControllerProvider.notifier).login(username, password);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(authControllerProvider, (previous, next) {
      if (next is AsyncError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Đăng nhập thất bại. Vui lòng thử lại.',
              style: GoogleFonts.inter(),
            ),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    });

    final authState = ref.watch(authControllerProvider);
    final isLoading = authState is AsyncLoading;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animation Lottie
              // Sửa lỗi: Xóa định dạng Markdown khỏi URL
              // Lottie.network(
              //   'https://lottie.host/1b39b7e4-5611-4a74-8b3a-5c992ef8a233/pPZbR1gkq8.json',
              //   width: 200,
              //   height: 200,
              // ),
              Text(
                'Chào mừng trở lại',
                style: GoogleFonts.inter(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Đăng nhập để điều khiển cửa',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: Colors.white54,
                ),
              ),
              const SizedBox(height: 40),
              TextField(
                controller: _usernameController,
                // Sửa lỗi: Bỏ const, thêm () cho PhosphorIcons
                decoration: InputDecoration(
                  hintText: 'Tên đăng nhập',
                  prefixIcon: Icon(PhosphorIcons.user(), color: Colors.white54),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                obscureText: true,
                // Sửa lỗi: Bỏ const, thêm () cho PhosphorIcons
                decoration: InputDecoration(
                  hintText: 'Mật khẩu',
                  prefixIcon: Icon(PhosphorIcons.lock(), color: Colors.white54),
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLoading ? null : _handleLogin,
                  child: isLoading
                      ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(color: Colors.white),
                  )
                      : const Text('Đăng Nhập'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
