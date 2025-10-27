import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_door_app/core/api/api_service.dart';
import 'package:smart_door_app/core/auth/secure_storage_service.dart';

// --- State Xác thực ---
final authControllerProvider =
StateNotifierProvider<AuthController, AsyncValue<String?>>((ref) {
  return AuthController(ref.watch(storageServiceProvider), ref);
});

class AuthController extends StateNotifier<AsyncValue<String?>> {
  // ... (Copy toàn bộ class AuthController) ...
  final SecureStorageService _storage;
  final Ref _ref;
  AuthController(this._storage, this._ref) : super(const AsyncLoading()) {
    checkAuthStatus();
  }

  Future<void> checkAuthStatus() async {
    final token = await _storage.getToken();
    state = AsyncValue.data(token);
  }

  Future<void> login(String username, String password) async {
    state = const AsyncLoading();
    try {
      final token = await _ref.read(apiServiceProvider).login(username, password);
      await _storage.saveToken(token);
      state = AsyncValue.data(token);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> logout() async {
    await _storage.deleteToken();
    state = const AsyncValue.data(null);
  }
}
