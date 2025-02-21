// Import the HTTP package to make network requests
import 'package:http/http.dart' as http;

// Define a class `AddNewContact` to handle adding a new contact
class EditContact {
  // Define a static function `addNewContact` that takes `fullname`, `cid` and `phone` as parameters
  static Future<String> editContact(
      String fullname, String phone, String cid) async {
    // Makes an HTTP POST request to the API endpoint to add a contact
    final response = await http.post(
        // Converts the API URL to a URI object
        Uri.parse(
            'https://apps.ashesi.edu.gh/contactmgt/actions/update_contact'),
        // Specify that the request body is form-encoded
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        // Send the contact data in the request body as form data
        body: {
          // Assign the full name to the `cname` field
          'cname': fullname,
          // Assign the phone number to the `cnum` field
          'cnum': phone,
          // Assign the contact id to the `cid` field
          'cid': cid
        });

    // Check if the request was successful (status code 200)
    if (response.statusCode == 200) {
      // Return the response body (either "success" or "failed")
      return response.body;
    } else {
      // If the request fails, it will throw an exception with the error message from the response
      throw Exception('Failedd to edit contact. Error: ${response.body}');
    }
  }
}
