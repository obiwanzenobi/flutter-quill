import 'package:flutter/widgets.dart' show BuildContext;
import 'package:flutter_quill/flutter_quill.dart';
import 'package:meta/meta.dart' show immutable;

import '../../services/image_picker/s_image_picker.dart';
import '../../services/image_saver/s_image_saver.dart';

/// Configurations for Flutter Quill Extensions
/// that is shared between the toolbar and editor for the extensions package
///
/// Example on how to setup it:
///
/// ```dart
/// QuillProvider(
///   configurations: QuillConfigurations(
///     sharedConfigurations: const QuillSharedConfigurations(
///       extraConfigurations: {
///         QuillSharedExtensionsConfigurations.key:
///             QuillSharedExtensionsConfigurations(
///  // Feel free to explore it
///         ),
///       },
///     ),
///     controller: _controller,
///   ),
///   child: const Column(
///     children: [
///       // QuillToolbar
///       // QuillEditor
///       // ...
///     ],
//   ),
/// )
/// ```
@immutable
class QuillSharedExtensionsConfigurations {
  const QuillSharedExtensionsConfigurations({
    ImagePickerService? imagePickerService,
    ImageSaverService? imageSaverService,
  })  : _imagePickerService = imagePickerService,
        _imageSaverService = imageSaverService;

  /// Get the instance from the widget tree in [QuillSharedConfigurations]
  /// if it doesn't exists, we will create new one with default options
  factory QuillSharedExtensionsConfigurations.get({
    required BuildContext context,
  }) {
    final quillSharedExtensionsConfigurations =
        context.requireQuillSharedConfigurations.extraConfigurations[key];
    if (quillSharedExtensionsConfigurations != null) {
      if (quillSharedExtensionsConfigurations
          is! QuillSharedExtensionsConfigurations) {
        throw ArgumentError(
          'The value of key `$key` should be of type '
          'QuillSharedExtensionsConfigurations',
        );
      }
      return quillSharedExtensionsConfigurations;
    }
    return const QuillSharedExtensionsConfigurations();
  }

  /// The key to be used in the `extraConfigurations` property
  /// which can be found in the [QuillSharedConfigurations]
  /// which lives in the [QuillConfigurations]
  ///
  /// which exists in the [QuillProvider]
  static const String key = 'quillSharedExtensionsConfigurations';

  /// Defaults to [ImagePickerService.defaultImpl]
  final ImagePickerService? _imagePickerService;

  /// A getter method which returns the [ImagePickerService] that is provided
  /// by the developer, if it can't be found then we will use default impl
  ImagePickerService get imagePickerService {
    return _imagePickerService ?? ImagePickerService.defaultImpl();
  }

  /// Default to [ImageSaverService.defaultImpl]
  final ImageSaverService? _imageSaverService;

  /// A getter method which returns the [ImageSaverService] that is provided
  /// by the developer, if it can't be found then we will use default impl
  ImageSaverService get imageSaverService {
    return _imageSaverService ?? ImageSaverService.defaultImpl();
  }
}
