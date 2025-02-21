// Import the HTTP package to enable API calls
import 'package:http/http.dart' as http;

// Define a class to handle deleting a contact
class DeleteContact {
  // Define a static method that takes a contact ID (cid) and deletes the contact
  static Future<String> deleteContact(String cid) async {
    // Make a POST request to the delete contact API endpoint
    final response = await http.post(
      // API URL
      Uri.parse('https://apps.ashesi.edu.gh/contactmgt/actions/delete_contact'),
      // Ensure the request is sent as form data
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      // Send the contact ID as form data
      body: {'cid': cid},
    );

    if (response.statusCode == 200) {
      return response.body.trim(); // Trim to remove unwanted whitespace
      // // Check if the API response status code is 200 (OK)
      // if (response.statusCode == 200) {
      //    // Return the API response (either a success or failure message)
      //   return response.body;
    } else {
      // If the status code is not 200, it will throw an exception with an error message
      throw Exception('Failed to delete contact');
    }
  }
}
