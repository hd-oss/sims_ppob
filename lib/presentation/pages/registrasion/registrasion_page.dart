import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/snackbar_helper.dart';
import '../../../common/validation_helper.dart';
import '../../../data/models/regist_model.dart';
import '../../controllers/regist_controller.dart';

@RoutePage()
class RegistrasionPage extends ConsumerStatefulWidget {
  const RegistrasionPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RegistrasionPageState();
}

class _RegistrasionPageState extends ConsumerState<RegistrasionPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => ref.read(registUiProvider.notifier).reset());
  }

  @override
  void dispose() {
    emailController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      final params = RegistModel(
        email: emailController.text,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        password: passwordController.text,
        confirmPassword: passwordConfirmController.text,
      );
      ref.read(registAuthProvider.notifier).regist(params);
    }
  }

  @override
  Widget build(BuildContext context) {
    final registUi = ref.watch(registUiProvider);
    final registState = ref.watch(registAuthProvider);

    ref.listen<AsyncValue<void>>(registAuthProvider, (previous, next) {
      next.whenOrNull(
        data: (_) {
          if (previous is AsyncLoading) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              SnackbarHelper.showSnackBar(
                  context, 'Registrasi berhasil', Colors.green);
              Navigator.pop(context);
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
                  _buildFormFields(registUi),
                  const SizedBox(height: 48),
                  _buildRegisterButton(registState),
                  const SizedBox(height: 24),
                  _buildLoginLink(context),
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
      'Lengkapi data untuk membuat akun',
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: MediaQuery.sizeOf(context).width / 13),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildFormFields(RegistUiState registUi) {
    return Column(
      children: [
        _buildFormField(
            controller: emailController,
            hintText: 'Masukan email anda',
            icon: 'assets/icons/at.png',
            validator: (value) => validateEmail(value) ?? requiredField(value)),
        const SizedBox(height: 24),
        _buildFormField(
            controller: firstNameController,
            hintText: 'Nama depan',
            icon: Icons.person,
            validator: requiredField),
        const SizedBox(height: 24),
        _buildFormField(
            controller: lastNameController,
            hintText: 'Nama belakang',
            icon: Icons.person,
            validator: requiredField),
        const SizedBox(height: 24),
        _buildFormField(
          controller: passwordController,
          hintText: 'Buat password anda',
          icon: Icons.lock_outline_rounded,
          suffixIcon: InkWell(
            onTap: () => ref.read(registUiProvider.notifier).toggleHide(),
            borderRadius: BorderRadius.circular(100),
            child: Icon(registUi.isHide
                ? Icons.visibility_off_rounded
                : Icons.visibility_rounded),
          ),
          keyboardType: TextInputType.visiblePassword,
          hide: registUi.isHide,
          validator: (value) => validatePassword(value) ?? requiredField(value),
        ),
        const SizedBox(height: 24),
        _buildFormField(
          controller: passwordConfirmController,
          hintText: 'Konfirmasi password',
          icon: Icons.lock_outline_rounded,
          suffixIcon: InkWell(
            onTap: () =>
                ref.read(registUiProvider.notifier).toggleHideConfirm(),
            borderRadius: BorderRadius.circular(100),
            child: Icon(
              registUi.isHideCofirm
                  ? Icons.visibility_off_rounded
                  : Icons.visibility_rounded,
            ),
          ),
          keyboardType: TextInputType.visiblePassword,
          hide: registUi.isHideCofirm,
          validator: (value) {
            if (value != passwordController.text) {
              return 'Password tidak sama';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildFormField({
    required TextEditingController controller,
    required String hintText,
    required dynamic icon,
    TextInputType? keyboardType,
    bool hide = false,
    Widget? suffixIcon,
    String? Function(String?)? validator,
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
                )),
      obscureText: hide,
      keyboardType: keyboardType,
      validator: validator,
      textInputAction: TextInputAction.next,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget _buildRegisterButton(AsyncValue<void> registState) {
    return registState.isLoading
        ? const CircularProgressIndicator()
        : ElevatedButton(
            onPressed: _onSubmit,
            child: const Text('Registrasi'),
          );
  }

  Widget _buildLoginLink(BuildContext context) {
    return Center(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: 'Sudah punya akun? login ',
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
          children: [
            TextSpan(
                text: 'disini',
                style: const TextStyle(
                    color: Colors.red, fontWeight: FontWeight.w600),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => Navigator.pop(context)),
          ],
        ),
      ),
    );
  }
}
