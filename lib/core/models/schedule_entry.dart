import 'package:flutter/foundation.dart'; // Thêm import này

@immutable
class ScheduleEntry {
  // ... (Copy toàn bộ class ScheduleEntry) ...
  final String id;
  final String action;
  final String cronTime;

  ScheduleEntry({required this.id, required this.action, required this.cronTime});

  factory ScheduleEntry.fromJson(Map<String, dynamic> json) {
    return ScheduleEntry(
      id: json['_id'],
      action: json['action'],
      cronTime: json['cronTime'],
    );
  }
}
