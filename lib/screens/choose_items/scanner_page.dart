

import 'package:flutter/material.dart';
//import 'package:mobile_scanner/mobile_scanner.dart';

class ScanCodePage extends StatefulWidget {
  const ScanCodePage({super.key});

  @override
  State<ScanCodePage> createState() => _ScanCodePageState();
}

class _ScanCodePageState extends State<ScanCodePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Scan QR Code'),
        ),
        body: Container(),
        /*body: MobileScanner(
          controller: MobileScannerController(
              detectionSpeed: DetectionSpeed.noDuplicates, returnImage: true),
          onDetect: (onDetect) {
            print(onDetect);
            final List<Barcode> captures = onDetect.barcodes;
            final Uint8List? image = onDetect.image;
            for (final barcode in captures) {
              print(barcode.rawValue);
              if (barcode.rawValue != null) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(barcode.rawValue!),
                        content: Image(
                          image: MemoryImage(image!),
                          fit: BoxFit.contain,
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('OK'),
                          )
                        ],
                      );
                    });
              }
            }
          },
        )*/);
  }
}
