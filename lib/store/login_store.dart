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
  @computed
  bool get isValidPassword => password.length >= 6;
  @computed
  bool get isValidEmail => email.contains('@') && email.contains('.com');
  @computed
  bool get isValidForm => isValidEmail && isValidPassword;
}
