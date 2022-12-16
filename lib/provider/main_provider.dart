import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class MainProvider extends ChangeNotifier {
  XFile? imagen;

  Future<String?> uploadImg() async {
    if (imagen == null) return null;
    final url = Uri.parse(
        "https://api.cloudinary.com/v1_1/dhc2woszw/image/upload?upload_preset=n64jgeer");
    final uploadRequest = http.MultipartRequest('POST', url);
    final file = await http.MultipartFile.fromPath('file', imagen!.path);

    uploadRequest.files.add(file);

    final stream = await uploadRequest.send();
    final resp = await http.Response.fromStream(stream);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      return null;
    }
    final decodedData = jsonDecode(resp.body);
    imagen = null;

    return decodedData['secure_url'];
  }
}
