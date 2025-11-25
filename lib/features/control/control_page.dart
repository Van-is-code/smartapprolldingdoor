import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:smart_door_app/core/api/api_service.dart';
// Tách widget nút bấm ra file riêng
import 'package:smart_door_app/features/control/widgets/control_button.dart';

class ControlPage extends ConsumerStatefulWidget {
  const ControlPage({super.key});
  @override
  ConsumerState<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends ConsumerState<ControlPage> {
  String? _commandLoading; // "OPEN", "CLOSE", "STOP"

  Future<void> _runCommand(String action) async {
    setState(() {
      _commandLoading = action;
    });

    try {
      await ref.read(apiServiceProvider).sendCommand(action);
      // Kiểm tra widget còn tồn tại không trước khi dùng context
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Đã gửi lệnh: $action'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gửi lệnh thất bại: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );

      // TODO: Thử gửi bằng Bluetooth ở đây
    } finally {
      // Thêm độ trễ nhỏ để user thấy animation
      await Future.delayed(const Duration(milliseconds: 500));
      // Kiểm tra widget còn tồn tại không trước khi gọi setState
      if (mounted) {
        setState(() {
          _commandLoading = null;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Điều khiển cửa'),
        actions: [
          // Nút kích hoạt Bluetooth (chưa làm)
          IconButton(
            // Sửa lỗi: Thêm () cho PhosphorIcons
            icon: Icon(PhosphorIcons.bluetooth(), color: Colors.blueAccent),
            onPressed: () {
              // TODO: Mở màn hình quét Bluetooth
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Chức năng Bluetooth sẽ được phát triển!')),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'TRẠNG THÁI CỬA',
              style: GoogleFonts.inter(
                fontSize: 14,
                color: Colors.white54,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Không xác định', // Sẽ cập nhật khi có cảm biến
              style: GoogleFonts.inter(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            // Animation chính
            // Sửa lỗi: Xóa định dạng Markdown khỏi URL
            // Lottie.network(
            //   'https://assets3.lottiefiles.com/packages/lf20_bpdnxy3w.json',
            //   width: 250,
            //   height: 250,
            // ),
            const SizedBox(height: 60),
            // Hàng nút điều khiển
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Sửa lỗi: Đổi tên _ControlButton và thêm () cho PhosphorIcons
                ControlButton(
                  icon: PhosphorIcons.arrowUp(),
                  label: 'MỞ',
                  color: Colors.green,
                  isLoading: _commandLoading == 'OPEN',
                  onPressed: () => _runCommand('OPEN'),
                ),
                ControlButton(
                  icon: PhosphorIcons.handPalm(),
                  label: 'DỪNG',
                  color: Colors.orange,
                  isLoading: _commandLoading == 'STOP',
                  onPressed: () => _runCommand('STOP'),
                ),
                ControlButton(
                  icon: PhosphorIcons.arrowDown(),
                  label: 'ĐÓNG',
                  color: Colors.red,
                  isLoading: _commandLoading == 'CLOSE',
                  onPressed: () => _runCommand('CLOSE'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
