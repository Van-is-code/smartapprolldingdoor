import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:smart_door_app/core/providers/schedule_provider.dart';
// Import widget card
import 'package:smart_door_app/features/schedule/widgets/schedule_card.dart';
import 'package:smart_door_app/core/models/schedule_entry.dart'; // Import model

class SchedulePage extends ConsumerWidget {
  // ... (Copy class SchedulePage) ...
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final schedulesAsync = ref.watch(schedulesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lịch hẹn'),
        actions: [
          IconButton(
            icon: const Icon(PhosphorIcons.plus),
            onPressed: () {
              // TODO: Mở dialog thêm lịch hẹn
              // Tạm thời refresh
              ref.read(schedulesProvider.notifier).fetchSchedules();
            },
          ),
        ],
      ),
      body: schedulesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Lỗi: $err')),
        data: (schedules) {
          if (schedules.isEmpty) {
            return const Center(child: Text('Không có lịch hẹn nào.'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: schedules.length,
            itemBuilder: (context, index) {
              final schedule = schedules[index];
              return ScheduleCard(
                schedule: schedule,
                onDelete: () {
                  ref.read(schedulesProvider.notifier).deleteSchedule(schedule.id);
                },
              );
            },
          );
        },
      ),
    );
  }
}
