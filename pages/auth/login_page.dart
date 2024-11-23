import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatslab4everyone_1/providers/current_user_provider.dart';
import 'package:whatslab4everyone_1/providers/user_authentication_check.dart';
import 'package:whatslab4everyone_1/services/current_user_local_save_service.dart';
import '../../authentication/login.dart';
import '../../components/whatslab4_button.dart';
import '../../components/whatslab_textfield.dart';
import '../../security/form_validations.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userAuthenticated = ref.watch(userAuthenticationCheckProviderProvider);
    final user = ref.watch(currentUserProviderProvider);
    CurrentUserLocalSaveService currentUserLocalSaveService = CurrentUserLocalSaveService();
    final LoginManager loginManager = LoginManager(key: _formKey, user: user, usernameController: usernameController, passwordController: passwordController);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return NotificationListener<ScrollNotification>(
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          constraints: const BoxConstraints(maxWidth: 600),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary.withOpacity(0.85),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Align(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  "Whatslab login",
                                  style: TextStyle(color: Colors.black.withOpacity(0.8), fontSize: 24),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Form(
                                key: _formKey,
                                autovalidateMode: AutovalidateMode.disabled,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Whatslab4Textfield(
                                      editingController: usernameController,
                                      placeHolder: "Type username",
                                      title: "Username",
                                      type: Whatslab4TextfieldType.NORMAL,
                                      validation: usernameValidator,
                                    ),
                                    const SizedBox(height: 20),
                                    Whatslab4Textfield(
                                      editingController: passwordController,
                                      placeHolder: "Type password",
                                      title: "Password",
                                      type: Whatslab4TextfieldType.PASSWORD,
                                      validation: passwordValidator,
                                    ),
                                    const SizedBox(height: 30),
                                    Whatslab4Button(
                                      onPressed: () async {
                                        var loginResult = await loginManager.loginAndValidate();
                                        if (loginResult == true) {
                                          final userAuthNotifier = ref.read(userAuthenticationCheckProviderProvider.notifier);
                                          userAuthNotifier.setUserAuthenticatedState(true);
                                          final currUserNotifier = ref.read(currentUserProviderProvider.notifier);
                                          currUserNotifier.setNewUserData(loginManager.user);
                                          currentUserLocalSaveService.update(0, loginManager.user);
                                          Navigator.pushNamed(context, '/profile');
                                        }
                                      },
                                      title: "Login",
                                      fontSize: 24,
                                      color: Colors.greenAccent,
                                    ),
                                    const SizedBox(height: 10),
                                    Whatslab4Button(
                                      onPressed: () {
                                        Navigator.pushNamed(context, '/signup_page');
                                      },
                                      title: "Sign up",
                                      fontSize: 16,
                                      color: Colors.greenAccent.withOpacity(0.8),
                                      w4bSize: Whatslab4ButtonSize.small,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
