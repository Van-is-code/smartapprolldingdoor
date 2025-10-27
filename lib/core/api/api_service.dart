import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_door_app/core/auth/auth_controller.dart'; // Import sẽ tạo ở bước sau
import 'package:smart_door_app/core/auth/secure_storage_service.dart';
import 'package:smart_door_app/core/models/log_entry.dart'; // Import sẽ tạo ở bước sau
import 'package:smart_door_app/core/models/schedule_entry.dart'; // Import sẽ tạo ở bước sau
import 'package:smart_door_app/shared/constants/app_constants.dart';

// --- Dịch vụ API (Dio) ---
final dioProvider = Provider((ref) {
  final dio = Dio(BaseOptions(baseUrl: BASE_URL));
  final storage = ref.watch(storageServiceProvider);

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await storage.getToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (e, handler) {
        if (e.response?.statusCode == 401) {
          ref.read(authControllerProvider.notifier).logout();
        }
        return handler.next(e);
      },
    ),
  );
  return dio;
});

class ApiService {
  final Dio _dio;
  ApiService(this._dio);

  Future<String> login(String username, String password) async {
    // ... (Toàn bộ code của hàm login) ...
    // (Copy y hệt từ file main.dart gốc)
    final response = await _dio.post(
      '/auth/login',
      data: {'username': username, 'password': password},
    );
    return response.data['token'];
  }

  Future<void> sendCommand(String action) async {
    // ... (Toàn bộ code của hàm sendCommand) ...
    await _dio.post('/api/command', data: {'action': action});
  }

  Future<List<LogEntry>> getLogs() async {
    // ... (Toàn bộ code của hàm getLogs) ...
    final response = await _dio.get('/api/logs');
    return (response.data as List)
        .map((json) => LogEntry.fromJson(json))
        .toList();
  }

  Future<List<ScheduleEntry>> getSchedules() async {
    // ... (Toàn bộ code của hàm getSchedules) ...
    final response = await _dio.get('/api/schedules');
    return (response.data as List)
        .map((json) => ScheduleEntry.fromJson(json))
        .toList();
  }

  Future<ScheduleEntry> addSchedule(String action, String cronTime) async {
    // ... (Toàn bộ code của hàm addSchedule) ...
    final response = await _dio.post(
      '/api/schedules',
      data: {'action': action, 'cronTime': cronTime},
    );
    return ScheduleEntry.fromJson(response.data);
  }

  Future<void> deleteSchedule(String scheduleId) async {
    // ... (Toàn bộ code của hàm deleteSchedule) ...
    await _dio.delete('/api/schedules/$scheduleId');
  }
}

final apiServiceProvider = Provider((ref) {
  return ApiService(ref.watch(dioProvider));
});
