import 'package:mobx/mobx.dart';
part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  @observable
  String email = '';

  @action
  void setEmail(String value) => email = value;

  @observable
  String password = '';

  @action
  void setPassword(String value) => password = value;

  @observable
  bool showPassword = false;

  @action
  void setShowPassword() => showPassword = !showPassword;

  @observable
  bool loading = false;

  @observable
  bool loggedIn = false;

  @action
  Future<void> login() async {
    loading = true;

    await Future.delayed(Duration(seconds: 2));

    loading = false;
    loggedIn = true;
  }

  @computed
  bool get isValidPassword => password.length >= 6;

  @computed
  bool get isValidEmail => email.contains('@') && email.contains('.com');

  @computed
  Function get loginPressed =>
      (isValidEmail && isValidPassword && !loading) ? login : null;
}
