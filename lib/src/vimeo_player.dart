import 'dart:developer';
import 'package:chewie/chewie.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

import 'component/sheet_quality_comp.dart';
import 'model/vimeo_video_config.dart';

class VimeoVideoPlayer extends StatefulWidget {
  /// vimeo video url
  final String url;

  /// hide/show device status-bar
  final List<SystemUiOverlay> systemUiOverlay;

  /// deviceOrientation of video view
  final List<DeviceOrientation> deviceOrientation;

  /// If this value is set, video will have initial position
  /// set to given minute/second.
  ///
  /// Incorrect values (exceeding the video duration) will be ignored.
  final Duration? startAt;

  /// If this function is provided, it will be called periodically with
  /// current video position (approximately every 500 ms).
  final void Function(Duration timePoint)? onProgress;

  /// If this function is provided, it will be called when video
  /// finishes playback.
  final VoidCallback? onFinished;

  /// to auto-play the video once initialized
  final bool autoPlay;
  final bool looping;

  const VimeoVideoPlayer({
    required this.url,
    this.systemUiOverlay = const [
      SystemUiOverlay.top,
      SystemUiOverlay.bottom,
    ],
    this.deviceOrientation = const [
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
    this.startAt,
    this.onProgress,
    this.onFinished,
    this.autoPlay = false,
    this.looping = false,
    Key? key,
  }) : super(key: key);

  @override
  State<VimeoVideoPlayer> createState() => _VimeoVideoPlayerState();
}

class _VimeoVideoPlayerState extends State<VimeoVideoPlayer> {
  /// video player controller
  VideoPlayerController? _videoPlayerController;

  final VideoPlayerController _emptyVideoPlayerController = VideoPlayerController.network('');

  /// flick manager to manage the flick player

  late ChewieController _chewieController;

  // late BetterPlayerController _betterPlayerController;

  /// used to notify that video is loaded or not
  ValueNotifier<bool> isVimeoVideoLoaded = ValueNotifier(false);

  /// used to check that the url format is valid vimeo video format
  bool get _isVimeoVideo {
    var regExp = RegExp(
      r"^((https?)://)?(www.)?vimeo\.com/(\d+).*$",
      caseSensitive: false,
      multiLine: false,
    );
    final match = regExp.firstMatch(widget.url);
    if (match != null && match.groupCount >= 1) return true;
    return false;
  }

  /// used to check that the video is already seeked or not
  bool _isSeekedVideo = false;

  List<VimeoProgressive?> vimeoProgressiveList = [];

  VimeoProgressive? vimeoProgressiveSelected;

  @override
  void initState() {
    super.initState();

    /// checking that vimeo url is valid or not
    if (_isVimeoVideo) {
      _videoPlayer();
    }
  }

  @override
  void deactivate() {
    _videoPlayerController?.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    /// disposing the controllers
    _videoPlayerController?.dispose();
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    ); // to re-show bars
    super.dispose();
  }

  void _setVideoInitialPosition() {
    final Duration? startAt = widget.startAt;

    if (startAt != null && _videoPlayerController != null) {
      _videoPlayerController!.addListener(() {
        final VideoPlayerValue videoData = _videoPlayerController!.value;
        if (videoData.isInitialized && videoData.duration > startAt && !_isSeekedVideo) {
          _videoPlayerController!.seekTo(startAt);
          _isSeekedVideo = true;
        } // else ignore, incorrect value
      });
    }
  }

  void _setVideoListeners() {
    final onProgressCallback = widget.onProgress;
    final onFinishCallback = widget.onFinished;
    bool isFinish =false;

    if (_videoPlayerController != null && (onProgressCallback != null || onFinishCallback != null)) {
      _videoPlayerController!.addListener(() {
        final VideoPlayerValue videoData = _videoPlayerController!.value;
        if (videoData.isInitialized) {
          if (videoData.isPlaying) {
            if (onProgressCallback != null) {
              onProgressCallback.call(videoData.position);
            }
          } else if (videoData.duration == videoData.position) {
            if (onFinishCallback != null) {
              onFinishCallback.call();
            }
          }
        }
      });
    }
  }

  void _videoPlayer() {
    /// getting the vimeo video configuration from api and setting managers
    _getVimeoVideoConfigFromUrl(widget.url).then((value) async {
      vimeoProgressiveList = value?.request?.files?.progressive ?? [];
      var vimeoMp4Video = '';

      if (vimeoProgressiveList.isNotEmpty) {
        vimeoProgressiveList.map((element) {
          if (element != null && element.url != null && element.url != '' && vimeoMp4Video == '') {
            vimeoMp4Video = element.url ?? '';
          }
        }).toList();
        if (vimeoMp4Video.isEmpty || vimeoMp4Video == '') {
          showAlertDialog(context);
        }
      }
      print('kkkkkkkkkkkk $vimeoMp4Video');

      _videoPlayerController = VideoPlayerController.network(vimeoMp4Video);
      _videoPlayerController?.initialize().then((_) {
        print('hhhhhhhhhhhhhhhgggggggggg ${_videoPlayerController?.value.duration}');
        setState(
          () => _chewieController = ChewieController(
            videoPlayerController: _videoPlayerController ?? _emptyVideoPlayerController,
            autoPlay: widget.autoPlay,
            looping: widget.looping,
            aspectRatio: _videoPlayerController?.value.aspectRatio,
            additionalOptions: (context) => <OptionItem>[
              OptionItem(
                onTap: () => _onPressQualityOption(),
                iconData: Icons.hd_outlined,
                title: 'Quality',
              ),
            ],
          ),
        );
      });
      _setVideoInitialPosition();
      _setVideoListeners();

      isVimeoVideoLoaded.value = !isVimeoVideoLoaded.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('hhhhhhhhhhhh ${_videoPlayerController?.value.aspectRatio}');

    return ValueListenableBuilder(
      valueListenable: isVimeoVideoLoaded,
      builder: (context, bool isVideo, child) => Container(
        child: isVideo
            ? LayoutBuilder(
                builder: (context, size) {
                  double aspectRatio = (size.maxHeight == double.infinity || size.maxWidth == double.infinity)
                      ? (_videoPlayerController?.value.isInitialized == true ? _videoPlayerController?.value.aspectRatio : (16 / 9))!
                      : size.maxWidth / size.maxHeight;

                  return AspectRatio(
                    aspectRatio: aspectRatio,
                    child: _videoPlayerController?.value.isInitialized == true
                        ? Container(
                            height: _videoPlayerController?.value.size.height,
                            width: _videoPlayerController?.value.size.width,
                            child: Chewie(key: ObjectKey(_chewieController), controller: _chewieController),
                          )
                        : Container(),
                  );
                },
              )
            : const Center(
                child: CircularProgressIndicator(
                  color: Colors.grey,
                  backgroundColor: Colors.white,
                ),
              ),
      ),
    );
  }

  /// used to get valid vimeo video configuration
  Future<VimeoVideoConfig?> _getVimeoVideoConfigFromUrl(
    String url, {
    bool trimWhitespaces = true,
  }) async {
    if (trimWhitespaces) url = url.trim();

    /// here i'm converting the vimeo video id only and calling config api for vimeo video .mp4
    /// supports this types of urls
    /// https://vimeo.com/70591644 => 70591644
    /// www.vimeo.com/70591644 => 70591644
    /// vimeo.com/70591644 => 70591644
    var vimeoVideoId = '';
    var videoIdGroup = 4;
    for (var exp in [
      RegExp(r"^((https?)://)?(www.)?vimeo\.com/(\d+).*$"),
    ]) {
      RegExpMatch? match = exp.firstMatch(url);
      if (match != null && match.groupCount >= 1) {
        vimeoVideoId = match.group(videoIdGroup) ?? '';
      }
    }

    final response = await _getVimeoVideoConfig(vimeoVideoId: vimeoVideoId);
    return (response != null) ? response : null;
  }

  /// give vimeo video configuration from api
  Future<VimeoVideoConfig?> _getVimeoVideoConfig({
    required String vimeoVideoId,
  }) async {
    try {
      Response responseData = await Dio().get(
        'https://player.vimeo.com/video/$vimeoVideoId/config',
      );
      var vimeoVideo = VimeoVideoConfig.fromJson(responseData.data);
      return vimeoVideo;
    } on DioException catch (e) {
      log('Dio Error : ', name: e.error.toString());
      return null;
    } on Exception catch (e) {
      log('Error : ', name: e.toString());
      return null;
    }
  }

  Future<void> _onPressQualityOption() async {
    Navigator.pop(context);
    dynamic response = await showModalBottomSheet(
        context: context,
        builder: (context) => SheetQualityComp(vimeoProgressiveList: vimeoProgressiveList, vimeoProgressiveSelected: vimeoProgressiveSelected));
    if (response != null) {
      vimeoProgressiveSelected = response;
      Duration? duration = await _chewieController.videoPlayerController.position;
      _videoPlayerController = VideoPlayerController.network(vimeoProgressiveSelected?.url);
      _videoPlayerController?.initialize().then(
            (_) => setState(
              () => _chewieController = ChewieController(
                videoPlayerController: _videoPlayerController ?? _emptyVideoPlayerController,
                autoPlay: widget.autoPlay,
                looping: widget.looping,
                aspectRatio: _videoPlayerController?.value.aspectRatio,
                additionalOptions: (context) => <OptionItem>[
                  OptionItem(onTap: () => _onPressQualityOption(), iconData: Icons.hd_outlined, title: 'Quality'),
                ],
              )..seekTo(duration ?? Duration(seconds: 0)),
            ),
          );
      setState(() {});
    }
  }
}

// ignore: library_private_types_in_public_api
extension ShowAlertDialog on _VimeoVideoPlayerState {
  showAlertDialog(BuildContext context) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Alert"),
      content: const Text("Some thing wrong with this url"),
      actions: [
        TextButton(
          child: const Text("OK"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
