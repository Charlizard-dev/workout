import 'dart:io';

import 'dart:async' show unawaited;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../core/services/app_dependencies.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/tokens.dart';
import '../../../../core/widgets/avatars.dart';
import '../../../../core/widgets/buttons.dart';
import '../../../authentication/data/session_controller.dart';
import '../../../dashboard/presentation/bloc/dashboard_bloc.dart';

/// Edit display name + profile photo. Photo is copied into app storage so
/// it survives gallery changes; the path is stored on the user row.
class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final TextEditingController _name;
  String? _pendingPhotoPath;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController(
        text: context.read<SessionController>().displayName);
  }

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  Future<void> _pickPhoto() async {
    unawaited(HapticFeedback.selectionClick());
    try {
      final picked = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 85,
      );
      if (picked == null || !mounted) return;
      // Copy into app documents so the avatar survives gallery moves.
      final docs = await getApplicationDocumentsDirectory();
      final ext = picked.path.split('.').last.toLowerCase();
      final safeExt = ['jpg', 'jpeg', 'png', 'webp'].contains(ext) ? ext : 'jpg';
      final target =
          File('${docs.path}/avatar_${DateTime.now().millisecondsSinceEpoch}.$safeExt');
      await File(picked.path).copy(target.path);
      if (!mounted) return;
      setState(() => _pendingPhotoPath = target.path);
    } on PlatformException {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(const SnackBar(
            content: Text(
                'Photo access was denied. Allow it in Settings to add a picture.')));
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
            const SnackBar(content: Text('Could not load that photo.')));
    }
  }

  Future<void> _save() async {
    final name = _name.text.trim();
    if (name.length < 2) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
            const SnackBar(content: Text('Enter a name to continue.')));
      return;
    }
    setState(() => _saving = true);
    final deps = context.read<AppDependencies>();
    final result = await deps.authRepository.updateProfile(
      name: name,
      photoPath: _pendingPhotoPath,
    );
    if (!mounted) return;
    setState(() => _saving = false);
    result.fold(
      (failure) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(failure.message)));
      },
      (_) {
        context.read<DashboardBloc>().add(const DashboardRefreshed());
        Navigator.of(context).pop(true);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final session = context.watch<SessionController>();
    final avatarPath = _pendingPhotoPath;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        leading: IconButton(
          icon: const Icon(AppIcons.close),
          onPressed: () => Navigator.of(context).pop(false),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg, AppSpacing.sm, AppSpacing.lg, AppSpacing.lg),
          child: PrimaryButton(
            label: _saving ? 'SAVING…' : 'SAVE CHANGES',
            onPressed: _saving ? null : _save,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.md,
          AppSpacing.lg,
          AppSpacing.xxxl,
        ),
        children: [
          Center(
            child: GestureDetector(
              onTap: _pickPhoto,
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  UserAvatar(
                    name: _name.text.trim().isEmpty
                        ? session.displayName
                        : _name.text.trim(),
                    photoUrl: avatarPath,
                    size: 112,
                  ),
                  Container(
                    width: 36,
                    height: 36,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppPalette.ember,
                    ),
                    child: const Icon(AppIcons.edit,
                        size: 18, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Center(
            child: TextButton(
              onPressed: _pickPhoto,
              child: Text(
                'CHANGE PHOTO',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: AppPalette.ember,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          Text(
            'DISPLAY NAME',
            style: theme.textTheme.labelMedium?.copyWith(
                color: AppPalette.textSecondary, letterSpacing: 1.2),
          ),
          const SizedBox(height: AppSpacing.sm),
          TextField(
            controller: _name,
            textCapitalization: TextCapitalization.words,
            maxLength: 30,
            onChanged: (_) => setState(() {}),
            decoration: const InputDecoration(
              hintText: 'What should we call you?',
              counterText: '',
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Your name appears on your profile, level card, and story shares.',
            style: theme.textTheme.bodySmall
                ?.copyWith(color: AppPalette.textTertiary),
          ),
        ],
      ),
    );
  }
}
