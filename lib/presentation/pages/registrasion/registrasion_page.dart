import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/result_state.dart';
import '../../../common/snackbar_helper.dart';
import '../../../common/validation_helper.dart';
import '../../controllers/regist_controller.dart';
import '../../providers/regist_provider.dart';

@RoutePage()
class RegistrasionPage extends ConsumerStatefulWidget {
  const RegistrasionPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RegistrasionPageState();
}

class _RegistrasionPageState extends ConsumerState<RegistrasionPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => ref.read(registProvider.notifier).resetState());
    super.initState();
  }

  void _handleRegistState(BuildContext context, RegistState registState) {
    final result = registState.registResult;
    if (result?.status == Status.SUCCESS) {
      SnackbarHelper.showSnackBar(
          context, result?.message ?? 'Registrasi berhasil', Colors.green);
      Navigator.pop(context);
    } else if (result?.status == Status.ERROR) {
      SnackbarHelper.showSnackBar(
          context, result?.message ?? 'Terjadi kesalahan', Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    final registState = ref.watch(registProvider);

    ref.listen<RegistState>(registProvider, (previous, next) {
      if (previous?.registResult != next.registResult) {
        WidgetsBinding.instance
            .addPostFrameCallback((_) => _handleRegistState(context, next));
      }
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
                  _buildFormFields(registState),
                  const SizedBox(height: 48),
                  _buildRegisterButton(ref, registState),
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
    return  Text(
      'Lengkapi data untuk membuat akun',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: MediaQuery.sizeOf(context).width /13),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildFormFields(RegistState registState) {
    return Column(
      children: [
        _buildFormField('email',
            hintText: 'Masukan email anda',
            icon: 'assets/icons/at.png',
            registState: registState,
            validator: (value) => validateEmail(value) ?? requiredField(value)),
        const SizedBox(height: 24),
        _buildFormField('first_name',
            hintText: 'Nama depan',
            icon: Icons.person,
            registState: registState,
            validator: requiredField),
        const SizedBox(height: 24),
        _buildFormField('last_name',
            hintText: 'Nama belakang',
            icon: Icons.person,
            registState: registState,
            validator: requiredField),
        const SizedBox(height: 24),
        _buildFormField(
          'password',
          hintText: 'Buat password anda',
          icon: Icons.lock_outline_rounded,
          registState: registState,
          suffixIcon: InkWell(
            onTap: () => ref.read(registProvider.notifier).hidePassword(),
            borderRadius: BorderRadius.circular(100),
            child: Icon(registState.isHide
                ? Icons.visibility_off_rounded
                : Icons.visibility_rounded),
          ),
          hide: registState.isHide,
          validator: (value) => validatePassword(value) ??
            requiredField(value),
        ),
        const SizedBox(height: 24),
        _buildFormField(
          'password_confirm',
          hintText: 'Konfirmasi password',
          icon: Icons.lock_outline_rounded,
          registState: registState,
          suffixIcon: InkWell(
            onTap: () => ref.read(registProvider.notifier).hidePasswordConfrm(),
            borderRadius: BorderRadius.circular(100),
            child: Icon(
              registState.isHideCofirm
                  ? Icons.visibility_off_rounded
                  : Icons.visibility_rounded,
            ),
          ),
          hide: registState.isHideCofirm,
          validator: (value) {
            if (value != registState.params?.password) {
              return 'Password tidak sama';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildFormField(
    String attribute, {
    required String hintText,
    required dynamic icon,
    required RegistState registState,
    bool hide = false,
    Widget? suffixIcon,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      initialValue: registState.params?.toJson()[attribute] ?? '',
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
      onChanged: (value) =>
          ref.read(registProvider.notifier).setParams(attribute, value),
      obscureText: hide,
      validator: validator,
      textInputAction: TextInputAction.next,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget _buildRegisterButton(WidgetRef ref, RegistState registState) {
    return registState.registResult?.status == Status.LOADING
        ? const CircularProgressIndicator()
        : ElevatedButton(
            onPressed: () => _formKey.currentState?.validate() ?? false
                ? ref.read(registProvider.notifier).regist()
                : null,
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
