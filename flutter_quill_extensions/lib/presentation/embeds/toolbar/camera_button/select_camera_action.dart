import 'package:flutter/material.dart';
import 'package:flutter_quill/translations.dart';

import '../../embed_types/camera.dart';

class SelectCameraActionDialog extends StatelessWidget {
  const SelectCameraActionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton.icon(
            icon: const Icon(
              Icons.camera,
            ),
            label: Text('Photo'.i18n),
            onPressed: () => Navigator.pop(context, CameraAction.image),
          ),
          TextButton.icon(
            icon: const Icon(
              Icons.video_call,
            ),
            label: Text('Video'.i18n),
            onPressed: () => Navigator.pop(context, CameraAction.video),
          )
        ],
      ),
    );
  }
}
