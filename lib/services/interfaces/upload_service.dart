import 'dart:async';
import 'dart:io';

abstract class UploadService {
  Future<Map<String, dynamic>> upload(File file, String url);
}
