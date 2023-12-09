import 'package:flutter/material.dart';
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

  void dispose() {
    super.dispose();
    _Name.dispose();
    _BDate.dispose();
    _Address.dispose();
    _PhoneNo.dispose();
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
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // IMAGE CONTAINER
              Container(
                decoration: const BoxDecoration(
                  color: Colors.amber,
                ),
                width: double.infinity,
                height: 150,
                child: const Center(child: Text('INSERT IMAGE')),
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
              addTextField(controller: _Name, hint: "Enter Name", tit: TextInputType.text, cap: 'NAME:'),
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
              addTextField(controller: _Address, hint: "Enter Address", tit: TextInputType.streetAddress, cap: 'Address:'),
              const SizedBox(
                // SPACING
                height: 15,
              ),

              //PHONE NO TEXT FIELD
              addTextField(controller: _PhoneNo, hint: "Enter Phone Number", tit: TextInputType.phone, cap: 'Phone No.:'),
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
            ],
          ),
        ),
      ),
    );
  }
}
