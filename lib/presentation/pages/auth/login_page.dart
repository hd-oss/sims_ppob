import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app_router.gr.dart';
import '../../../common/snackbar_helper.dart';
import '../../../common/validation_helper.dart';
import '../../controllers/login_controller.dart';

@RoutePage()
class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => ref.read(loginUiProvider.notifier).reset());
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isHide = ref.watch(loginUiProvider);
    final loginState = ref.watch(loginAuthProvider);

    ref.listen<AsyncValue<void>>(loginAuthProvider, (previous, next) {
      next.whenOrNull(
        data: (_) {
          if (previous is AsyncLoading) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              SnackbarHelper.showSnackBar(
                  context, 'Login berhasil', Colors.green);
              context.router
                  .pushAndPopUntil(const HomeRoute(), predicate: (_) => false);
            });
          }
        },
        error: (error, _) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            SnackbarHelper.showSnackBar(context, error.toString(), Colors.red);
          });
        },
      );
    });

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLogo(),
                  const SizedBox(height: 48),
                  _buildIntroText(),
                  const SizedBox(height: 48),
                  _buildFormFields(isHide),
                  const SizedBox(height: 48),
                  _buildLoginButton(loginState),
                  const SizedBox(height: 24),
                  _buildRegisterLink(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/icons/Logo.png', width: 35),
        const SizedBox(width: 8),
        const Text(
          'SIMS PPOB',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ],
    );
  }

  Widget _buildIntroText() {
    return Text(
      'Masuk atau buat akun untuk memulai',
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: MediaQuery.sizeOf(context).width / 13),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildFormFields(bool isHide) {
    return Column(
      children: [
        _buildFormField(
          controller: emailController,
          hintText: 'Masukan email anda',
          icon: 'assets/icons/at.png',
          validator: (value) {
            return validateEmail(value) ?? requiredField(value);
          },
        ),
        const SizedBox(height: 24),
        _buildFormField(
          controller: passwordController,
          hintText: 'Masukan password anda',
          icon: Icons.lock_outline_rounded,
          suffixIcon: InkWell(
            onTap: () => ref.read(loginUiProvider.notifier).toggleHide(),
            borderRadius: BorderRadius.circular(100),
            child: Icon(isHide
                ? Icons.visibility_off_rounded
                : Icons.visibility_rounded),
          ),
          hide: isHide,
          validator: requiredField,
        ),
      ],
    );
  }

  Widget _buildFormField({
    required String hintText,
    required dynamic icon,
    bool hide = false,
    Widget? suffixIcon,
    String? Function(String?)? validator,
    required TextEditingController controller,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        suffixIcon: suffixIcon,
        prefixIcon: icon is IconData
            ? Icon(icon, color: Colors.grey)
            : Padding(
                padding: const EdgeInsets.all(15.0),
                child: Image.asset(icon, color: Colors.grey, width: 5),
              ),
      ),
      obscureText: hide,
      validator: validator,
      textInputAction: TextInputAction.next,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget _buildLoginButton(AsyncValue<void> loginState) {
    return loginState.isLoading
        ? const CircularProgressIndicator()
        : ElevatedButton(
            onPressed: () => _formKey.currentState?.validate() ?? false
                ? ref
                    .read(loginAuthProvider.notifier)
                    .login(emailController.text, passwordController.text)
                : null,
            child: const Text('Masuk'),
          );
  }

  Widget _buildRegisterLink(BuildContext context) {
    return Center(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: 'Belum punya akun? Registrasi ',
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
          children: [
            TextSpan(
                text: 'disini',
                style: const TextStyle(
                    color: Colors.red, fontWeight: FontWeight.w600),
                recognizer: TapGestureRecognizer()
                  ..onTap =
                      () => context.router.push(const RegistrasionRoute())),
          ],
        ),
      ),
    );
  }
}
