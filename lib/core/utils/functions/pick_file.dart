import 'dart:io';

import 'package:file_picker/file_picker.dart';

Future<File?> pickFile(FileType type) async {
  try {
    final filePickerResult = await FilePicker.platform.pickFiles(type: type);
    if (filePickerResult != null) {
      return File(filePickerResult.files.first.xFile.path);
    }
    return null;
  } catch (e) {
    return null;
  }
}
