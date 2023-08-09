import 'package:flutter/material.dart';
import 'package:vimeo_video_player_custom/vimeo_video_player_custom.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vimeo Video Player',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Vimeo video player demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            VimeoVideoPlayer(
              url: 'https://vimeo.com/850781366',
              onFinished: () => onFinishedVimeo(),
              accessToken: '6cb00ffe357899a72e2426296a0d227e',
            ),
            VimeoVideoPlayer(
              url: 'https://vimeo.com/740663286',
              onFinished: () => onFinishedVimeo(),
              accessToken: '6cb00ffe357899a72e2426296a0d227e',
            ),
            VimeoVideoPlayer(
              url: 'https://vimeo.com/850092726',
              onFinished: () => onFinishedVimeo(),
              accessToken: '6cb00ffe357899a72e2426296a0d227e',
            ),
          ],
        ),
      ),
    );
  }

  void onFinishedVimeo() {
    debugPrint('onFinishedVimeo');
  }
}
