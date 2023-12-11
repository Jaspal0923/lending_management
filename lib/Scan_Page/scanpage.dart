import 'dart:io';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');

  QRViewController? controller;
  Barcode? _qrText;

  @override
  void initState() {
    super.initState();
    // Initialize controller here
    controller?.resumeCamera();
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    } else {
      controller?.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Scanner'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: _buildQRView(context),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: (_qrText != null)
                  ? Text('Barcode Type: ${_qrText?.code}')
                  : Text('Scan a code'),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildQRView(BuildContext context){
    var scanArea = (MediaQuery.of(context).size.width < 400 || MediaQuery.of(context).size.height < 400) ? 150 : 300;

   //
   return QRView(
    key: _qrKey,
    onQRViewCreated: _onQRViewCreated,
    overlay: QrScannerOverlayShape(
      borderColor: Colors.red,
      borderRadius: 10,
      borderLength: 30,
      borderWidth: 10,
    ),
    ); 
  }
  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        _qrText = scanData;
        //_showQRDialog(scanData.code!);
        //When scan get the id data and put it in the next page
        Navigator.of(context).pushReplacementNamed('/userPage');
      });
    });
    controller.pauseCamera();
    controller.resumeCamera();
  }

  void _showQRDialog(String data) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('QR Code Scanned'),
          content: Text('Data: $data'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

// Helper function to replace deprecated `describeEnum`
String enumToString(Object e) => e.toString().split('.').last;
