import 'package:flutter/material.dart';

class ContactInfoScreen extends StatefulWidget {
  final String cid;
  final String cname;
  final String cnum;

  const ContactInfoScreen({
    super.key,
    required this.cid,
    required this.cname,
    required this.cnum,
  });

  @override
  ContactInfoScreenState createState() => ContactInfoScreenState();
}

class ContactInfoScreenState extends State<ContactInfoScreen> {
  late String cname;
  late String cnum;

  @override
  void initState() {
    super.initState();
    cname = widget.cname; // Initialize the name
    cnum = widget.cnum; // Initialize the phone number
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Contact Details',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 1, 48, 8),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const CircleAvatar(
              radius: 50,
              backgroundColor: Color.fromARGB(255, 1, 48, 8),
              child: Icon(
                Icons.person,
                size: 60,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Name: $cname",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Phone: $cnum",
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
