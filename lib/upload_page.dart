import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'food_hunger_page.dart';

import 'blood_loss_page.dart';
import 'orphan_donations.dart';
import 'orphans_page.dart';
import 'package:nmercy/auth/login_screen.dart';
class UploadPage extends StatefulWidget {
  const UploadPage({Key? key}) : super(key: key);

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _bloodGroupController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _mapsUrlController = TextEditingController();
  final TextEditingController _contactController = TextEditingController(); // Added contact field

  String? _selectedBloodGroup;
  DateTime? _selectedDOB;

  final List<String> _bloodGroups = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];

  void _selectDOB(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime(2050),
    );
    if (picked != null && picked != _selectedDOB) {
      setState(() {
        _selectedDOB = picked;
      });
    }
  }

  void _uploadDetails() async {
    if (_usernameController.text.isNotEmpty &&
        _cityController.text.isNotEmpty &&
        _areaController.text.isNotEmpty &&
        _selectedBloodGroup != null &&
        _selectedDOB != null &&
        _mapsUrlController.text.isNotEmpty &&
        _contactController.text.isNotEmpty) {
      try {
        // Reference to Firestore collection
        CollectionReference bloodDonations = FirebaseFirestore.instance.collection('bloodDonations');
        
        // Add the data to Firestore
        await bloodDonations.add({
          'username': _usernameController.text,
          'city': _cityController.text,
          'area': _areaController.text,
          'bloodGroup': _selectedBloodGroup,
          'dob': _selectedDOB,
          'mapsUrl': _mapsUrlController.text,
          'contact': _contactController.text, // Adding the contact number
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Details uploaded successfully!', style: TextStyle(color: Colors.white)),
            backgroundColor: Colors.green,
          ),
        );

        // Clear fields after upload
        setState(() {
          _usernameController.clear();
          _cityController.clear();
          _areaController.clear();
          _bloodGroupController.clear();
          _dobController.clear();
          _mapsUrlController.clear();
          _contactController.clear(); // Clear contact field
          _selectedBloodGroup = null;
          _selectedDOB = null;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error uploading details! Please try again.', style: TextStyle(color: Colors.white)),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please complete all fields!', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       backgroundColor: Colors.white,
        title: const Text(
          'Uplod Blood Donation',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.fastfood, color: Colors.black),
              title: Text(
                'Food Hunger Deaths',
                style: TextStyle(color: Colors.black),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => FoodHungerPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.bloodtype, color: Colors.black),
              title: Text(
                'Blood Loss Deaths',
                style: TextStyle(color: Colors.black),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => BloodLossPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.child_care, color: Colors.black),
              title: Text(
                'Orphans Problems',
                style: TextStyle(color: Colors.black),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => OrphansPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.volunteer_activism, color: Colors.black),
              title: Text(
                'My Orphan Donations',
                style: TextStyle(color: Colors.black),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyOrphanDonationsPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.black),
              title: Text(
                'Logout',
                style: TextStyle(color: Colors.black),
              ),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _usernameController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    labelStyle: TextStyle(color: Colors.white70),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white70),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _cityController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'City',
                    labelStyle: TextStyle(color: Colors.white70),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white70),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _areaController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Area',
                    labelStyle: TextStyle(color: Colors.white70),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white70),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: _selectedBloodGroup,
                  style: const TextStyle(color: Colors.red),
                  dropdownColor: Colors.grey[900],
                  decoration: const InputDecoration(
                    labelText: 'Blood Group',
                    labelStyle: TextStyle(color: Colors.white70),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white70),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  ),
                  items: _bloodGroups.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: const TextStyle(color: Colors.white)),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedBloodGroup = newValue;
                    });
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Date of Birth:',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    TextButton(
                      onPressed: () => _selectDOB(context),
                      child: Text(
                        _selectedDOB == null
                            ? 'Select DOB'
                            : '${_selectedDOB!.day}/${_selectedDOB!.month}/${_selectedDOB!.year}',
                        style: const TextStyle(color: Colors.red, fontSize: 16),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _mapsUrlController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Blood Donation Maps URL',
                    labelStyle: TextStyle(color: Colors.white70),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white70),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _contactController, // Contact field
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Contact',
                    labelStyle: TextStyle(color: Colors.white70),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white70),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _uploadDetails,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                  child: const Text(
                    'Upload',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _cityController.dispose();
    _areaController.dispose();
    _bloodGroupController.dispose();
    _dobController.dispose();
    _mapsUrlController.dispose();
    _contactController.dispose(); // Dispose of contact controller
    super.dispose();
  }
}
