import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lending_management/User_Page/userpage.dart';
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
        title: const Text('QR Code Scanner'),
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
                  : const Text('Scan a code'),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildQRView(BuildContext context){
    //var scanArea = (MediaQuery.of(context).size.width < 400 || MediaQuery.of(context).size.height < 400) ? 150 : 300;

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
        String? scannedCode = _qrText?.code;
        //_showQRDialog(scanData.code!);
        //TODO: SCAN IF THE USER IS IN THE DATABASE
        //IF USER IS NOT IN THE DATABASE USE DIALOG TO SHOW USER IS NOT FOUND
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> UserPage(docID: '$scannedCode')));

      });
    });
    controller.pauseCamera();
    controller.resumeCamera();
  }

  // TODO: USE DIALOG TO TELL USER NOT FOUND
  // ignore: unused_element
  void _showQRDialog(String data) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('QR Code Scanned'),
          content: Text('Data: $data'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
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
