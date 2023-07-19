import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:zxplore_app/src/api/dio_error_handler.dart';
import 'package:zxplore_app/src/api/models/login_response.dart';
import 'package:zxplore_app/src/api/remote_api.dart';
import 'package:zxplore_app/src/shared/app_exception.dart';
import 'package:zxplore_app/src/shared/app_sizes.dart';
import 'package:zxplore_app/src/shared/primary_button.dart';
import 'package:zxplore_app/src/shared/providers.dart';
import 'package:zxplore_app/src/utils/secure_storage.dart';

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
  final bool _submitted = false;

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
    try {
      if (_formKey.currentState!.validate()) {
        // callback
        void callback() {
          context.go('/accountInformation');
        }

        _formKey.currentState!.save();
        final api = ref.watch(remoteApiProvider);
        final response = await api.login(
          username: username,
          password: password,
        );
        await SecureStorage.saveAgentInformation(
          response.data!.user!.token!,
          response.data!.user!.employeeId.toString(),
          response.data!.user!.branchNumber.toString(),
        );

        callback();
      }
    } on DioException catch (error) {
      if (error.response != null &&
          error.response!.data != null &&
          error.response!.data['message'] != null) {
        throw AppException(error.response!.data['message']);
      } else if (error.response != null &&
          error.response!.data != null &&
          error.response!.data['Message'] != null) {
        throw AppException(error.response!.data['Message']);
      } else if (error.response?.statusCode == 502) {
        var value = LoginResponse.fromJson(error.response?.data);
        throw AppException(value.message);
      } else {
        throw AppException(getErrorMessage(error));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var darkMode = ref.watch(darkModeProvider);
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
                      if (_submitted) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      } else {
                        return null;
                      }
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
                      if (_submitted) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      } else {
                        return null;
                      }
                    },
                  ),
                  gapH32,
                  PrimaryButton(
                    text: 'SIGN IN',
                    onPressed: () async {
                      context.go('/accountInformation');
                      // _node.unfocus();
                      // setState(() {
                      //   _submitted = true;
                      // });
                      // try {
                      //   await signIn();
                      // } catch (e) {
                      //   // show an alert dialog with the error message
                      //   showDialog(
                      //     context: context,
                      //     builder: (context) {
                      //       return AlertDialog(
                      //         title: const Text('Error'),
                      //         content: Text(e.toString()),
                      //         actions: [
                      //           TextButton(
                      //             onPressed: () {
                      //               Navigator.of(context).pop();
                      //             },
                      //             child: const Text('OK'),
                      //           ),
                      //         ],
                      //       );
                      //     },
                      //   );
                      // }
                    },
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
