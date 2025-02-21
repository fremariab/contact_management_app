// Importing necessary packages

// Provides HTTP methods for API requests
import 'package:http/http.dart' as http;
// Provides Flutter UI components
import 'package:flutter/material.dart';
// Enables JSON encoding and decoding
import 'dart:convert';

// Class to handle fetching all contacts from the API
class GetAllContacts {
  // Function to fetch all contacts from the API
  static Future<List<Map<String, dynamic>>> fetchAllContacts() async {
    // Sending an HTTP GET request to the API endpoint
    final response = await http.get(
      Uri.parse(
          'https://apps.ashesi.edu.gh/contactmgt/actions/get_all_contact_mob'),
    );

    // Checking if the request was successful (status code 200 means success)
    if (response.statusCode == 200) {
      // Decoding the JSON response into a Dart object
      final data = json.decode(response.body);
      // Converting the JSON data into a list of maps and returning it
      return List<Map<String, dynamic>>.from(data);
    } else {
      // If the request failed, print an error message for debugging
      debugPrint("Error: ${response.statusCode} - ${response.body}");
      // Throwing an exception to indicate failure
      throw Exception('Failed to load contact');
    }
  }
}
