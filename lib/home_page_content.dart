import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'search.dart';
import 'BloodDonationPage.dart';
import 'food_hunger_page.dart';
import 'blood_loss_page.dart';
import 'orphan_donations.dart';
import 'orphans_page.dart';
import 'package:nmercy/auth/login_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(MaterialApp(
    home: HomePageContent(),
  ));
}

class HomePageContent extends StatefulWidget {
  @override
  _HomePageContentState createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  bool _isIconVisible = true;
  bool _isRed = false;

  // List to store user data from Firestore
  List<User> users = [];

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 3), (timer) {
      setState(() {
        _isRed = !_isRed;
      });
    });
    _fetchUsers(); // Fetch users data from Firestore
  }

  // Fetch data from Firestore
  Future<void> _fetchUsers() async {
    try {
      final QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('bloodDonations').get();
      setState(() {
        users = snapshot.docs.map((doc) {
          return User(
            doc['username'] ?? '', // Added username
            doc['area'] ?? '',
            doc['bloodGroup'] ?? '',
            (doc['dob'] as Timestamp).toDate().toString(), // Convert timestamp to string
            doc['city'] ?? '',
            doc['mapsUrl'] ?? '',
            doc['contact'] ?? '', // Added contact field
          );
        }).toList();
      });
    } catch (e) {
      print('Error fetching users: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Blood need',
          style: TextStyle(
            color: _isRed ? Colors.red : Colors.black,
            // fontStyle: FontStyle.bold,
            fontSize: 25,
          ),
        ),
        actions: [
          if (_isIconVisible)
            IconButton(
              icon: Icon(Icons.bloodtype_outlined, color: Colors.black, size: 30.0),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BloodDonationPage()),
                );
              },
            ),
          IconButton(
            icon: Icon(Icons.search, color: Colors.black, size: 30.0),
            onPressed: () {
              // Navigate to the SearchTab screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchTab()),
              );
            },
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
      body: Container(
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
        padding: EdgeInsets.all(16.0),
        child: users.isEmpty
            ? Center(child: CircularProgressIndicator()) // Show loading indicator
            : ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return UserCard(user: users[index]);
                },
              ),
      ),
    );
  }
}

class User {
  final String username;
  final String area;
  final String bloodGroup;
  final String dob;
  final String city;
  final String mapsUrl;
  final String contact;

  User(this.username, this.area, this.bloodGroup, this.dob, this.city, this.mapsUrl, this.contact);
}

class UserCard extends StatelessWidget {
  final User user;

  UserCard({required this.user});

  Future<void> _launchMap(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _launchPhone(String phone) async {
    final url = 'tel:$phone';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.account_circle, color: Colors.white, size: 30),
              SizedBox(width: 10),
              Text(
                user.username,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.location_on, color: Colors.white, size: 20),
              SizedBox(width: 5),
              Text(
                'Location: ${user.city}',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.location_city, color: Colors.white, size: 20),
              SizedBox(width: 5),
              Text(
                'Area: ${user.area}',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.phone, color: Colors.white, size: 20),
              SizedBox(width: 5),
              Text(
                'Contact: ${user.contact}',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ],
          ),
          SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.bloodtype, color: Colors.red, size: 20),
              SizedBox(width: 5),
              Text(
                'Blood Group Needed: ${user.bloodGroup}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
              ),
            ],
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => _launchMap(user.mapsUrl),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: Text(
              'Find Blood Donation Center',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
