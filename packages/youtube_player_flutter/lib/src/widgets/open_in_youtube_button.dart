import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../youtube_player_flutter.dart';

/// A widget for youtube controller to open in youtube
class OpenInYoutubeButton extends StatelessWidget {
  /// Overrides the default [YoutubePlayerController].
  final YoutubePlayerController controller;

  /// Constructor for OpenInYoutubeButton
  OpenInYoutubeButton(this.controller);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: "Watch on Youtube",
        icon: Image.asset(
          'misc/youtube.png',
          package: 'youtube_player_flutter',
          width: 20.0,
          height: 20.0,
          color: Colors.white,
        ),
        onPressed: () async {
          {
            String videoId = controller.metadata.videoId;
            if (videoId.isEmpty)
              videoId = controller.initialVideoId;
            if (await canLaunch(
                "https://www.youtube.com/watch?v=$videoId")) {
              final _nativeAppLaunchSucceeded = await launch(
                "https://www.youtube.com/watch?v=$videoId",
                forceSafariVC: false,
                universalLinksOnly: true,
              );
              if (!_nativeAppLaunchSucceeded) {
                await launch("https://www.youtube.com/watch?v=$videoId",
                    forceSafariVC: true);
              }
            }
          }
        });
  }
}
