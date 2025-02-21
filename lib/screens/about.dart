// Importing the Flutter Material package to access UI components
import 'package:flutter/material.dart';

// Creating a StatelessWidget as this screen will not change dynamically
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Sets the title of the page in the AppBar
        title: const Text(
          'About',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 1, 48, 8),
      ),
      // Provides spacing around the content to improve readability
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          // Aligns all content to the center horizontally
          crossAxisAlignment: CrossAxisAlignment.center,
          // Ensures all elements are centered vertically on the screen
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Displaying the App Name
            const Text(
              'Contact Management App',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 5),

            const Text(
              'Version 1.0.0',
              style: TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
                height: 20), // Larger spacing before moving to the next section

            // My Name to show that I am the developer
            const Text(
              'Freda-Marie Beecham',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),

            // Student ID
            const Text(
              'Student ID | 06532025',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20),

            // A user-friendly explanation of the app’s purpose
            const Text(
              'This app provides a simple and efficient way to manage contacts. '
              'Users can add, edit, and delete contacts, ensuring that their '
              'contact list remains organized and up to date. '
              'Additionally, it allows users to view detailed contact information, '
              'making it easy to keep track of important connections.',
              style: TextStyle(
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
