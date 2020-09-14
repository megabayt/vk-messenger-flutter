import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;

import 'package:vk_messenger_flutter/services/interfaces/upload_service.dart';

class UploadServiceImpl implements UploadService {
  Future<Map<String, dynamic>> upload(File file, String url) async {
    final imageFile = File(file.path);

    final stream = new http.ByteStream(
      DelegatingStream(
        imageFile.openRead(),
      ),
    );

    final length = await imageFile.length();

    final uri = Uri.parse(url);

    final request = new http.MultipartRequest("POST", uri);
    final multipartFile = new http.MultipartFile('file', stream, length,
        filename: basename(imageFile.path));

    request.files.add(multipartFile);

    final response = await request.send();

    final completer = new Completer();

    var responseStr = '';

    if (response.statusCode != 200) {
      throw Exception();
    }

    response.stream.transform(utf8.decoder).listen(
      (value) {
        responseStr += value;
      },
      onDone: () {
        completer.complete();
      },
      onError: (error) {
        completer.completeError(error);
      },
    );

    await completer.future;

    return responseStr != '' ? json.decode(responseStr) : null;
  }
}
