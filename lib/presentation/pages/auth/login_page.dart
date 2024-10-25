

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common/result_state.dart';
import '../../providers/auth/login_provider.dart';

class LoginPage extends ConsumerWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(loginProvider);

    if (loginState.status == Status.SUCCESS) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, '/home');
      });
    }


    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            loginState.status == Status.LOADING
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () => ref.read(loginProvider.notifier).login(
                            usernameController.text,
                            passwordController.text,
                          ),
                    child: const Text('Login'),
                  ),
            if (loginState.status == Status.ERROR)
              Text('${loginState.message}'),
          ],
        ),
      ),
    );
  }
}
