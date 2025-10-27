import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_door_app/core/api/api_service.dart';
import 'package:smart_door_app/core/models/schedule_entry.dart';

final schedulesProvider =
StateNotifierProvider<ScheduleNotifier, AsyncValue<List<ScheduleEntry>>>((ref) {
  return ScheduleNotifier(ref.watch(apiServiceProvider), ref);
});

class ScheduleNotifier extends StateNotifier<AsyncValue<List<ScheduleEntry>>> {
  // ... (Copy toàn bộ class ScheduleNotifier) ...
  final ApiService _api;
  final Ref _ref;

  ScheduleNotifier(this._api, this._ref) : super(const AsyncLoading()) {
    fetchSchedules();
  }

  Future<void> fetchSchedules() async {
    try {
      final schedules = await _api.getSchedules();
      state = AsyncValue.data(schedules);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addSchedule(String action, String cronTime) async {
    try {
      final newSchedule = await _api.addSchedule(action, cronTime);
      state.whenData((schedules) {
        state = AsyncValue.data([...schedules, newSchedule]);
      });
    } catch (e) {
      // Xử lý lỗi (ví dụ: hiển thị snackbar)
    }
  }

  Future<void> deleteSchedule(String scheduleId) async {
    try {
      await _api.deleteSchedule(scheduleId);
      state.whenData((schedules) {
        state = AsyncValue.data(
            schedules.where((s) => s.id != scheduleId).toList()
        );
      });
    } catch (e) {
      // Xử lý lỗi
    }
  }
}