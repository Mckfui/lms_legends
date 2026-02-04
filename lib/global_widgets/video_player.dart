// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lsm_legends/models/course_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

class ChewieVideoPlayer extends StatefulWidget {
  final String? title;
  final VideoPlayerController videoPlayerController;
  final bool autoPlay;
  final bool looping;
  final bool? hideBookmark;
  final Lessons? lesson;
  final Topics? topic;
  final CourseModel? course;
  final Duration? startAt;
  final VoidCallback? onFinished;

  const ChewieVideoPlayer({
    super.key,
    required this.videoPlayerController,
    this.autoPlay = false,
    this.looping = false,
    this.hideBookmark,
    this.title,
    this.lesson,
    this.topic,
    this.course,
    this.startAt,
    this.onFinished,
  });

  @override
  _ChewieVideoPlayerState createState() => _ChewieVideoPlayerState();
}

class _ChewieVideoPlayerState extends State<ChewieVideoPlayer> {
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _chewieController = ChewieController(
      videoPlayerController: widget.videoPlayerController,
      autoPlay: widget.autoPlay,
      looping: widget.looping,
      aspectRatio: 16 / 9,
      allowMuting: true,
      startAt: widget.startAt,
      playbackSpeeds: [0.5, 1.0, 1.5, 2.0],
      additionalOptions: widget.hideBookmark == true
          ? null
          : (context) {
              return [
                OptionItem(
                  onTap: (context) {
                    Duration currentDuration =
                        _chewieController.videoPlayerController.value.position;
                    storeBookmark(currentDuration);
                  },
                  iconData: Icons.book,
                  title: 'Bookmark Current Time',
                ),
              ];
            },
    );

    widget.videoPlayerController.addListener(_videoListener);
  }

  void _videoListener() {
    if (widget.videoPlayerController.value.position ==
            widget.videoPlayerController.value.duration &&
        widget.videoPlayerController.value.duration != Duration.zero) {
      if (widget.onFinished != null) {
        widget.onFinished!();
      }
    }
  }

  void storeBookmark(Duration bookmarkedTime) {
    List<Map<String, dynamic>> bookmarks = [];
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.containsKey('bookmarks')) {
        // Retrieve existing bookmarks
        bookmarks = List<Map<String, dynamic>>.from(
          json.decode(prefs.getString('bookmarks')!),
        );
      }
      // Add the new bookmark
      bookmarks.add({
        'title': widget.lesson!.title,
        'time': bookmarkedTime.toString(),
        'lesson_url': widget.lesson!.lessonUrl,
        'topic': widget.topic!.title,
        'course_name': widget.course!.title,
        'course_thumbnail': widget.course!.thumbnail,
      });
      // Save the updated bookmarks
      prefs.setString('bookmarks', json.encode(bookmarks));
      Get.back();
      Get.snackbar('Added', 'Video bookmark added');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Chewie(key: UniqueKey(), controller: _chewieController),
        ),
      ),
    );
  }

  @override
  void dispose() {
    widget.videoPlayerController.removeListener(_videoListener);
    _chewieController.dispose();
    super.dispose();
  }
}
