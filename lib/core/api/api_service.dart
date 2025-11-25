import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_door_app/core/auth/auth_controller.dart';
import 'package:smart_door_app/core/auth/secure_storage_service.dart';
import 'package:smart_door_app/core/models/log_entry.dart';
import 'package:smart_door_app/core/models/schedule_entry.dart';
import 'package:smart_door_app/shared/constants/app_constants.dart';

// --- Dịch vụ API (Dio) ---
final dioProvider = Provider((ref) {
  final dio = Dio(BaseOptions(
    baseUrl: BASE_URL,
    connectTimeout: const Duration(seconds: 10), // Thêm timeout
    receiveTimeout: const Duration(seconds: 10), // Thêm timeout
  ));
  final storage = ref.watch(storageServiceProvider);

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await storage.getToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        print('--> ${options.method} ${options.uri}'); // Log request
        return handler.next(options);
      },
      onResponse: (response, handler) {
        print('<-- ${response.statusCode} ${response.requestOptions.uri}'); // Log response
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        print('<-- Error ${e.response?.statusCode} ${e.requestOptions.uri}'); // Log error
        print('Error details: ${e.message}');
        // Tự động logout nếu lỗi 401 Unauthorized
        if (e.response?.statusCode == 401) {
          // Dùng read vì đang ở ngoài Widget build context
          // Không nên watch provider trong interceptor
          ref.read(authControllerProvider.notifier).logout();
          print('Unauthorized error, logging out.');
        }
        // Ném lại lỗi DioException để các hàm gọi có thể bắt được
        return handler.next(e);
      },
    ),
  );
  return dio;
});

class ApiService {
  final Dio _dio;
  ApiService(this._dio);

  // Helper để xử lý lỗi DioException và ném ra thông báo dễ hiểu hơn
  Future<T> _handleRequest<T>(Future<T> Function() request) async {
    try {
      return await request();
    } on DioException catch (e) {
      String errorMessage = "Đã xảy ra lỗi mạng hoặc server.";
      if (e.type == DioExceptionType.connectionTimeout || e.type == DioExceptionType.receiveTimeout || e.type == DioExceptionType.sendTimeout) {
        errorMessage = "Kết nối quá hạn. Vui lòng kiểm tra mạng.";
      } else if (e.type == DioExceptionType.badResponse) {
        // Cố gắng lấy message lỗi từ backend nếu có
        final responseData = e.response?.data;
        if (responseData is Map && responseData.containsKey('message')) {
          errorMessage = responseData['message'];
        } else {
          errorMessage = "Lỗi từ server: ${e.response?.statusCode}";
        }
      } else if (e.type == DioExceptionType.cancel) {
        errorMessage = "Yêu cầu đã bị hủy.";
      } else if (e.type == DioExceptionType.connectionError) {
        errorMessage = "Lỗi kết nối mạng. Vui lòng kiểm tra lại.";
      } else if (e.type == DioExceptionType.unknown){
        errorMessage = "Lỗi không xác định: ${e.message}";
      }
      print('API Error: $errorMessage'); // Log lỗi đã được xử lý
      throw errorMessage; // Ném ra string lỗi
    } catch (e) {
      print('Unhandled API Error: $e');
      throw "Đã xảy ra lỗi không mong muốn."; // Ném lỗi chung
    }
  }

  Future<String> login(String username, String password) async {
    return _handleRequest(() async {
      final response = await _dio.post(
        '/auth/login',
        data: {'username': username, 'password': password},
      );
      // Kiểm tra xem có token trong response không
      if (response.data != null && response.data['token'] != null) {
        return response.data['token'];
      } else {
        throw 'Server không trả về token.';
      }
    });
  }

  Future<void> sendCommand(String action) async {
    return _handleRequest(() async {
      await _dio.post('/api/command', data: {'action': action});
    });
  }

  Future<List<LogEntry>> getLogs() async {
    return _handleRequest(() async {
      final response = await _dio.get('/api/logs');
      // Kiểm tra kiểu dữ liệu trả về
      if (response.data is List) {
        return (response.data as List)
            .map((json) => LogEntry.fromJson(json))
            .toList();
      } else {
        throw 'Dữ liệu logs trả về không đúng định dạng List.';
      }
    });
  }

  Future<List<ScheduleEntry>> getSchedules() async {
    return _handleRequest(() async {
      final response = await _dio.get('/api/schedules');
      if (response.data is List) {
        return (response.data as List)
            .map((json) => ScheduleEntry.fromJson(json))
            .toList();
      } else {
        throw 'Dữ liệu schedules trả về không đúng định dạng List.';
      }
    });
  }

  Future<ScheduleEntry> addSchedule(String action, String cronTime) async {
    return _handleRequest(() async {
      final response = await _dio.post(
        '/api/schedules',
        data: {'action': action, 'cronTime': cronTime},
      );
      // Kiểm tra kiểu dữ liệu trả về
      if (response.data is Map<String, dynamic>) {
        return ScheduleEntry.fromJson(response.data);
      } else {
        throw 'Dữ liệu schedule mới trả về không đúng định dạng Map.';
      }
    });
  }

  Future<void> deleteSchedule(String scheduleId) async {
    return _handleRequest(() async {
      await _dio.delete('/api/schedules/$scheduleId');
    });
  }
}

final apiServiceProvider = Provider((ref) {
  return ApiService(ref.watch(dioProvider));
});
