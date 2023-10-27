import 'dart:io';


import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
class DownloadingDialog extends StatefulWidget {
  const DownloadingDialog({Key? key}) : super(key: key);

  @override
  _DownloadingDialogState createState() => _DownloadingDialogState();
}

class _DownloadingDialogState extends State<DownloadingDialog> {
  TextEditingController url = TextEditingController();
  double? _progress;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Download mp3 music',
              style: TextStyle(
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: url,
              decoration: const InputDecoration(label: Text('Url*')),
            ),
            const SizedBox(height: 16),
            _progress != null
                ? const CircularProgressIndicator()
                : ElevatedButton(
                onPressed: () {
                  downloadFile(url.text.toString());

                },
                child: const Text('Download')),
          ],
        ),
      ),
    );



  }

  Future<dynamic> downloadFile(String url) async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    var filename = path.basename(url);
    File file = File('$dir/$filename');
    var request = await http.get(Uri.parse(url));
    var bytes = request.bodyBytes;
    await file.writeAsBytes(bytes);
    print(file.path);
  }










}