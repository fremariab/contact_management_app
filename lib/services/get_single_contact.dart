// Importing necessary packages
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';

// Class responsible for fetching a single contact from the API
class GetSingleContact {
  // Function to fetch details of a specific contact based on their ID
  static Future<Map<String, dynamic>?> fetchContact(int contid) async {
    // Sending an HTTP GET request to the API with the contact ID as a query parameter
    final response = await http.get(
      Uri.parse(
          'https://apps.ashesi.edu.gh/contactmgt/actions/get_a_contact_mob?contid=$contid'),
    );

    // Checking if the request was successful (status code 200 means success)
    if (response.statusCode == 200) {
      // Decoding the JSON response into a Dart object
      final data = json.decode(response.body);
      // Printing API response for debugging
      debugPrint("API Response: $data");
      // Returning the decoded JSON data as a map
      return json.decode(response.body);
    } else {
      // If the request failed, print an error message for debugging
      debugPrint("Error: ${response.statusCode} - ${response.body}");
      // Throwing an exception to indicate failure
      throw Exception('Failed to load contact');
    }
  }
}
