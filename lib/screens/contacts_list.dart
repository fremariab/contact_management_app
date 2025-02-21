//importing flutter material package for UI components
import 'package:flutter/material.dart';

//importing services for API interactions
import '../services/get_all_contacts.dart';
import '../services/get_single_contact.dart';
import '../services/delete_contact.dart';

//importing screens for navigation
import '../screens/edit_contact.dart';
import '../screens/contact_info.dart';

//importing awesome_dialog package for alert dialogs
import 'package:awesome_dialog/awesome_dialog.dart';

//defining a stateful widget for displaying the list of contacts
class ContactsListScreen extends StatefulWidget {
  const ContactsListScreen({super.key});

  @override
  ContactsListScreenState createState() => ContactsListScreenState();
}

//state class for managing the contacts list screen
class ContactsListScreenState extends State<ContactsListScreen> {
  //holds the data of a single contact when needed
  Map<String, dynamic>? contactData;

  //list to store all fetched contacts
  List<Map<String, dynamic>>? contactsList;

  @override
  void initState() {
    super.initState();
    fetchAllContacts(); //fetch contacts when screen loads
  }

  //fetch all contacts from API and update UI
  Future<void> fetchAllContacts() async {
    try {
      final data = await GetAllContacts.fetchAllContacts();
      setState(() {
        contactsList = data; //update contacts list with fetched data
      });
    } catch (e) {
      debugPrint("Error fetching contacts: $e");
    }
  }

  //fetch a single contact (not currently used)
  void fetchContact() async {
    try {
      final data = await GetSingleContact.fetchContact(54);
      setState(() {
        contactData = data;
      });
    } catch (e) {
      debugPrint("Error fetching contact: $e");
    }
  }

  //function to display a Sweet Alert for success or failure messages
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

  //function to delete a contact
  void deleteContact(String cid) async {
    try {
      String result = await DeleteContact.deleteContact(cid);

      if (!mounted) return;

      if (result.isEmpty || result.toLowerCase().contains("success")) {
        //create a new list excluding the deleted contact to avoid unnecessary rebuilds
        final updatedList = contactsList!
            .where((contact) => contact['pid'].toString() != cid)
            .toList();

        setState(() {
          contactsList = updatedList; //update UI with modified list
        });

        _showAlert(
            "Success", "Contact deleted successfully!", DialogType.success);
      } else {
        _showAlert("Error", "Failed to delete contact", DialogType.error);
      }
    } catch (e) {
      debugPrint("Error deleting contact: $e");
    }
  }

  //confirmation dialog before deleting a contact
  void confirmDeleteContact(String cid) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Deletion"),
          content: const Text("Are you sure you want to delete this contact?"),
          actions: [
            //cancel button to dismiss dialog
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Color.fromARGB(255, 1, 48, 8)),
                )),
            //delete button to proceed with deletion
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                deleteContact(cid);
              },
              child: const Text(
                "Delete",
                style: TextStyle(
                    color: Color.fromARGB(
                        255, 1, 48, 8)), //highlight delete option in red
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contacts List')), //app title

      //body containing the contacts list
      body: contactsList == null
          ? const Center(
              child:
                  CircularProgressIndicator()) //show loader while fetching data
          : RefreshIndicator(
              //allows pull-to-refresh functionality
              onRefresh: fetchAllContacts,
              child: ListView.builder(
                physics:
                    const AlwaysScrollableScrollPhysics(), //enables smooth scrolling effect
                itemCount:
                    contactsList!.length, //sets the number of items in the list
                itemBuilder: (context, index) {
                  final contact = contactsList![index];

                  return ListTile(
                    title: Text(
                      contact['pname'] ?? 'No name', //display contact name
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(contact['pphone'] ??
                        'No number'), //display phone number
                    leading:
                        const Icon(Icons.person), //person icon for each contact
                    tileColor: index % 2 == 0
                        ? const Color.fromARGB(
                            145, 138, 203, 148) //alternating row color
                        : Colors.white,

                    //navigate to contact details when tapped
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ContactInfoScreen(
                            cid: contact['pid'].toString(),
                            cname: contact['pname'],
                            cnum: contact['pphone'],
                          ),
                        ),
                      );
                    },

                    //trailing icons for editing and deleting contacts
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //edit button
                        IconButton(
                          icon: const Icon(Icons.edit,
                              color: Color.fromARGB(255, 1, 48, 8)),
                          onPressed: () async {
                            final updatedContact = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditContactScreen(
                                  cid: contact['pid'].toString(),
                                  cname: contact['pname'],
                                  cnum: contact['pphone'],
                                ),
                              ),
                            );

                            // If an updated contact is returned, update the list
                            if (updatedContact != null &&
                                updatedContact is Map<String, dynamic>) {
                              setState(() {
                                final index = contactsList!.indexWhere((c) =>
                                    c['pid'].toString() ==
                                    contact['pid'].toString());
                                if (index != -1) {
                                  contactsList![index] = {
                                    'pid': contact['pid'], // Keep the same ID
                                    'pname':
                                        updatedContact['cname'], // Update name
                                    'pphone':
                                        updatedContact['cnum'], // Update phone
                                  };
                                }
                              });
                            }
                          },
                        ),

                        //delete button
                        IconButton(
                          icon: const Icon(Icons.delete,
                              color: Color.fromARGB(255, 1, 48, 8)),
                          onPressed: () =>
                              confirmDeleteContact(contact['pid'].toString()),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
    );
  }
}
