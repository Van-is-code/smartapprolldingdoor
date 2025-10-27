import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:smart_door_app/core/auth/auth_controller.dart';

class ProfilePage extends ConsumerWidget {
  // ... (Copy class ProfilePage) ...
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tài khoản'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Icon(PhosphorIcons.userCircleFill, size: 80, color: Color(0xFF6E5FFF)),
            const SizedBox(height: 16),
            Text(
              'username', // TODO: Lấy username từ state
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            ListTile(
              leading: const Icon(PhosphorIcons.key),
              title: const Text('Đổi mật khẩu'),
              trailing: const Icon(PhosphorIcons.caretRight),
              onTap: () {
                // TODO: Mở màn hình đổi mật khẩu
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
                  ref.read(authControllerProvider.notifier).logout();
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
