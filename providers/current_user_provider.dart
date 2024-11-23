
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:whatslab4everyone_1/models/user_model.dart';

part 'current_user_provider.g.dart';

@riverpod
class CurrentUserProvider extends _$CurrentUserProvider {

  @override
  User build() {
    return User(id: "" , username: "" , password: "" , email: "");
  }

  void setNewUserData(User user) {
    state.id = user.id;
    state.username = user.username;
    state.email = user.email;
    state.password = user.password;
  }

  void onlySetUsername(String username) {
    state.username = username;
  }

  void onlySetPassword(String password) {
    state.password = password;
  }

  void onlySetEmail(String email) {
    state.email = email;
  }

  void onlySetI(String id) {
    state.id = id;
  }

}

