import 'package:flutter/foundation.dart';
import 'package:flutter_application_2/models/image_model.dart';

class MyImageProvider extends ChangeNotifier {
  String _filePath = '';
  List<ImageModel> _images = [];

  String get filePath => _filePath;
  List<ImageModel> get images => _images;

  void setFilePath(String path) {
    _filePath = path;
    notifyListeners();
  }

  void addImage(ImageModel image) {
    _images.add(image);
    notifyListeners();
  }
}
