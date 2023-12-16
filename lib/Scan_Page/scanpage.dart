import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  bool scanSuccess = false;
  String? scannedCode;
  String? eid;


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
        scannedCode = _qrText?.code;
        _handleScanData('$scannedCode');

      });
    });
    controller.pauseCamera();
    controller.resumeCamera();
  }

  // ignore: unused_element
  void _showQRDialog(String data) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('QR Code Scanned'),
          content: Text(data),
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

  //check data
  void _handleScanData(String scanData) async {
    // Check the scanned data against the database
    bool isInDatabase = await checkDatabase(scanData);

    if (isInDatabase && !scanSuccess) {
      scanSuccess = true;
      // Navigate to the next page
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => UserPage(docID: '$scannedCode', employeeId:'$eid',)),
      );
    }else if (isInDatabase == false){
      _showQRDialog('$scannedCode can\'t be found');
    }
  }

  Future<bool> checkDatabase(String qrData) async {

  // get current employee userid
  final FirebaseAuth auth =  FirebaseAuth.instance; 
  final User? user = auth.currentUser;
  eid=user?.uid;

  // Pass Data to database
  // Getting the reference or database to input the data
  
  DocumentReference employee = FirebaseFirestore.instance.collection('employee').doc(user?.uid);
  QuerySnapshot customerQuery = (await employee.collection('customers').where(FieldPath.documentId, isEqualTo: scannedCode).get());
  if (customerQuery.size > 0){
    return true;
  }
  return false;
}


  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

// Helper function to replace deprecated `describeEnum`
String enumToString(Object e) => e.toString().split('.').last;
