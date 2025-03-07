# Contact Management App

## Overview
The **Contact Management App** is a Flutter-based mobile application that allows users to manage their contacts seamlessly. The app features a bottom navigation bar, smooth navigation between screens, and REST API integration for managing contacts.

## Features
- **Bottom Navigation**: Easy access to different sections of the app.
- **Contact List**: View all saved contacts in a structured format.
- **Add Contact**: Add new contacts with a simple form.
- **Edit Contact**: Modify existing contact details.
- **Delete Contact**: Remove unwanted contacts.
- **About Section**: Displays app details, including version information.
- **API Integration**: Connects to a backend to store and retrieve contacts.

## Installation
### Prerequisites
Ensure you have the following installed:
- **Flutter SDK**
- **Android Studio** or **VS Code** with Flutter plugins
- A working **emulator or physical device**

### Steps to Run the App
1. Clone the repository:
   ```sh
   git clone https://github.com/yourusername/contact_management_app.git
   cd contact_management_app
   ```
2. Install dependencies:
   ```sh
   flutter pub get
   ```
3. Run the application:
   ```sh
   flutter run
   ```

## Folder Structure
```
lib/
 ├── screens/
 │   ├── contacts_list.dart
 │   ├── add_contact.dart
 │   ├── edit_contact.dart
 │   ├── about.dart
 ├── services/
 │   ├── api_service.dart
 ├── models/
 │   ├── contact_model.dart
 ├── main.dart
```

## API Integration
This app interacts with a REST API to manage contacts. Below are the API endpoints used:

### Fetch All Contacts
- **Endpoint:** `https://apps.ashesi.edu.gh/contactmgt/actions/get_all_contact_mob`
- **Method:** `GET`
- **Response:** JSON list of contacts

### Fetch a Single Contact
- **Endpoint:** `https://apps.ashesi.edu.gh/contactmgt/actions/get_a_contact_mob?contid=6`
- **Method:** `GET`
- **Response:** JSON object of contact details

### Add a New Contact
- **Endpoint:** `https://apps.ashesi.edu.gh/contactmgt/actions/add_contact_mob`
- **Method:** `POST`
- **Payload:** `{ufullname: data, uphonename: data}`
- **Response:** Success/Failure message

### Edit a Contact
- **Endpoint:** `https://apps.ashesi.edu.gh/contactmgt/actions/update_contact`
- **Method:** `POST`
- **Payload:** `{cname: data, cnum: data, cid: data}`
- **Response:** Success/Failure message

### Delete a Contact
- **Endpoint:** `https://apps.ashesi.edu.gh/contactmgt/actions/delete_contact`
- **Method:** `POST`
- **Payload:** `{cid: data}`
- **Response:** Boolean (true/false) or HTTP status code

## Screenshots
*(Include relevant screenshots here)*

## Testing Credentials
- **Home Page:** [Manage Contacts](https://apps.ashesi.edu.gh/contactmgt/view/manage_contact)
- **Standard User:** `standard@gmail.com` (Password: `54321`)
- **Admin User:** `admin@gmail.com` (Password: `12345`)

## Contribution
Contributions are welcome! If you find issues or want to add features, feel free to fork the repository and submit a pull request.

## License
This project is licensed under the MIT License.

## Contact
For any queries, reach out via email at `your.email@example.com`.

---
Developed by **Freda-Marie Beecham**
