import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common/snackbar_helper.dart';
import '../../../common/validation_helper.dart';
import '../../../data/models/user_model.dart';
import '../../../app_router.gr.dart';
import '../../../di/usecase_providers.dart';
import '../../controllers/profile_controller.dart';

@RoutePage()
class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(profileControllerProvider);
    final isEdit = ref.watch(profileUiProvider);
    final actionState = ref.watch(profileActionProvider);

    // Side-effect: snackbar saat aksi edit profil/foto selesai (sukses/gagal).
    ref.listen<AsyncValue<void>>(profileActionProvider, (previous, next) {
      next.whenOrNull(
        data: (_) {
          if (previous is AsyncLoading) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              SnackbarHelper.showSnackBar(
                  context, 'Berhasil edit profile', Colors.green);
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

    return profileState.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => _buildError(error),
      data: (user) => _buildContent(user, isEdit, actionState),
    );
  }

  Widget _buildError(Object error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(error.toString(), textAlign: TextAlign.center),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () => ref.invalidate(profileControllerProvider),
              child: const Text('Coba Lagi'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(UserModel data, bool isEdit, AsyncValue<void> actionState) {
    // Sinkronkan field hanya saat tidak dalam mode edit agar tidak menimpa
    // input pengguna selama mengedit.
    if (!isEdit) {
      firstNameController.text = data.firstName ?? '';
      lastNameController.text = data.lastName ?? '';
    }

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildProfileImage(data.profileImage),
              const SizedBox(height: 16),
              _buildUserName(data),
              const SizedBox(height: 24),
              _buildFormField('Email', data.email,
                  readOnly: true,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Image.asset('assets/icons/at.png', width: 5),
                  )),
              const SizedBox(height: 24),
              _buildFormField(
                'Nama Depan',
                firstNameController,
                isEditable: isEdit,
                readOnly: !isEdit,
                prefixIcon: const Icon(Icons.person_outline_rounded),
              ),
              const SizedBox(height: 24),
              _buildFormField(
                'Nama Belakang',
                lastNameController,
                isEditable: isEdit,
                readOnly: !isEdit,
                prefixIcon: const Icon(Icons.person_outline_rounded),
              ),
              const SizedBox(height: 24),
              _buildActionButton(isEdit, actionState),
              const SizedBox(height: 24),
              _buildLogoutButton(context, isEdit),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileImage(String? imageUrl) {
    return Stack(
      children: [
        Container(
          height: 150,
          width: 150,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(width: 2, color: Colors.grey)),
          child: (imageUrl ?? 'null').split('/').last == 'null'
              ? Image.asset('assets/icons/Profile Photo-1.png',
                  fit: BoxFit.cover)
              : Image.network(imageUrl!,
                  fit: BoxFit.fill,
                  errorBuilder: (_, error, __) => Image.asset(
                      'assets/icons/Profile Photo-1.png',
                      fit: BoxFit.cover),
                  loadingBuilder: (_, child, ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(child: CircularProgressIndicator());
                  }),
        ),
        Positioned(
          bottom: -2,
          right: 5,
          child: IconButton.outlined(
            onPressed: () => _imagePicker().then((value) => value != null
                ? ref.read(profileActionProvider.notifier).editImage(value)
                : null),
            icon: const Icon(Icons.edit_rounded),
            style: IconButton.styleFrom(backgroundColor: Colors.white),
          ),
        )
      ],
    );
  }

  Widget _buildUserName(UserModel? data) {
    return Text('${data?.firstName ?? ''} ${data?.lastName ?? ''}',
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center);
  }

  Widget _buildFormField(String? label, dynamic initialValue,
      {bool isEditable = false, bool readOnly = false, Widget? prefixIcon}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label ?? '-',
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
        const SizedBox(height: 8),
        TextFormField(
          initialValue: initialValue is String ? initialValue : null,
          controller:
              initialValue is TextEditingController ? initialValue : null,
          readOnly: readOnly,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            prefixIcon: prefixIcon,
          ),
          keyboardType: TextInputType.emailAddress,
          validator: isEditable ? requiredField : null,
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ),
      ],
    );
  }

  Future<File?> _imagePicker() async {
    final ImagePicker picker = ImagePicker();

    return await showModalBottomSheet<ImageSource?>(
      context: context,
      backgroundColor: Colors.white,
      builder: (context) => Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
        child: ListView(
            padding: const EdgeInsets.all(16),
            shrinkWrap: true,
            children: [
              const Text(
                'Ambil gambar dari: ',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              const SizedBox(height: 16),
              Row(children: [
                Expanded(
                  child: OutlinedButton(
                      child: const Icon(Icons.camera_alt_rounded),
                      onPressed: () =>
                          Navigator.pop(context, ImageSource.camera)),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                      child: const Icon(Icons.image_rounded),
                      onPressed: () =>
                          Navigator.pop(context, ImageSource.gallery)),
                ),
              ]),
            ]),
      ),
    ).then((value) => value != null
        ? picker.pickImage(source: value).then((value) => File(value!.path))
        : null);
  }

  Widget _buildActionButton(bool isEdit, AsyncValue<void> actionState) {
    if (actionState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: !isEdit ? Colors.red : Colors.white,
        foregroundColor: isEdit ? Colors.red : Colors.white,
      ),
      onPressed: () async {
        if (!isEdit) {
          ref.read(profileUiProvider.notifier).toggleEdit();
          return;
        }
        if (_formKey.currentState?.validate() ?? false) {
          await ref.read(profileActionProvider.notifier).editProfile(
                firstName: firstNameController.text,
                lastName: lastNameController.text,
              );
          ref.read(profileUiProvider.notifier).toggleEdit();
        }
      },
      child: Text(!isEdit ? 'Edit Profile' : 'Simpan'),
    );
  }

  Widget _buildLogoutButton(BuildContext context, bool isEdit) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: isEdit ? Colors.red : Colors.white,
        foregroundColor: !isEdit ? Colors.red : Colors.white,
      ),
      onPressed: () async {
        await ref.read(authUseCaseProvider).logout();
        if (!context.mounted) return;
        context.router
            .pushAndPopUntil(const LoginRoute(), predicate: (_) => false);
      },
      child: const Text('Logout'),
    );
  }
}
