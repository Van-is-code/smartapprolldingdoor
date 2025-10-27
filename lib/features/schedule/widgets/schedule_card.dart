import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:smart_door_app/core/models/schedule_entry.dart';

class ScheduleCard extends StatelessWidget {
  final ScheduleEntry schedule;
  final VoidCallback onDelete;

  const ScheduleCard({super.key, required this.schedule, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isOpening = schedule.action == 'OPEN';

    return Card(
      color: theme.colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(
          // Sửa lỗi: Thêm () cho PhosphorIcons
          isOpening ? PhosphorIcons.arrowUp() : PhosphorIcons.arrowDown(),
          color: isOpening ? Colors.green : Colors.red,
        ),
        title: Text(
          'Lệnh: ${schedule.action}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('Cron: ${schedule.cronTime}'),
        trailing: IconButton(
          // Sửa lỗi: Thêm () cho PhosphorIcons
          icon: Icon(PhosphorIcons.trash(), color: Colors.white54),
          tooltip: 'Xóa lịch hẹn', // Thêm tooltip
          onPressed: onDelete,
        ),
      ),
    );
  }
}
