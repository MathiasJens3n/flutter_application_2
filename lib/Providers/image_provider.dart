import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/image_model.dart';

class ImageList with ChangeNotifier {
  final List<ImageModel> _images = [];

  List<ImageModel> get images => _images;

  // Method to add a new image to the list.
  void addImage(ImageModel image) {
    _images.add(image);
    notifyListeners();
  }
}
