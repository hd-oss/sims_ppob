import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common/result_state.dart';
import '../../../common/snackbar_helper.dart';
import '../../../common/validation_helper.dart';
import '../../../data/models/user_model.dart';
import '../../../app_router.gr.dart';
import '../../controllers/profile_controller.dart';
import '../../providers/profile_provider.dart';

@RoutePage()
class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // addPostFrameCallbackOnce(() {
    //   final profileState = ref.read(profileProvider);
    //   if (profileState.userData == null) {

    //   }
    // });
  }

  void addPostFrameCallbackOnce(VoidCallback callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        callback();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(profileProvider);
    final _formKey = GlobalKey<FormState>();

    ref.listen<ProfileState>(profileProvider, (previous, next) {
      addPostFrameCallbackOnce(() {
        if (previous?.userData != next.userData &&
            next.userData?.status != Status.LOADING &&
            ((previous?.isEditEvent ?? false) ||
                (previous?.isEditImage ?? false))) {
          SnackbarHelper.showSnackBar(
              context,
              next.userData?.status == Status.SUCCESS
                  ? 'Berhasil edit profile'
                  : next.userData?.message ?? 'Gagal edit profile',
              next.userData?.status == Status.SUCCESS
                  ? Colors.green
                  : Colors.red);
        }
      });
    });

    if (profileState.userData?.status == Status.LOADING) {
      return const Center(child: CircularProgressIndicator());
    }

    final data = profileState.userData?.data;

    firstNameController.text = data?.firstName ?? '';
    lastNameController.text = data?.lastName ?? '';

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildProfileImage(data?.profileImage),
              const SizedBox(height: 16),
              _buildUserName(data),
              const SizedBox(height: 24),
              _buildFormField('Email', data?.email,
                  readOnly: true,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Image.asset('assets/icons/at.png', width: 5),
                  )),
              const SizedBox(height: 24),
              _buildFormField(
                'Nama Depan',
                firstNameController,
                isEditable: profileState.isEditEvent,
                readOnly: !profileState.isEditEvent,
                prefixIcon: const Icon(Icons.person_outline_rounded),
              ),
              const SizedBox(height: 24),
              _buildFormField(
                'Nama Belakang',
                lastNameController,
                isEditable: profileState.isEditEvent,
                readOnly: !profileState.isEditEvent,
                prefixIcon: const Icon(Icons.person_outline_rounded),
              ),
              const SizedBox(height: 24),
              _buildActionButton(
                  profileState.isEditEvent, _formKey.currentState?.validate()),
              const SizedBox(height: 24),
              _buildLogoutButton(context, profileState.isEditEvent),
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
                ? ref.read(profileProvider.notifier).editPicture(file: value)
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

  Widget _buildActionButton(bool isEdit, bool? isValidate) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: !isEdit ? Colors.red : Colors.white,
        foregroundColor: isEdit ? Colors.red : Colors.white,
      ),
      onPressed: () => isEdit
          ? ref
              .read(profileProvider.notifier)
              .editProfile(
                  firstName: firstNameController.text,
                  lastName: lastNameController.text)
              .then((value) => ref.read(profileProvider.notifier).editEvent())
          : ref.read(profileProvider.notifier).editEvent(),
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
        await ref.read(profileProvider.notifier).logout();
        if (!context.mounted) return;
        context.router
            .pushAndPopUntil(const LoginRoute(), predicate: (_) => false);
      },
      child: const Text('Logout'),
    );
  }
}
