import 'package:flutter/foundation.dart'; // Thêm import này

@immutable
class LogEntry {
  final String id;
  // ... (Copy toàn bộ class LogEntry) ...
  final String action;
  final String source;
  final DateTime timestamp;
  final String username;

  LogEntry({
    required this.id,
    required this.action,
    required this.source,
    required this.timestamp,
    required this.username,
  });

  factory LogEntry.fromJson(Map<String, dynamic> json) {
    return LogEntry(
      id: json['_id'],
      action: json['action'],
      source: json['source'],
      timestamp: DateTime.parse(json['timestamp']),
      username: json['user']?['username'] ?? 'Không rõ',
    );
  }
}
