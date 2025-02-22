import 'package:flutter/widgets.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:universal_html/html.dart' as html;
import 'package:youtube_player_flutter/youtube_player_flutter.dart'
    show YoutubePlayer;

import '../../../models/config/editor/video/video_web.dart';
import '../../utils.dart';
import '../shims/dart_ui_fake.dart'
    if (dart.library.html) '../shims/dart_ui_real.dart' as ui;

class QuillEditorWebVideoEmbedBuilder extends EmbedBuilder {
  const QuillEditorWebVideoEmbedBuilder({
    required this.configurations,
  });

  final QuillEditorWebVideoEmbedConfigurations configurations;

  @override
  String get key => BlockEmbed.videoType;

  @override
  bool get expanded => false;

  @override
  Widget build(
    BuildContext context,
    QuillController controller,
    Embed node,
    bool readOnly,
    bool inline,
    TextStyle textStyle,
  ) {
    var videoUrl = node.value.data;
    if (isYouTubeUrl(videoUrl)) {
      final youtubeID = YoutubePlayer.convertUrlToId(videoUrl);
      if (youtubeID != null) {
        videoUrl = 'https://www.youtube.com/embed/$youtubeID';
      }
    }

    final size = MediaQuery.sizeOf(context);

    ui.PlatformViewRegistry().registerViewFactory(
      videoUrl,
      (id) => html.IFrameElement()
        ..width = size.width.toString()
        ..height = size.height.toString()
        ..src = videoUrl
        ..style.border = 'none',
    );

    return SizedBox(
      height: 500,
      child: HtmlElementView(
        viewType: videoUrl,
      ),
    );
  }
}
