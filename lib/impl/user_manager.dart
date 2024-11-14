import '../generated/error.pbenum.dart';
import '../model/user.dart';
import 'grpc_client.dart';
import 'logger.dart';
import 'store.dart';

class UserManager {
  UserManager._();
  static final instance = UserManager._();

  User? _currentUser;
  User? get currentUser => _currentUser;

  bool get isAuth => _currentUser?.name != null && _currentUser?.token != null;

  Future<void> init() async {
    // First try to get current user from database
    final currentUser = await Store.instance.getCurrentUser();
    if (currentUser != null) {
      _currentUser = User.fromJson(currentUser);

      // Update token using gRPC if we have a current user
      if (_currentUser?.token != null) {
        try {
          final response = await GrpcClient.instance.updateToken(_currentUser!);
          if (response.errCode == ErrCode.Success) {
            // Update user with new token
            await updateUser(
              User(
                name: _currentUser!.name,
                token: response.token,
                tokenUpdateTime: DateTime.now(),
              ),
            );
          }
        } catch (e) {
          Logger.error('Failed to update token: $e');
        }
      }
      return;
    }
  }

  Future<void> updateUser(User? user) async {
    if (user == null || user.name == null) return;

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

  Future<void> updateToken() async {
    if (!isAuth) return;

    try {
      final response = await GrpcClient.instance.updateToken(_currentUser!);
      if (response.errCode == ErrCode.Success) {
        await updateUser(
          User(
            name: _currentUser!.name,
            token: response.token,
            tokenUpdateTime: DateTime.now(),
          ),
        );
      } else {
        Logger.error('Failed to update token: ${_currentUser!.name}');
        _currentUser?.token = null;
        await updateUser(_currentUser);
      }
    } catch (e) {
      Logger.error('Failed to update token: $e');
    }
  }
}
