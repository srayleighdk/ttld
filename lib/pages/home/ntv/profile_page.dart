import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ttld/widgets/field/field.dart'; // For navigation (if using go_router)

// Placeholder for user data. Replace with your actual user model.
class User {
  final String name;
  final String email;
  // Add other relevant user information
  User({required this.name, required this.email});
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Placeholder user data. Replace with data fetched from your app's state.
  final User _user = User(name: "John Doe", email: "john.doe@example.com");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // For scrollability if content overflows
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Profile Picture (replace with your image widget)
            const Center(
              child: CircleAvatar(
                radius: 50,
                // You can use a NetworkImage, AssetImage, or your own image widget
                //backgroundImage: NetworkImage('url_to_profile_image'),
                child: Icon(Icons.person, size: 60), // Placeholder icon
              ),
            ),
            const SizedBox(height: 20),

            // User Information
            _buildUserInfoRow('Name', _user.name),
            _buildUserInfoRow('Email', _user.email),
            // Add more user info rows as needed

            const SizedBox(height: 20),

            // Change Password Button
            ElevatedButton(
              onPressed: () {
                // Navigate to change password page
                context.go('/change-password'); // Example using go_router
                // Or use Navigator.push:
                // Navigator.pushNamed(context, '/change-password');
              },
              child: const Text('Change Password'),
            ),

            const SizedBox(height: 10),

            // Logout Button
            ElevatedButton(
              onPressed: () {
                // Perform logout logic (e.g., clear tokens, update state)
                // After logout, navigate to the login screen
                context.go('/login'); // Example using go_router
                // Or use Navigator.pushReplacementNamed:
                // Navigator.pushReplacementNamed(context, '/login');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Example logout button color
              ),
              child:
                  const Text('Logout', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            '$label:',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 10),
          Text(value),
        ],
      ),
    );
  }
}
