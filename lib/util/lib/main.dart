// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:io';

final List<String> data = [];

main(List<String> args) async {
  data.clear();
  await _writeFile();
}

Future<void> recursive(Directory dir) async {
  final List<FileSystemEntity> entities = await dir.list().toList();

  Iterable<File> files = entities.whereType<File>();

  Iterable<Directory> directories = entities.whereType<Directory>();

  int index = dir.path.replaceAll('\\', '/').indexOf('/lib');

  for (var element in files) {
    String path = element.path.replaceAll('\\', '/').replaceRange(0, index + 4, '.');
    if (path.contains('util/')) break;
    data.add('export \'$path\';');
    print(path);
  }

  if (directories.isEmpty) return;
  await Future.forEach(directories, recursive);
}

FutureOr _writeFile() async {
  print('---||======> Generate for module: Export for app');

  data.add('\n/// CODE GENERATE. Last modify: ${DateTime.now()}\n');
  data.add('library vimeo_video_player_custom;\n');

  await recursive(Directory(Directory.current.path));
  final file = File('${Directory.current.path}/vimeo_video_player_custom.dart');

  file.writeAsStringSync(data.join('\n'));
}
