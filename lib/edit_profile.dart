// edit_profile.dart

import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  // Add more controllers for other profile fields as needed

  @override
  void initState() {
    super.initState();
    // Initialize controllers with existing user data
    _nameController.text = 'John Doe'; // Replace with actual user data
    _emailController.text =
        'john.doe@example.com'; // Replace with actual user data
    // ... initialize other controllers
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  // You can add more email validation here if needed
                  return null;
                },
              ),
              // Add more TextFormField widgets for other profile fields

              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Process profile data
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Saving Changes')),
                      );

                      // Access updated profile data
                      String name = _nameController.text;
                      String email = _emailController.text;
                      // ... access other updated profile data

                      // TODO: Save the updated profile data
                      // TODO: Navigate back to the ProfilePage
                    }
                  },
                  child: const Text('Save Changes'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
