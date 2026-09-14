import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../theme/tokens.dart';

/// Circular avatar: photo if available, initials fallback.
class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
    required this.name,
    this.photoUrl,
    this.initials,
    this.size = 44,
  });

  final String name;
  final String? photoUrl;
  final String? initials;
  final double size;

  String get _initials {
    if (initials != null && initials!.isNotEmpty) return initials!;
    final parts = name.trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty).toList();
    if (parts.isEmpty) return '?';
    if (parts.length == 1) {
      return String.fromCharCode(parts.first.runes.first).toUpperCase();
    }
    final a = String.fromCharCode(parts.first.runes.first);
    final b = String.fromCharCode(parts.last.runes.first);
    return '$a$b'.toUpperCase();
  }

  /// Local gallery photos are stored as file paths; anything else is a URL.
  bool get _isLocalFile {
    final url = photoUrl;
    if (url == null || url.isEmpty) return false;
    return url.startsWith('/') || url.startsWith('file://');
  }

  Widget _fallback(BuildContext context) => Container(
        width: size,
        height: size,
        color: AppPalette.surfaceHighest,
        alignment: Alignment.center,
        child: Text(_initials,
            style: TextStyle(
                color: AppPalette.textTertiary, fontSize: size * 0.36)),
      );

  @override
  Widget build(BuildContext context) {
    if (photoUrl != null && _isLocalFile) {
      final path = photoUrl!.startsWith('file://')
          ? Uri.parse(photoUrl!).toFilePath()
          : photoUrl!;
      return Semantics(
        label: 'Avatar for $name',
        child: ClipOval(
          child: Image.file(
            File(path),
            width: size,
            height: size,
            fit: BoxFit.cover,
            errorBuilder: (_, _, _) => _fallback(context),
          ),
        ),
      );
    }
    final avatar = photoUrl == null
        ? Container(
            width: size,
            height: size,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppPalette.emberSoft, AppPalette.emberDeep],
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              _initials,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: size * 0.36,
              ),
            ),
          )
        : ClipOval(
            child: CachedNetworkImage(
              imageUrl: photoUrl!,
              width: size,
              height: size,
              fit: BoxFit.cover,
              placeholder: (_, _) => Container(
                width: size,
                height: size,
                color: AppPalette.surfaceHighest,
              ),
              errorWidget: (_, _, _) => Container(
                width: size,
                height: size,
                color: AppPalette.surfaceHighest,
                alignment: Alignment.center,
                child: Text(_initials, style: TextStyle(color: AppPalette.textSecondary, fontSize: size * 0.36)),
              ),
            ),
          );

    return Semantics(
      label: 'Avatar for $name',
      child: avatar,
    );
  }
}

/// Spotify artwork with graceful fallback tile.
class ArtworkTile extends StatelessWidget {
  const ArtworkTile({super.key, this.url, this.size = 56, this.borderRadius});

  final String? url;
  final double size;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? AppRadius.sm;
    if (url == null) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: AppPalette.surfaceHighest,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Icon(Icons.music_note_rounded, size: size * 0.4, color: AppPalette.textTertiary),
      );
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: CachedNetworkImage(
        imageUrl: url!,
        width: size,
        height: size,
        fit: BoxFit.cover,
        placeholder: (_, _) => Container(width: size, height: size, color: AppPalette.surfaceHighest),
        errorWidget: (_, _, _) => Container(
          width: size,
          height: size,
          color: AppPalette.surfaceHighest,
          child: Icon(Icons.music_note_rounded, size: size * 0.4, color: AppPalette.textTertiary),
        ),
      ),
    );
  }
}
