import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class FileUploadPage extends StatefulWidget {
  @override
  _FileUploadPageState createState() => _FileUploadPageState();
}

class _FileUploadPageState extends State<FileUploadPage> {
  // Define variables to store file information
  String? imageName;
  String? fileType;
  String? imageSize;
  List<DataRow> rows = [];

  // Function to pick and upload a file
  void _pickAndUploadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      // Upload file logic here

      // Set the file information variables
      setState(() {
        imageName = "Example Name"; // You can get this from user input
        fileType = "JPG"; // You can get this from user input
        imageSize = "500 KB"; // You can get this from user input
      });

      // Add a new row to the data grid
      DataRow newRow = DataRow(cells: [
        DataCell(Text(imageName ?? "")),
        DataCell(Text(fileType ?? "")),
        DataCell(Text(imageSize ?? "")),
      ]);
      rows.add(newRow);
    }
  }

  // Function to show the dialog
  void _showImageUploadDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Upload Image'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Image display here
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
                onChanged: (String? value) {
                  setState(() {
                    fileType = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Image Size'),
                onChanged: (value) {
                  imageSize = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Save image information
                setState(() {
                  // Save data to the data grid
                  DataRow newRow = DataRow(cells: [
                    DataCell(Text(imageName ?? "")),
                    DataCell(Text(fileType ?? "")),
                    DataCell(Text(imageSize ?? "")),
                  ]);
                  rows.add(newRow);

                  // Close the dialog
                  Navigator.pop(context);
                });
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File Upload and Data Grid'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _pickAndUploadFile,
            child: Text('Choose File'),
          ),
          ImageDataGrid(rows),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showImageUploadDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}

class ImageDataGrid extends StatelessWidget {
  final List<DataRow> rows;

  ImageDataGrid(this.rows);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: [
          DataColumn(label: Text('Image Name')),
          DataColumn(label: Text('File Type')),
          DataColumn(label: Text('Image Size')),
        ],
        rows: rows,
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: FileUploadPage(),
  ));
}
