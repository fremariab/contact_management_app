//importing flutter material package for UI components
import 'package:flutter/material.dart';

//importing API service for adding contacts
import '../services/add_new_contact.dart';

//importing awesome_dialog package for showing alerts
import 'package:awesome_dialog/awesome_dialog.dart';

//defining a stateful widget for the add contact screen
class AddContactScreen extends StatefulWidget {
  //constructor
  const AddContactScreen({super.key});

  @override
  AddContactScreenState createState() => AddContactScreenState();
}

//state class for managing the add contact screen
class AddContactScreenState extends State<AddContactScreen> {
  //controllers to capture user input
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  //function to show Sweet Alert for success or failure
  void _showAlert(String title, String message, DialogType type) {
    AwesomeDialog(
      context: context,
      dialogType: type, //determines if the dialog is success or error
      animType: AnimType.scale,
      title: title,
      desc: message,
      btnOkOnPress: () {}, //close dialog when OK is pressed
    ).show();
  }

  //function to validate phone number (should be exactly 10 digits)
  bool _isValidPhoneNumber(String phone) {
    final RegExp phoneRegex = RegExp(r'^\d{10}$'); //checks if input has 10 digits
    return phoneRegex.hasMatch(phone);
  }

  //function to submit data to API
  Future<void> _addContact() async {
    //trim input values to remove unnecessary spaces
    String fullname = _nameController.text.trim();
    String phone = _phoneController.text.trim();

    //validation: check if fields are empty
    if (fullname.isEmpty || phone.isEmpty) {
      _showAlert("Error", "Please fill in all fields.", DialogType.error);
      return;
    }

    //validation: check if phone number is exactly 10 digits
    if (!_isValidPhoneNumber(phone)) {
      _showAlert("Error", "Phone number must be exactly 10 digits.", DialogType.error);
      return;
    }

    try {
      //call the API service function to add a contact
      String result = await AddNewContact.addNewContact(fullname, phone);

      //clear the form if the API call was successful
      if (result.toLowerCase() == "success") {
        _showAlert("Success", "Contact added successfully!", DialogType.success);
        _nameController.clear(); //clear the name field
        _phoneController.clear(); //clear the phone field
      } else {
        _showAlert("Error", "Failed to add contact. Try again.", DialogType.error);
      }
    } catch (e) {
      //handle API call errors
      _showAlert("Error", "Something went wrong: $e", DialogType.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Contact', //app title
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 1, 48, 8), //custom app bar color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), //padding for better layout
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, //center elements vertically
          crossAxisAlignment: CrossAxisAlignment.stretch, //make elements take full width
          children: <Widget>[
            //full name input field
            TextField(
              controller: _nameController, //connects controller to get user input
              decoration: const InputDecoration(
                labelText: 'Full Name', //label inside the field
                border: OutlineInputBorder(), //adds border around the field
              ),
            ),
            const SizedBox(height: 10), //spacing

            //phone number input field
            TextField(
              controller: _phoneController, //connects controller to get user input
              decoration: const InputDecoration(
                labelText: 'Phone Number', //label inside the field
                border: OutlineInputBorder(), //adds border around the field
              ),
              keyboardType: TextInputType.phone, //sets keyboard type to numbers
            ),
            const SizedBox(height: 20), //spacing

            //button to submit data
            ElevatedButton(
              onPressed: _addContact, //calls API function when pressed
              child: const Text('Add Contact'),
            ),
          ],
        ),
      ),
    );
  }
}
