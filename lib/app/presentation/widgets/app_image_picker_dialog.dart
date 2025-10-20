import 'dart:io';

import 'package:corehive_store/app/config/theme/color_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

import '../../config/clients/storage/storage_client.dart';
import '../../config/helpers/logging_helper.dart';
import 'app_text.dart';

showAppImageDialog({
  required BuildContext context,
  required Function(File image) onFilePicked,
}) {
  showCupertinoModalPopup(
    context: context,
    builder: (BuildContext context) =>
        _ImagePickerDialog(onFilePicked: onFilePicked),
  );
}

class _ImagePickerDialog extends StatelessWidget {
  final Function(File image) onFilePicked;

  const _ImagePickerDialog({required this.onFilePicked});

  @override
  Widget build(BuildContext context) {
    final storage = StorageClient();
    final isAr = storage.isAr();
    final isDark = storage.isDarkMode();

    return CupertinoTheme(
      data: CupertinoThemeData(
        brightness: isDark ? Brightness.dark : Brightness.light,
        scaffoldBackgroundColor: context.kBackgroundColor,
      ),
      child: CupertinoActionSheet(
        cancelButton: CupertinoButton(
          onPressed: () => Navigator.pop(context),
          color: context.kBackgroundColor,
          child: AppText(
            text: isAr ? 'إغلاق' : 'Close',
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          _buildPickerButton(
            context,
            icon: CupertinoIcons.photo_camera_solid,
            label: isAr ? 'الكاميرا' : 'Camera',
            onTap: () async {
              Navigator.pop(context);
              await _pickAndHandleImage(fromGallery: false);
            },
          ),
          _buildPickerButton(
            context,
            icon: Icons.insert_photo,
            label: isAr ? 'الاستوديو' : 'Gallery',
            onTap: () async {
              Navigator.pop(context);
              await _pickAndHandleImage(fromGallery: true);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPickerButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return CupertinoButton(
      color: context.kBackgroundColor,
      onPressed: onTap,
      child: Row(
        children: [
          Icon(icon, color: context.kPrimaryColor),
          const SizedBox(width: 20),
          AppText(text: label, fontSize: 16, fontWeight: FontWeight.w700),
        ],
      ),
    );
  }

  Future<void> _pickAndHandleImage({required bool fromGallery}) async {
    try {
      final picker = ImagePicker();
      final XFile? media = await picker.pickImage(
        source: fromGallery ? ImageSource.gallery : ImageSource.camera,
      );

      if (media != null) {
        final compressed = await _compressImage(File(media.path));
        if (compressed != null) {
          onFilePicked(File(compressed.path));
        } else {
          // fallback: send original
          onFilePicked(File(media.path));
        }
      }
    } catch (e) {
      AppLogger.log('Image pick error: $e');
    }
  }

  Future<XFile?> _compressImage(File file) async {
    try {
      final dir = await getTemporaryDirectory();
      final targetPath = path.join(
        dir.absolute.path,
        'compressed_${DateTime.now().millisecondsSinceEpoch}${path.extension(file.path)}',
      );

      final result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        targetPath,
        quality: 70, // adjust quality (0-100)
      );

      return result;
    } catch (e) {
      AppLogger.log('Image compress error: $e');
      return null;
    }
  }
}
