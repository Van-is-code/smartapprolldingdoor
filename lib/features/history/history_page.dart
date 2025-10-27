import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:smart_door_app/core/providers/log_provider.dart';
import 'package:smart_door_app/features/history/widgets/history_card.dart';
import 'package:smart_door_app/core/models/log_entry.dart'; // Import model
import 'package:intl/intl.dart'; // Import intl

class HistoryPage extends ConsumerWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logsAsync = ref.watch(logsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lịch sử'),
        actions: [
          IconButton(
            // Sửa lỗi: Thêm () cho PhosphorIcons
            icon: Icon(PhosphorIcons.arrowCounterClockwise()),
            tooltip: 'Làm mới', // Thêm tooltip
            onPressed: () => ref.refresh(logsProvider),
          ),
        ],
      ),
      body: logsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Lỗi tải lịch sử: $err')), // Thông báo lỗi rõ hơn
        data: (logs) {
          if (logs.isEmpty) {
            return const Center(child: Text('Không có lịch sử hoạt động.'));
          }
          // Thêm RefreshIndicator để kéo xuống làm mới
          return RefreshIndicator(
            onRefresh: () => ref.refresh(logsProvider.future),
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: logs.length,
              itemBuilder: (context, index) {
                final log = logs[index];
                return HistoryCard(log: log);
              },
            ),
          );
        },
      ),
    );
  }
}
