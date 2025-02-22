import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quill/extensions.dart' as base;
import 'package:flutter_quill/flutter_quill.dart';
import 'package:math_keyboard/math_keyboard.dart';

import '../../../models/config/editor/video/video.dart';
import '../../utils.dart';
import '../../widgets/video_app.dart';
import '../../widgets/youtube_video_app.dart';

class QuillEditorVideoEmbedBuilder extends EmbedBuilder {
  const QuillEditorVideoEmbedBuilder({
    required this.configurations,
  });

  final QuillEditorVideoEmbedConfigurations configurations;

  @override
  String get key => BlockEmbed.videoType;

  @override
  Widget build(
    BuildContext context,
    QuillController controller,
    base.Embed node,
    bool readOnly,
    bool inline,
    TextStyle textStyle,
  ) {
    assert(!kIsWeb, 'Please provide video EmbedBuilder for Web');

    final videoUrl = node.value.data;
    if (isYouTubeUrl(videoUrl)) {
      return YoutubeVideoApp(
          videoUrl: videoUrl, context: context, readOnly: readOnly);
    }
    return VideoApp(
      videoUrl: videoUrl,
      context: context,
      readOnly: readOnly,
      onVideoInit: configurations.onVideoInit,
    );
  }
}

class QuillEditorFormulaEmbedBuilder extends EmbedBuilder {
  const QuillEditorFormulaEmbedBuilder();
  @override
  String get key => BlockEmbed.formulaType;

  @override
  Widget build(
    BuildContext context,
    QuillController controller,
    base.Embed node,
    bool readOnly,
    bool inline,
    TextStyle textStyle,
  ) {
    assert(!kIsWeb, 'Please provide formula EmbedBuilder for Web');

    final mathController = MathFieldEditingController();
    return Focus(
      onFocusChange: (hasFocus) {
        if (hasFocus) {
          // If the MathField is tapped, hides the built in keyboard
          SystemChannels.textInput.invokeMethod('TextInput.hide');
          debugPrint(mathController.currentEditingValue());
        }
      },
      child: MathField(
        controller: mathController,
        variables: const ['x', 'y', 'z'],
        onChanged: (value) {},
        onSubmitted: (value) {},
      ),
    );
  }
}
