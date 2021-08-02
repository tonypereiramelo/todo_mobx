import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:todomobx/screens/list_screen.dart';
import 'package:todomobx/store/login_store.dart';
import 'package:todomobx/widgets/custom_icon_button.dart';
import 'package:todomobx/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginStore loginStore;
  ReactionDisposer disposer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loginStore = Provider.of<LoginStore>(context);
    disposer = reaction((_) => loginStore.loggedIn, (loggedIn) {
      if (loggedIn)
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => ListScreen(),
          ),
        );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(32),
          child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 16,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Observer(builder: (_) {
                      return CustomTextField(
                        hint: 'E-mail',
                        prefix: Icon(Icons.account_circle),
                        textInputType: TextInputType.emailAddress,
                        onChanged: loginStore.setEmail,
                        enabled: !loginStore.loading,
                      );
                    }),
                    const SizedBox(
                      height: 16,
                    ),
                    Observer(builder: (_) {
                      return CustomTextField(
                        hint: 'Senha',
                        prefix: Icon(Icons.lock),
                        obscure: !loginStore.showPassword,
                        onChanged: loginStore.setPassword,
                        enabled: !loginStore.loading,
                        suffix: CustomIconButton(
                          radius: 32,
                          iconData: loginStore.showPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          onTap: loginStore.setShowPassword,
                        ),
                      );
                    }),
                    const SizedBox(
                      height: 16,
                    ),
                    Observer(builder: (_) {
                      return SizedBox(
                        height: 44,
                        child: ElevatedButton(
                          child: loginStore.loading
                              ? CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                )
                              : Text(
                                  'Login',
                                ),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32),
                            ),
                            onPrimary: Colors.white,
                            primary: Theme.of(context).primaryColor,
                            onSurface:
                                Theme.of(context).primaryColor.withAlpha(100),
                          ),
                          onPressed: loginStore.loginPressed,
                        ),
                      );
                    })
                  ],
                ),
              )),
        ),
      ),
    );
  }

  @override
  void dispose() {
    disposer();
    super.dispose();
  }
}
