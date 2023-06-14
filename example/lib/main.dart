import 'package:flutter/material.dart';
import 'package:vimeo_video_player/vimeo_video_player.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Vimeo video player demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              VimeoVideoPlayer(
                url: 'https://vimeo.com/157743578',
                onFinished: () => onFinishedVimeo(),
              ),
              VimeoVideoPlayer(
                url: 'https://vimeo.com/740663286',
                onFinished: () => onFinishedVimeo(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onFinishedVimeo() {
    print('onFinishedVimeo');
  }
}
