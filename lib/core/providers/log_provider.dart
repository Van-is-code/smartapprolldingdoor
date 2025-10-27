import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_door_app/core/api/api_service.dart';
import 'package:smart_door_app/core/models/log_entry.dart';

final logsProvider = FutureProvider<List<LogEntry>>((ref) async {
  final api = ref.watch(apiServiceProvider);
  return api.getLogs();
});
