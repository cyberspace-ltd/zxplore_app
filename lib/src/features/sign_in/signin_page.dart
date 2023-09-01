import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zxplore_app/src/features/sign_in/signin_page_controller.dart';
import 'package:zxplore_app/src/router/router.dart';
import 'package:zxplore_app/src/shared/app_sizes.dart';
import 'package:zxplore_app/src/shared/async_value_ui.dart';
import 'package:zxplore_app/src/shared/primary_button.dart';
import 'package:zxplore_app/src/shared/providers.dart';

class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({super.key});

  @override
  ConsumerState<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
  final _node = FocusScopeNode();
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  String get username => _usernameController.text.trim();
  String get password => _passwordController.text.trim();

  bool _passwordHidden = true;

  void togglePasswordVisibility() {
    setState(() {
      _passwordHidden = !_passwordHidden;
    });
  }

  @override
  void dispose() {
    _node.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> signIn() async {
    if (!_formKey.currentState!.validate()) return;
    final controller = ref.read(signInPageControllerProvider.notifier);
    await controller.submit(
      username: username,
      password: password,
      onSuccess: () {
        const AccountInformationRouteData()
            .go(rootNavigatorKey.currentContext!);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final darkMode = ref.watch(darkModeProvider);
    ref.listen<AsyncValue>(
      signInPageControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    final state = ref.watch(signInPageControllerProvider);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 40.0,
                        child: Image.asset('assets/images/logo.png'),
                      ),
                      Text(
                        'XPLORE',
                        style: Theme.of(context).textTheme.headlineMedium,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  gapH24,
                  Text(
                    'Enter your Zenith bank active directory credentials below. This helps identify the employee that wants to access the application.',
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                  gapH24,
                  TextFormField(
                    controller: _usernameController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.text,
                    maxLength: 10,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    decoration: const InputDecoration(
                      hintText: 'Username',
                      labelText: 'Username',
                      prefixIcon: Icon(Icons.account_circle_outlined),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                  ),
                  gapH24,
                  TextFormField(
                    controller: _passwordController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: _passwordHidden,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(_passwordHidden
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined),
                        onPressed: togglePasswordVisibility,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  gapH32,
                  PrimaryButton(
                    text: 'SIGN IN',
                    isLoading: state.isLoading,
                    onPressed: signIn,
                  ),
                  gapH64,
                  ListTile(
                    title: const Text('Dark Theme'),
                    leading: const Icon(Icons.dark_mode_outlined),
                    trailing: Switch(
                      value: darkMode,
                      onChanged: (newValue) {
                        ref.read(darkModeProvider.notifier).toggle();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
