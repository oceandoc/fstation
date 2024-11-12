import '../model/user.dart';
import 'store.dart';

class UserManager {
  UserManager._();
  static final instance = UserManager._();

  User? _currentUser;
  User? get currentUser => _currentUser;

  Future<void> init() async {
    final result = await Store.instance.getUser(_currentUser?.name ?? '');
    if (result != null) {
      _currentUser = User.fromJson(result);
    }
  }

  Future<void> updateUser(User? user) async {
    if (user == null || user.name == null || user.token == null) return;

    await Store.instance.updateUser(
      name: user.name!,
      token: user.token,
      tokenUpdateTime: user.tokenUpdateTime?.toIso8601String(),
    );
    _currentUser = user;
  }

  Future<void> clear() async {
    if (_currentUser == null || _currentUser!.name == null) return;

    await Store.instance.deleteUser(_currentUser!.name!);
    _currentUser = null;
  }
}
