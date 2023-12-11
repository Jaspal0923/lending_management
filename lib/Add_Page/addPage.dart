import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lending_management/Add_Page/add_textFields.dart';
import 'package:intl/intl.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(children: [
        Container(
          padding: EdgeInsets.all(15),
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // IMAGE CONTAINER
                GestureDetector(
                  onTap: () {
                    ImagePicker imagePicker = ImagePicker();
                    imagePicker.pickImage(source: ImageSource.gallery);
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.amber,
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
                      if (formkey.currentState!.validate()) {
                        if (isNumber(_loanAmt.text) &&
                            isNumber(_loanPercent.text)) {
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
                                        'TOTAL AMOUNT: ${((double.parse(_loanPercent.text) / 100) * double.parse(_loanAmt.text)) + double.parse(_loanAmt.text)}'),

                                    //
                                  ],
                                ),
                              ),
                              actions: const [
                                //=================== CONFIMRATION BUTTON
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
