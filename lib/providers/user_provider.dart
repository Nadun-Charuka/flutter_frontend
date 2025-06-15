import 'package:flutter_frontend/model/user_model.dart';
import 'package:flutter_frontend/services/user_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userServiceProvider = Provider<UserServices>(
  (ref) => UserServices(),
);

class UserNotifier extends AsyncNotifier<List<User>> {
  @override
  Future<List<User>> build() async {
    return ref.read(userServiceProvider).fetchUsers();
  }

  Future<void> addUser(User user) async {
    await ref.read(userServiceProvider).createUser(user);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => ref.read(userServiceProvider).fetchUsers(),
    );
  }
}

final userProvider =
    AsyncNotifierProvider<UserNotifier, List<User>>(UserNotifier.new);
