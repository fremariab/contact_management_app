//Github Link: https://github.com/fremariab/contact_management_app

// Importing necessary Flutter packages
import 'package:flutter/material.dart';

// Importing screen files for navigation
import 'screens/contacts_list.dart';
import 'screens/add_contact.dart';
import 'screens/about.dart';

// Main function that starts the Flutter app
void main() {
  runApp(const CMSApp());
}

// Defining the main application widget
class CMSApp extends StatelessWidget {
  // Constructor for CMSApp
  const CMSApp({super.key});

  // Building the root of the application
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Setting the app title
      title: 'CMS App', 
      theme: ThemeData(
        // Defining the theme of the application
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 1, 48, 8)), 
            // Enabling Material 3 design features
        useMaterial3: true, 
      ),
      // Setting the home screen of the app
      home: const CMSHomePage(), 
    );
  }
}

// Stateful widget for the main homepage
class CMSHomePage extends StatefulWidget {
  // Constructor for CMSHomePage
  const CMSHomePage({super.key});

  @override
  State<CMSHomePage> createState() => _CMSHomePageState();
}

// Defining the state for CMSHomePage
class _CMSHomePageState extends State<CMSHomePage> {
  // Variable to track the selected index of the bottom navigation bar
  int _selectedIndex = 0;

  // List of screens corresponding to the navigation bar items
  final List<Widget> _screens = [
    ContactsListScreen(), // Contacts list screen
    AddContactScreen(), // Add new contact screen
    AboutScreen(), // About screen
  ];

  // Function to handle navigation bar item selection
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Updating selected index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Using IndexedStack to maintain state when switching screens
      body: IndexedStack(
        index: _selectedIndex, // Displaying the selected screen
        children: _screens, // Providing the list of available screens
      ),

      // Bottom navigation bar for navigating between screens
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.contacts), // Contacts icon
            label: 'Contacts', // Contacts tab label
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add), // Add contact icon
            label: 'Add', // Add tab label
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info), // About icon
            label: 'About', // About tab label
          ),
        ],
        currentIndex: _selectedIndex, // Setting the selected tab index
        selectedItemColor:
            const Color.fromARGB(255, 1, 48, 8), // Setting the selected item color
        onTap: _onItemTapped, // Calling function when an item is tapped
      ),
    );
  }
}
