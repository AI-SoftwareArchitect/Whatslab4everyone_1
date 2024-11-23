import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatslab4everyone_1/providers/current_user_provider.dart';
import '../../authentication/signup.dart';
import '../../components/whatslab4_button.dart';
import '../../components/whatslab_textfield.dart';
import '../../security/form_validations.dart';

class SignupPage extends ConsumerWidget {
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController passwordRepeat = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  SignupPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProviderProvider);
    final key = GlobalKey<FormState>();
    SignupManager signupManager = SignupManager(
        key: key,
        user: user,
        usernameController: username,
        passwordController: password, emailController: emailController);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return NotificationListener<ScrollNotification>(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
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
                            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.45),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Align(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  "Whatslab signup",
                                  style: TextStyle(color: Colors.white, fontSize: 24),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Form(
                                key: key,
                                autovalidateMode: AutovalidateMode.disabled,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Whatslab4Textfield(
                                      editingController: username,
                                      placeHolder: "Type username",
                                      title: "Username",
                                      type: Whatslab4TextfieldType.NORMAL,
                                      validation: usernameValidator,
                                    ),
                                    const SizedBox(height: 10),
                                    Whatslab4Textfield(
                                      editingController: emailController,
                                      placeHolder: "type email",
                                      title: "Email",
                                      type: Whatslab4TextfieldType.NORMAL,
                                      validation: emailValidator,
                                    ),
                                    const SizedBox(height: 10),
                                    Whatslab4Textfield(
                                      editingController: password,
                                      placeHolder: "Type password",
                                      title: "Password",
                                      type: Whatslab4TextfieldType.PASSWORD,
                                      validation: passwordValidator,
                                    ),
                                    const SizedBox(height: 10),
                                    Whatslab4Textfield(
                                      editingController: passwordRepeat,
                                      placeHolder: "password repeat",
                                      title: "Password repeat",
                                      type: Whatslab4TextfieldType.PASSWORD,
                                      validation: signupValidator,
                                    ),
                                    const SizedBox(height: 20),
                                    Whatslab4Button(
                                      onPressed:  () async {
                                           final isValidSignup = await signupManager.validateAndSignup();
                                           print(isValidSignup);
                                           if (isValidSignup) {
                                             ScaffoldMessenger.of(context).showSnackBar(
                                               const SnackBar(
                                                 duration: Duration(seconds: 5),
                                                 backgroundColor: Colors.greenAccent,
                                                 content: Text('Signup successful!'),
                                               ),
                                             );
                                           }
                                           else {
                                             ScaffoldMessenger.of(context).showSnackBar(
                                               const SnackBar(

                                                 duration: Duration(seconds: 5),
                                                 backgroundColor: Colors.red,
                                                 content: Text('Signup failed!'),
                                               ),
                                             );
                                           }
                                        },
                                      title: "Signup",
                                      fontSize: 24,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(height: 10),
                                    Whatslab4Button(
                                      onPressed: () {
                                        Navigator.pushNamed(context, '/loginpage');
                                      },
                                      title: "login",
                                      fontSize: 20,
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
