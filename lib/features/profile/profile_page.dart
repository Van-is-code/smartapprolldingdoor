import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:smart_door_app/core/auth/auth_controller.dart';
// Import provider để lấy thông tin user
import 'package:jwt_decoder/jwt_decoder.dart'; // Thêm thư viện này vào pubspec.yaml

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Lấy thông tin username từ token (cần xử lý null)
    final authState = ref.watch(authControllerProvider);
    String username = 'Loading...';
    authState.whenData((token) {
      if (token != null) {
        try {
          Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
          username = decodedToken['username'] ?? 'Unknown User';
        } catch (e) {
          username = 'Error decoding token';
          // Optional: log the error e
        }
      } else {
        username = 'Not logged in';
      }
    });


    return Scaffold(
      appBar: AppBar(
        title: const Text('Tài khoản'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // Sửa lỗi: Dùng icon gốc thay vì *Fill
            Icon(PhosphorIcons.userCircle(), size: 80, color: const Color(0xFF6E5FFF)),
            const SizedBox(height: 16),
            // Hiển thị username đã lấy được
            Text(
              username,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            ListTile(
              leading: Icon(PhosphorIcons.key()),
              title: const Text('Đổi mật khẩu'),
              trailing: Icon(PhosphorIcons.caretRight()),
              onTap: () {
                // TODO: Mở màn hình đổi mật khẩu
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Chức năng đổi mật khẩu sẽ được phát triển!')),
                );
              },
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.red.withOpacity(0.1),
                  foregroundColor: Colors.redAccent,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  // Thêm xác nhận trước khi đăng xuất
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Xác nhận đăng xuất'),
                      content: const Text('Bạn có chắc muốn đăng xuất khỏi ứng dụng không?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Hủy'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            ref.read(authControllerProvider.notifier).logout();
                          },
                          child: const Text('Đăng xuất', style: TextStyle(color: Colors.redAccent)),
                        ),
                      ],
                    ),
                  );
                },
                child: const Text('Đăng Xuất', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

