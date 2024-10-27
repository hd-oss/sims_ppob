import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app_router.gr.dart';
import '../../../common/result_state.dart';
import '../../../common/snackbar_helper.dart';
import '../../../common/validation_helper.dart';
import '../../controllers/login_controller.dart';
import '../../providers/login_provider.dart';

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
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => ref.read(loginProvider.notifier).resetState());
    super.initState();
  }

  void _handleLoginState(BuildContext context, LoginState loginState) {
    final result = loginState.loginResult;

    if (result?.status == Status.SUCCESS) {
      SnackbarHelper.showSnackBar(
          context, result?.message ?? 'Login berhasil', Colors.green);
      context.router
          .pushAndPopUntil(const HomeRoute(), predicate: (_) => false);
    } else if (result?.status == Status.ERROR) {
      SnackbarHelper.showSnackBar(
          context, result?.message ?? 'Terjadi kesalahan', Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginProvider);

    ref.listen<LoginState>(loginProvider, (previous, next) {
      if (previous?.loginResult != next.loginResult) {
        WidgetsBinding.instance
            .addPostFrameCallback((_) => _handleLoginState(context, next));
      }
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
                  _buildFormFields(loginState),
                  const SizedBox(height: 48),
                  _buildLoginButton(ref, loginState),
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

  Widget _buildFormFields(LoginState loginState) {
    return Column(
      children: [
        _buildFormField(
          controller: emailController,
          hintText: 'Masukan email anda',
          icon: 'assets/icons/at.png',
          loginState: loginState,
          validator: (value) {
            return validateEmail(value) ?? requiredField(value);
          },
        ),
        const SizedBox(height: 24),
        _buildFormField(
          controller: passwordController,
          hintText: 'Masukan password anda',
          icon: Icons.lock_outline_rounded,
          loginState: loginState,
          suffixIcon: InkWell(
            onTap: () => ref.read(loginProvider.notifier).hidePassword(),
            borderRadius: BorderRadius.circular(100),
            child: Icon(loginState.isHide
                ? Icons.visibility_off_rounded
                : Icons.visibility_rounded),
          ),
          hide: loginState.isHide,
          validator: requiredField,
        ),
      ],
    );
  }

  Widget _buildFormField({
    required String hintText,
    required dynamic icon,
    required LoginState loginState,
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

  Widget _buildLoginButton(WidgetRef ref, LoginState loginState) {
    return loginState.loginResult?.status == Status.LOADING
        ? const CircularProgressIndicator()
        : ElevatedButton(
            onPressed: () => _formKey.currentState?.validate() ?? false
                ? ref
                    .read(loginProvider.notifier)
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
