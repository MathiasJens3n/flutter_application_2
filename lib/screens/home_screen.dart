import 'package:flutter/material.dart';
import 'package:flutter_application_2/widgets/file_picker.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  FilePickerWidgetState createState() => FilePickerWidgetState();
}
