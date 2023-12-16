import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lending_management/User_Page/main_page.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key, required this.docID, required this.employeeId});
  final String docID; //customerID
  final String employeeId; 
  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
 // Replace with the actual employee ID
  final TextEditingController _createLoan = TextEditingController();
  final TextEditingController _loanPercent = TextEditingController();
  String? name;

  double? _totalAmt;

  ProgressDialog? progressDialog;

@override
void initState() {
  super.initState();
  progressDialog = ProgressDialog(context);
  progressDialog?.style(
    message: 'Uploading...', // Set your own message
    borderRadius: 10.0,
    backgroundColor: Colors.white,
    progressWidget: const CircularProgressIndicator(),
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
  void dispose(){
    super.dispose();
    _createLoan.dispose();
    _loanPercent.dispose();
  }
  bool isNumber(String text) {
    try {
      double.parse(text);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loan List'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showDialog(
            context: context, 
            builder: (context)=> AlertDialog(
              title: const Text('Add loan'),
              content: _contentAddLoan(),
              actions: [
                ElevatedButton(
                  onPressed: () async {
                    if (isNumber(_createLoan.text) && isNumber(_loanPercent.text)) {
                      progressDialog?.show();
                      try {
                        _totalAmt = ((double.parse(_loanPercent.text) / 100) * double.parse(_createLoan.text)) + double.parse(_createLoan.text);

                        // Get a reference to the 'customers' collection under the 'employee' document
                        CollectionReference<Map<String, dynamic>> custLoansCollection =
                            FirebaseFirestore.instance.collection('employee').doc(widget.employeeId).collection('customers');

                        // Add a loan document to the 'loans' subcollection under the specific customer
                        DocumentReference<Map<String, dynamic>> addLoanReference =
                            await custLoansCollection.doc(widget.docID).collection('loans').add({
                          "Loan Amount": _createLoan.text,
                          "Loan Percent": _loanPercent.text,
                          "Total Loaned Amount": _totalAmt,
                          "Loan Balance":_totalAmt,
                          "Paid Amount": 0,
                          "cid": widget.docID,
                          "LoanID": '',
                        });

                        // Get the ID of the newly added loan
                        String loanID = addLoanReference.id;

                        // Update the 'LoanID' field in the newly added loan document
                        await addLoanReference.update({"LoanID": loanID});

                        // Hide the progress dialog
                        progressDialog?.hide();

                        // Close the current screen/page
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pop();
                      } catch (e) {
                        debugPrint('$e');
                        // Handle the exception if needed
                      } finally {
                        progressDialog?.hide();
                      }
                    } else {
                      // Display an error dialog if loan amount or interest is not a number
                      showDialog(
                        context: context,
                        builder: (context) => const AlertDialog(
                          title: Center(
                            child: Text('Loan Amount and Interest Must be a number'),
                          ),
                        ),
                      );
                    }

                  }, 
                  child: const Text('Confirm'))
              ],
            )
          );
        },
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('employee')
            .doc(widget.employeeId)
            .collection('customers')
            .doc(widget.docID)
            .collection('loans')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('No loans found for this customer.'),
            );
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot<Map<String, dynamic>> document) {
              Map<String, dynamic> loanData = document.data()!;
              getCustomerName();
              // Handle null values for fields
              String loanAmount = loanData['Loan Amount'] ?? 'N/A';
              String dataID = loanData['LoanID'] ?? 'N/A';
              String loanPercent = loanData['Loan Percent']?? 'N/A';
              String custID = loanData['cid']?? 'N/A';
              num pdAmt = loanData['Paid Amount'] ?? 0.0;
              num remBal = loanData['Loan Balance'] ?? 0.0;

              return ListTile(
                onTap: (){
                  showDialog(
                    context: context, 
                    builder: (context) => AlertDialog(
                      title: Text(dataID),
                    )
                  );
                  //GOTO PAGE
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> MainPage(loanID: dataID, custID: custID, name: '$name', amountLoaned: '$loanAmount', loanPercent: '$loanPercent', paidAmount: pdAmt, remainingBal: remBal, eid: widget.employeeId,)));                },
                title: Text('Loan Amount: $loanAmount'),
                // Add more fields as needed
                trailing: IconButton(
                  onPressed: (){
                    showDialog(
                      context: context, 
                      builder: (context)=> AlertDialog(
                        title: const Text('DELETE CONFIRMATION?',style: TextStyle(fontSize: 20),),
                        content: const Text('Everything realted to the loan balance will be deleted PROCEED?'),
                        actions: [
                          ElevatedButton(
                            onPressed: ()async {
                              try{
                                progressDialog?.show();
                                CollectionReference<Map<String, dynamic>> custLoanDelete=
                                    FirebaseFirestore.instance.collection('employee').doc(widget.employeeId).collection('customers');
                                await custLoanDelete.doc(widget.docID).collection('loans').doc(dataID).delete();
                                // ignore: use_build_context_synchronously
                                Navigator.of(context).pop();
                              }catch(e){
                                debugPrint('ERROR-: $e');
                              }finally{
                                progressDialog?.hide();
                              }
                          },
                          child: const Text("CONFIRM"),
                          ),
                        ],
                      )
                    );
                  }, 
                  icon: const Icon(Icons.delete),
                ),
              );
            }).toList(),
          );
        },
      ), 
    );
  }

  Widget _contentAddLoan(){
    return SizedBox(
        height: 200,
        width: 400,
        child: Column(
          children: [
            TextField(
              controller: _createLoan,
              decoration: const InputDecoration(
                label: Text('Amount'),
                hintText: 'Enter Amount',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              controller: _loanPercent,
              decoration: const InputDecoration(
                label: Text('Percent'),
                hintText: 'Enter Percent',
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      );
  }

  Future<String?> getCustomerName() async {
    try {
      DocumentReference customerRef = FirebaseFirestore.instance.collection('employee').doc(widget.employeeId).collection('customers').doc(widget.docID) ;
      DocumentSnapshot<Map<String, dynamic>> snapshot = await customerRef.get() as DocumentSnapshot<Map<String, dynamic>>;

      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data()!;
        name = data['Name'];
        return name;
      } else {
        // Return a default value or handle the case when the customer is not found
        return 'Customer not found';
      }
    } catch (e) {
      // Handle errors and return an appropriate value
      debugPrint('Error fetching customer name: $e');
      return 'Error fetching customer name';
    }
  }
}