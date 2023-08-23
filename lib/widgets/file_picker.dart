import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

const List<String> fileTypes = ['jpg', 'png'];

class FilePickerWidgetState extends StatelessWidget {
  String? _filePath = "";

  List<File> files = <File>[];

  // Define variables to store file information
  String imageName = "";
  String fileType = "";
  String imageSize = "";
  List<DataRow> rows = [];

  Future<void> _openFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _filePath = result.files.single.path;
      });
    }

    // Show a dialog box with an image after file selection.
    await _showImageDialog();
  }

  // Create a separate async function for showing the dialog.
  Future<void> _showImageDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            children: [
              Image.file(
                File(_filePath as String), // Display the selected image
                width: 200,
                height: 200,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Image Name'),
                onChanged: (value) {
                  setState(() {
                    imageName = value;
                  });
                },
              ),
              DropdownButtonFormField<String>(
                items: ['JPG', 'PNG', 'GIF'].map((String fileType) {
                  return DropdownMenuItem<String>(
                    value: fileType,
                    child: Text(fileType),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    fileType = value as String;
                  });
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Image Size'),
                onChanged: (value) {
                  setState(() {
                    imageSize = value;
                  });
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                //Save Image information
                setState(() {
                  DataRow newRow = DataRow(cells: [
                    DataCell(
                        Image.file(
                          File(_filePath
                              as String), // Display the selected image
                          width: 30,
                          height: 30,
                        ),
                        onTap: _showImageFullSize),
                    DataCell(Text(imageName)),
                    DataCell(Text(fileType)),
                    DataCell(Text(imageSize)),
                  ]);
                  rows.add(newRow);
                });

                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showImageFullSize() async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(
              children: [
                Image.file(
                  File(_filePath as String), // Display the selected image
                  width: 300,
                  height: 300,
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Opgave'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _openFilePicker,
            child: const Text('Choose File'),
          ),
          ImageDataGrid(rows),
        ],
      ),
    );
  }
}

//Creates the datagrid to show image informations
class ImageDataGrid extends StatelessWidget {
  final List<DataRow> rows;

  const ImageDataGrid(this.rows, {super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(columns: const [
          DataColumn(label: Text('Image')),
          DataColumn(label: Text('Image Name')),
          DataColumn(label: Text('File Type')),
          DataColumn(label: Text('Image Size')),
        ], rows: rows));
  }
}
