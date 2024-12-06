import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:nmercy/auth/login_screen.dart';
import 'food_hunger_page.dart';
import 'blood_loss_page.dart';
import 'orphan_donations.dart';
import 'orphans_page.dart';

class FoodPage extends StatefulWidget {
  FoodPage({Key? key}) : super(key: key);

  @override
  _FoodPageState createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _searchQuery = "";

  void _launchMap(BuildContext context, String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not launch the map.')),
      );
    }
  }

  void _openUploadForm(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FoodUploadForm()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AnimatedDefaultTextStyle(
          style: const TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
          duration: const Duration(seconds: 1),
          child: const Text('Food Donation'),
        ),
         backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.red, size: 40),
            onPressed: () => _openUploadForm(context),
          ),
        ],
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  prefixIcon: const Icon(Icons.search, color: Colors.white),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value.toLowerCase();
                  });
                },
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.red[800]!,
                    Colors.black,
                    Colors.grey[850]!,
                    Colors.white,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.2, 0.5, 0.7, 1],
                ),
              ),
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('food_donations').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return const Center(child: Text('Error loading data'));
                  }
                  final foodDetails = snapshot.data?.docs.where((doc) {
                    final data = doc.data() as Map<String, dynamic>;
                    return data['username']?.toLowerCase().contains(_searchQuery) == true ||
                        data['location']?.toLowerCase().contains(_searchQuery) == true ||
                        data['foodType']?.toLowerCase().contains(_searchQuery) == true;
                  }).toList();

                  if (foodDetails == null || foodDetails.isEmpty) {
                    return const Center(
                      child: Text(
                        'No results found',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: foodDetails.length,
                    itemBuilder: (context, index) {
                      final item = foodDetails[index].data() as Map<String, dynamic>;
                      return Card(
                        color: Colors.black,
                        margin: const EdgeInsets.all(10),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'User: ${item['username']}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Food Type: ${item['foodType']}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white70,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Phone: ${item['phoneNumber']}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white70,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Quantity: ${item['quantity']}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white70,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Pickup Time: ${item['pickupTime']}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white70,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Container Required: ${item['containerRequired']}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white70,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Location: ${item['location']}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white70,
                                ),
                              ),
                              const SizedBox(height: 10),
                              ElevatedButton.icon(
                                onPressed: () => _launchMap(context, item['locationUrl']),
                                icon: const Icon(Icons.map, color: Colors.white),
                                label: const Text(
                                  'View Map',
                                  style: TextStyle(color: Colors.white),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey[800],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}




class FoodUploadForm extends StatefulWidget {
  @override
  _FoodUploadFormState createState() => _FoodUploadFormState();
}

class _FoodUploadFormState extends State<FoodUploadForm> {
  final _formKey = GlobalKey<FormState>();
  String? _foodType;
  String? _containerRequirement;
  String _username = '';
  String _phoneNumber = '';
  String _location = '';
  String _locationUrl = '';
  String _quantity = '';
  String _pickupTime = '';

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _sendNotification(String title, String body) async {
    const String serverKey = 'BKRSb4u3_XSWTOc3X4vhN4FtU97yciWY2tt2tJG4JEmjwoMGLxhLxRtjEgZH7Z5IIHU_CkLyNRCsJi1eVxX-KfE'; // Replace with your FCM server key
    const String fcmUrl = 'https://fcm.googleapis.com/fcm/send';

    try {
      final response = await http.post(
        Uri.parse(fcmUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverKey',
        },
        body: '''
        {
          "to": "/topics/allUsers",
          "notification": {
            "title": "$title",
            "body": "$body"
          }
        }
        ''',
      );

      if (response.statusCode == 200) {
        print('Notification sent successfully');
      } else {
        print('Failed to send notification: ${response.body}');
      }
    } catch (e) {
      print('Error sending notification: $e');
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _firestore.collection('food_donations').add({
        'username': _username,
        'foodType': _foodType,
        'phoneNumber': _phoneNumber,
        'location': _location,
        'locationUrl': _locationUrl,
        'quantity': _quantity,
        'pickupTime': _pickupTime,
        'containerRequired': _containerRequirement,
      }).then((value) {
        // Send notification to all users
        _sendNotification(
          'New Food Donation Available!',
          '$_username has donated $_quantity $_foodType food at $_location.',
        );
        Navigator.pop(context);
      }).catchError((error) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Upload Food Donation', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Name',
                  labelStyle: TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Colors.black,
                ),
                style: const TextStyle(color: Colors.white),
                onChanged: (value) => _username = value,
                validator: (value) => value!.isEmpty ? 'Please enter a name' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Phone',
                  labelStyle: TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Colors.black,
                ),
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.phone,
                onChanged: (value) => _phoneNumber = value,
                validator: (value) => value!.isEmpty ? 'Please enter a phone number' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Location',
                  labelStyle: TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Colors.black,
                ),
                style: const TextStyle(color: Colors.white),
                onChanged: (value) => _location = value,
                validator: (value) => value!.isEmpty ? 'Please enter a location' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Location URL',
                  labelStyle: TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Colors.black,
                ),
                style: const TextStyle(color: Colors.white),
                onChanged: (value) => _locationUrl = value,
                validator: (value) => value!.isEmpty ? 'Please enter a location URL' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Quantity',
                  labelStyle: TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Colors.black,
                ),
                style: const TextStyle(color: Colors.white),
                onChanged: (value) => _quantity = value,
                validator: (value) => value!.isEmpty ? 'Please enter a quantity' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Pickup Time',
                  labelStyle: TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Colors.black,
                ),
                style: const TextStyle(color: Colors.white),
                onChanged: (value) => _pickupTime = value,
                validator: (value) => value!.isEmpty ? 'Please enter a pickup time' : null,
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: _foodType,
                decoration: const InputDecoration(
                  labelText: 'Food Type',
                  labelStyle: TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Colors.black,
                ),
                items: ['Veg', 'Non veg'].map((foodType) {
                  return DropdownMenuItem(
                    value: foodType,
                    child: Text(
                      foodType,
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                }).toList(),
                onChanged: (value) => setState(() {
                  _foodType = value;
                }),
                validator: (value) =>
                    value == null ? 'Please select a food type' : null,
                dropdownColor: Colors.black,
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: _containerRequirement,
                decoration: const InputDecoration(
                  labelText: 'Container Required',
                  labelStyle: TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Colors.black,
                ),
                items: ['Yes', 'No'].map((container) {
                  return DropdownMenuItem(
                    value: container,
                    child: Text(
                      container,
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                }).toList(),
                onChanged: (value) => setState(() {
                  _containerRequirement = value;
                }),
                validator: (value) =>
                    value == null ? 'Please select container requirement' : null,
                dropdownColor: Colors.black,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Submit'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}