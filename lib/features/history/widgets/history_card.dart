import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:smart_door_app/core/models/log_entry.dart';

class HistoryCard extends StatelessWidget {
  // ... (Copy class HistoryCard) ...
  final LogEntry log;
  const HistoryCard({super.key, required this.log});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    IconData icon;
    Color color;

    switch (log.action) {
      case 'OPEN':
        icon = PhosphorIcons.arrowUp;
        color = Colors.green;
        break;
      case 'CLOSE':
        icon = PhosphorIcons.arrowDown;
        color = Colors.red;
        break;
      default:
        icon = PhosphorIcons.handPalm;
        color = Colors.orange;
    }

    return Card(
      color: theme.colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(
          'Lệnh: ${log.action}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'Nguồn: ${log.source} • Bởi: ${log.username}',
          style: const TextStyle(color: Colors.white54),
        ),
        trailing: Text(
          DateFormat('HH:mm\ndd/MM/yy').format(log.timestamp.toLocal()),
          textAlign: TextAlign.right,
          style: const TextStyle(color: Colors.white54, fontSize: 12),
        ),
      ),
    );
  }
}