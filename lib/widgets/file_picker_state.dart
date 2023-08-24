import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/Providers/image_provider.dart';
import 'package:flutter_application_2/models/image_model.dart';
import 'package:flutter_application_2/screens/home_screen.dart';
import 'package:provider/provider.dart';

class FilePickerWidgetState extends State<MyHomePage> {
  // Define variables to store file information
  final List<DataRow> rows = [];

  Future<void> _openFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    final imageProvider = Provider.of<MyImageProvider>(context, listen: false);

    if (result != null) {
      imageProvider.setFilePath(result.files.single.path as String);
    }

    // Show a dialog box with an image after file selection.
    await _showImageDialog();
  }

  // Create a separate async function for showing the dialog.
  Future<void> _showImageDialog() async {
    String imageName = '';
    String fileType = '';
    String size = '';

    final imageProvider = Provider.of<MyImageProvider>(context, listen: false);

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            children: [
              Image.file(
                File(imageProvider.filePath), // Display the selected image
                width: 200,
                height: 200,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Image Name'),
                onChanged: (value) {
                  imageName = value;
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
                  fileType = value as String;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Image Size'),
                onChanged: (value) {
                  size = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                imageProvider.addImage(ImageModel(
                    name: imageName,
                    type: fileType,
                    size: size,
                    path: imageProvider.filePath));

                //Save Image information
                DataRow newRow =
                    DataRow(onLongPress: _showImageFullSize, cells: [
                  DataCell(Image.file(
                    File(imageProvider
                        .images.last.path), // Display the selected image
                    width: 30,
                    height: 30,
                  )),
                  DataCell(Text(imageProvider.images.last.name)),
                  DataCell(Text(imageProvider.images.last.type)),
                  DataCell(Text(imageProvider.images.last.size)),
                ]);
                setState(() {
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
    final imageProvider = Provider.of<MyImageProvider>(context, listen: false);
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(
              children: [
                Image.file(
                  File(imageProvider.filePath), // Display the selected image
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
    return Center(
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () => _openFilePicker(),
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
