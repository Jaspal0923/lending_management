import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lending_management/Add_Page/add_textFields.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';


class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final TextEditingController _Name = TextEditingController();
  final TextEditingController _BDate = TextEditingController();
  final TextEditingController _Address = TextEditingController();
  final TextEditingController _PhoneNo = TextEditingController();
  final TextEditingController _loanAmt = TextEditingController();
  final TextEditingController _loanPercent = TextEditingController();

  void dispose() {
    super.dispose();
    _Name.dispose();
    _BDate.dispose();
    _Address.dispose();
    _PhoneNo.dispose();
    _loanAmt.dispose();
    _loanPercent.dispose();
  }

  bool _isHovered = true;
  bool _isPressed = false;
  XFile? file;
  String imageUrl='';
  bool pic = true;
  double? _totalAmt;

  var formkey = GlobalKey<FormState>();

  //========================================== METHODS
  bool isNumber(String text) {
    try {
      double.parse(text);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != DateTime.now()) {
      setState(() {
        _BDate.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

 ProgressDialog? progressDialog;

@override
void initState() {
  super.initState();
  progressDialog = ProgressDialog(context);
  progressDialog?.style(
    message: 'Uploading...', // Set your own message
    borderRadius: 10.0,
    backgroundColor: Colors.white,
    progressWidget: CircularProgressIndicator(),
    elevation: 10.0,
    insetAnimCurve: Curves.easeInOut,
    messageTextStyle: const TextStyle(
      color: Colors.black,
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(children: [
        Container(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // IMAGE CONTAINER
                GestureDetector (
                  onTap: () async{
                    ImagePicker imagePicker = ImagePicker();
                    file = await imagePicker.pickImage(source: ImageSource.camera);
                    setState(() {
                      if(file!=null){
                        pic = false;
                      }
                    });

                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color:  pic ? Colors.amber : Colors.lightGreenAccent,
                    ),
                    width: double.infinity,
                    height: 150,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image,
                          size: 50,
                        ),
                        Text('Add Image'),
                      ],
                    ),
                  ),
                ),

                //====================================================================== USER'S DETAIL

                // USER'S DETAIL
                const SizedBox(
                  // SPACING
                  height: 20,
                ),

                const Text(
                  "USER'S DETAIL",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(
                  // SPACING
                  height: 15,
                ),
                // USERS INPUT FIELD
                addTextField(
                    controller: _Name,
                    hint: "Enter Name",
                    tit: TextInputType.text,
                    cap: 'Name:'),
                const SizedBox(
                  // SPACING
                  height: 15,
                ),

                // BDATE TEXTFIELD
                GestureDetector(
                  onTap: () => _selectDate(context),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Date of Birth:',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          _BDate.text.isEmpty ? 'Select Date' : _BDate.text,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),

                //====================================================================== USER'S CONTACT

                //LINE
                const SizedBox(
                  // SPACING
                  height: 12.5,
                ),
                const Divider(
                  color: Colors.black,
                ),
                const SizedBox(
                  // SPACING
                  height: 12.5,
                ),

                // USER'S CONTACT
                const Text(
                  "USER'S CONTACT",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(
                  // SPACING
                  height: 15,
                ),

                // ADDRESS TEXT FIELD
                addTextField(
                    controller: _Address,
                    hint: "Enter Address",
                    tit: TextInputType.streetAddress,
                    cap: 'Address:'),
                const SizedBox(
                  // SPACING
                  height: 15,
                ),

                //PHONE NO TEXT FIELD
                addTextField(
                    controller: _PhoneNo,
                    hint: "Enter Phone Number",
                    tit: TextInputType.phone,
                    cap: 'Phone No.:'),
                const SizedBox(
                  // SPACING
                  height: 15,
                ),

                //====================================================================== LOAN DETAILS

                //LINE
                const SizedBox(
                  // SPACING
                  height: 12.5,
                ),
                const Divider(
                  color: Colors.black,
                ),
                const SizedBox(
                  // SPACING
                  height: 12.5,
                ),

                // LOAN DETAILS
                const Text(
                  "LOAN DETAILS",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(
                  // SPACING
                  height: 15,
                ),

                //LOAN AMOUNT TEXT FIELD
                addTextField(
                    controller: _loanAmt,
                    hint: "Enter Amount",
                    tit: TextInputType.number,
                    cap: 'Loan Amount:'),
                const SizedBox(
                  // SPACING
                  height: 15,
                ),

                //PERCENT TEXT FIELD
                addTextField(
                    controller: _loanPercent,
                    hint: "Enter Percentage",
                    tit: TextInputType.number,
                    cap: 'Interest Rate:'),
                const SizedBox(
                  // SPACING
                  height: 25,
                ),

                //SUBMIT BUTTON
                MouseRegion(
                  onEnter: (_) {
                    setState(() => _isHovered = true);
                  },
                  onExit: (_) {
                    setState(() => _isHovered = false);
                  },
                  cursor: _isHovered
                      ? SystemMouseCursors.click
                      : SystemMouseCursors.basic,
                  child: GestureDetector(
                    onTap: () {
                      if(file==null){
                        showDialog(
                          context: context, 
                          builder: (context) => const AlertDialog(
                            title: Text('Please Insert Image'),
                          )
                        );
                      }
                      else if(_BDate.text.isEmpty){
                        showDialog(
                          context: context, 
                          builder: (context) => const AlertDialog(
                            title: Text('Please Input BDate'),
                          )
                        );
                      }
                      else if (formkey.currentState!.validate()) {
                        if (isNumber(_loanAmt.text) &&
                            isNumber(_loanPercent.text)) {
                              _totalAmt = ((double.parse(_loanPercent.text) / 100) * double.parse(_loanAmt.text)) + double.parse(_loanAmt.text);
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text(
                                'Confirmation',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              content: SizedBox(
                                height: 150,
                                width: 400,
                                child: Column(
                                  children: [
                                    Text('LOAN AMOUNT: ${_loanAmt.text}\n'),
                                    Text(
                                        'INTEREST RATE: ${_loanPercent.text}\n'),

                                    //===CALCULATION FOR TOTAL BALACNE===
                                    Text(
                                        'TOTAL AMOUNT: $_totalAmt'),

                                    //
                                  ],
                                ),
                              ),
                              actions:[
                                //=================== CONFIMRATION BUTTON
                                ElevatedButton(
                                  onPressed: () async {
                                     progressDialog?.show();//loading animation
                                     
                                    //reference to upload the file in a certain folder
                                    Reference referenceRoot = FirebaseStorage.instance.ref();
                                    Reference referenceDIRImages = referenceRoot.child('images');

                                    //Create a reference
                                    Reference referenceImageToUpload = referenceDIRImages.child('${file?.name}');

                                    // TODO: GENERATE QR FOR CUSTOMER AND UPLOAD AND DOWNLOAD
                                    // SCAN QR TO USERS PAGE
                                    // USER PAGE NEED TO HAVE SELECTION OF UTANGS
                                    // AFTER SELECTING GO TO PAGE
                                    // TRANSACTIONS -> TRANSACTION PAGES [ EDIT | DELETE ]
                                    // USER PAGE SELECT FUNCTION/BUTTON TO SHOWDIALOG

                                    //IF POSSIBLE
                                    //== FIREBASE -> DATABASE ==
                                    //== EMPLOYEE -> EARNINGS PER DAY ==

                                    //CREATE ADMIN PAGE
                                      //SHOW TOTAL INCOME OF ALL EMPLOYEE
                                        //GET SUB-COLLECTION OF EARNINGS PER DAY FOR THE EMPLOYEE
                                        
                                      //GET TOTAL NUMBER OF CUSTOMERS OF ALL EMPLOYEE
                                        //GET SUB-COLLECTION OF EARNINGS PER DAY FOR THE EMPLOYEE
                                      
                                      //SHOW ALL EMPLOYEE [ PAGE ] -> [ UPPER PART ]: EMPLOYEES DETAIL | [ CONTENT \ CENTER ]: LIST OF CUSTOMER
                                      //SHOW ALL CUSTOMER [ PAGE ] -> SPECIFIC CUSTOMER DETAILS [ ANOTHER PAGE ]

                                    
                                    // =================================================================================

                                    //Store File
                                    try{
                                      //upload image
                                      await referenceImageToUpload.putFile(File(file!.path));

                                      //get download url
                                      imageUrl = await referenceImageToUpload.getDownloadURL();

                                      //put into database
                                      //=================================================

                                      // get current employee userid
                                      final FirebaseAuth auth =  FirebaseAuth.instance; 
                                      final User? user = auth.currentUser;


                                      // Pass Data to database
                                      // Getting the reference or database to input the data
                                      // 
                                      DocumentReference employee = FirebaseFirestore.instance.collection('employee').doc(user?.uid);
                                      DocumentReference customer = await employee.collection('customers').add({
                                        "PicID": imageUrl,
                                        "Name": _Name.text,
                                        "Birthday": _BDate.text,
                                        "Address": _Address.text,
                                        "Phone No.": _PhoneNo.text,
                                        "eid": user?.uid,
                                      });

                                      await customer.collection('loans').add({
                                        "Loan Amount": _loanAmt.text,
                                        "Loan Percent": _loanPercent.text,
                                        "Total Loaned Amount": _totalAmt,
                                        "cid":'',//TODO: GET CUSTOMERS ID HERE
                                      });
                                  
                                      //GENERATING QR CODE TO OTHER PAGE

                                    // ignore: empty_catches
                                    }catch(e){
                                      
                                    }finally {
                                      progressDialog?.hide();
                                    }
                                    

                                    // ignore: use_build_context_synchronously
                                    Navigator.pop(context);
                                    
                                  }, 
                                  child: const Text('CONFIRM'))
                              ],
                            ),
                          );
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) => const AlertDialog(
                                    title: Center(
                                        child: Text(
                                            'Loan Amount and Interest Must be a number')),
                                  ));
                        }
                        //==================== SHOW DIALOG FOR CONFIRMATION
                      }
                    },
                    onTapDown: (_) => setState(() => _isPressed = true),
                    onTapUp: (_) => setState(() => _isPressed = false),
                    child: Container(
                      decoration: BoxDecoration(
                        color: _isPressed
                            ? Colors.lightBlueAccent.withOpacity(0.9)
                            : Colors.blueAccent,
                      ),
                      width: double.infinity,
                      height: 60,
                      child: const Center(
                        child: Text(
                          'Submit',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                //======================================================================
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
