import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:smart_door_app/shared/constants/app_constants.dart'; // Import mới

// --- Dịch vụ Lưu trữ Bảo mật ---
final secureStorageProvider = Provider((ref) => const FlutterSecureStorage());

class SecureStorageService {
  final FlutterSecureStorage _storage;
  SecureStorageService(this._storage);

  Future<void> saveToken(String token) async {
    await _storage.write(key: TOKEN_KEY, value: token);
  }

  Future<String?> getToken() async {
    return await _storage.read(key: TOKEN_KEY);
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: TOKEN_KEY);
  }
}

final storageServiceProvider = Provider((ref) {
  return SecureStorageService(ref.watch(secureStorageProvider));
});
