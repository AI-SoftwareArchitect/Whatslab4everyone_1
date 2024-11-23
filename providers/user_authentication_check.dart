

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_authentication_check.g.dart';

@riverpod
class UserAuthenticationCheckProvider extends _$UserAuthenticationCheckProvider {

  @override
  bool build() {
    return false;
  }

  void setUserAuthenticatedState(bool newUserAuthState) {
    state = newUserAuthState;
  }

}