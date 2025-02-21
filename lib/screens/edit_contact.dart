// import 'package:flutter/material.dart';
// import '../services/edit_contact.dart';
// import 'package:awesome_dialog/awesome_dialog.dart';

// class EditContactScreen extends StatefulWidget {
//   final String cid;
//   final String cname;
//   final String cnum;

//   const EditContactScreen({
//     super.key,
//     required this.cid,
//     required this.cname,
//     required this.cnum,
//   });

//   @override
//   EditContactScreenState createState() => EditContactScreenState();
// }

// class EditContactScreenState extends State<EditContactScreen> {
//   //Controllers to capture user input
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _nameController.text = widget.cname; // Prefill with current name
//     _phoneController.text = widget.cnum; // Prefill with current phone
//   }

//   //Function  to show Sweet Alert for success or failure
//   void _showAlert(String title, String message, DialogType type) {
//     AwesomeDialog(
//       context: context,
//       dialogType: type, // DialogType.success or DialogType.error
//       animType: AnimType.scale,
//       title: title,
//       desc: message,
//       btnOkOnPress: () {},
//     ).show();
//   }

//   //Function to submit data to the api
//     Future<void> _editContact() async {
//     // Trim input values to remove unnecessary spaces
//     String fullname = _nameController.text.trim();
//     String phone = _phoneController.text.trim();

//     // Basic validation: Check if fields are empty
//     if (fullname.isEmpty || phone.isEmpty) {
//       _showAlert("Error", "Please fill in all fields", DialogType.error);
//       return;
//     }

//     try {
//       // Call API service to edit a contact
//       String result = await EditContact.editContact(fullname, phone, widget.cid);

//       // Check if the update was successful
//       if (result.toLowerCase() == "success") {
//         _showAlert(
//             "Success", "Contact edited successfully", DialogType.success);

//         // Return the updated contact details to the previous screen
//         Navigator.pop(context, {
//           "cname": fullname,
//           "cnum": phone,
//         });
//       } else {
//         _showAlert(
//             "Error", "Failed to update contact. Try again", DialogType.error);
//       }
//     } catch (e) {
//       _showAlert("Error", "Something went wrong: $e", DialogType.error);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text(
//             'Edit Contacts', //AppBar Title
//             style: TextStyle(color: Colors.white),
//           ),
//           backgroundColor:
//               const Color.fromARGB(255, 1, 48, 8), // Custom app bar color
//         ),
//         body:
//             // Center(child: Text('This is the screen to edit contacts')),
//             Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: <Widget>[
//                       //Full Name Input Field
//                       TextField(
//                         controller: _nameController,
//                         decoration: const InputDecoration(
//                           labelText: 'Full Name',
//                           border: OutlineInputBorder(),
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       // Phone Number Input Field

//                       TextField(
//                         controller: _phoneController,
//                         decoration: const InputDecoration(
//                           labelText: 'Phone Number',
//                           border: OutlineInputBorder(),
//                         ),
//                         keyboardType: TextInputType.phone,
//                       ),

//                       const SizedBox(height: 20),

//                       //Button to Submit Data
//                       ElevatedButton(
//                         onPressed: _editContact,
//                         child: const Text('Edit Contact'),
//                       )
//                     ])));
//   }
// }
import 'package:flutter/material.dart';
import '../services/edit_contact.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class EditContactScreen extends StatefulWidget {
  final String cid;
  final String cname;
  final String cnum;

  const EditContactScreen({
    super.key,
    required this.cid,
    required this.cname,
    required this.cnum,
  });

  @override
  EditContactScreenState createState() => EditContactScreenState();
}

class EditContactScreenState extends State<EditContactScreen> {
  // Controllers to capture user input
  late TextEditingController _nameController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.cname);
    _phoneController = TextEditingController(text: widget.cnum);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  // Function to show Sweet Alert for success or failure
  void _showAlert(String title, String message, DialogType type) {
    AwesomeDialog(
      context: context,
      dialogType: type,
      animType: AnimType.scale,
      title: title,
      desc: message,
      btnOkOnPress: () {},
    ).show();
  }

  // Function to submit updated contact data
  // Function to submit updated contact data
  Future<void> _editContact() async {
    String fullname = _nameController.text.trim();
    String phone = _phoneController.text.trim();

    // Validate input fields
    if (fullname.isEmpty || phone.isEmpty) {
      _showAlert("Error", "Please fill in all fields", DialogType.error);
      return;
    }

    try {
      // Call API service to edit a contact
      String result =
          await EditContact.editContact(fullname, phone, widget.cid);

      // Check if update was successful
      if (result.toLowerCase() == "success") {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.scale,
          title: "Success",
          desc: "Contact edited successfully",
          btnOkOnPress: () {
            Navigator.pop(context, {'cname': fullname, 'cnum': phone});
          },
        ).show();
      } else {
        _showAlert(
            "Error", "Failed to edit contact. Try again", DialogType.error);
      }
    } catch (e) {
      _showAlert("Error", "Something went wrong: $e", DialogType.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Edit Contact',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color.fromARGB(255, 1, 48, 8),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Full Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _phoneController,
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _editContact,
                    child: const Text('Save Changes'),
                  )
                ])));
  }
}
