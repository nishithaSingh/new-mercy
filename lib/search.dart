import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchTab extends StatefulWidget {
  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> users = [];
  String searchQuery = '';
  String? selectedBloodGroup;
  String? selectedLocation;

  final List<String> bloodGroups = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-', 'All'];
  final List<String> locations = ['Bangalore', 'Chennai', 'Mumbai', 'Delhi', 'Pune', 'Kolkata'];

  @override
  void initState() {
    super.initState();
    _fetchUsersFromFirestore();
  }

  Future<void> _fetchUsersFromFirestore() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('users').get();
      List<Map<String, dynamic>> userList = snapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        data.remove('password'); // Remove the password field
        return data;
      }).toList();

      setState(() {
        users = userList;
      });
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredUsers = users.where((user) {
      bool matchesSearchQuery = user['username']!.toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesBloodGroup = selectedBloodGroup == null || selectedBloodGroup == 'All' || user['blood_group'] == selectedBloodGroup;
      bool matchesLocation = selectedLocation == null || user['state'] == selectedLocation;
      return matchesSearchQuery && matchesBloodGroup && matchesLocation;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Search Donor',
          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[850],
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(color: Colors.grey.withOpacity(0.3), blurRadius: 10, spreadRadius: 2),
                ],
              ),
              child: TextField(
                style: TextStyle(color: Colors.white),
                onChanged: (query) {
                  setState(() {
                    searchQuery = query;
                  });
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search user...',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  prefixIcon: Icon(Icons.search, color: Colors.white),
                  contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.filter_list, color: Colors.white),
                  onPressed: () {
                    _showFilterDialog(context);
                  },
                ),
                Text('Filter', style: TextStyle(color: Colors.white, fontSize: 18)),
                SizedBox(width: 10),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: bloodGroups.map((bloodGroup) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: ChoiceChip(
                            label: Text(
                              bloodGroup,
                              style: TextStyle(color: Colors.white),
                            ),
                            selected: selectedBloodGroup == bloodGroup,
                            backgroundColor: Colors.grey[600]!,
                            selectedColor: Colors.red,
                            onSelected: (selected) {
                              setState(() {
                                selectedBloodGroup = selected ? bloodGroup : null;
                              });
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Expanded(
              child: filteredUsers.isNotEmpty
                  ? ListView.builder(
                      itemCount: filteredUsers.length,
                      itemBuilder: (context, index) {
                        final user = filteredUsers[index];
                        return Card(
                          color: Colors.grey[850],
                          margin: EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.black,
                              radius: 30,
                              child: Icon(Icons.person, color: Colors.white, size: 50),
                            ),
                            title: Text(
                              user['username']!,
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            subtitle: Text(
                              '${user['blood_group']} - ${user['state']}',
                              style: TextStyle(color: Colors.white),
                            ),
                            contentPadding: EdgeInsets.all(15),
                            onTap: () {
                              _showUserDetailsDialog(user);
                            },
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Text(
                        'No users found',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[850],
          title: Text('Filter by Blood Group and Location', style: TextStyle(color: Colors.white)),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Blood Group:', style: TextStyle(color: Colors.white)),
                SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: bloodGroups.map((bloodGroup) {
                    return ChoiceChip(
                      label: Text(bloodGroup, style: TextStyle(color: Colors.white)),
                      selected: selectedBloodGroup == bloodGroup,
                      backgroundColor: Colors.red[600]!,
                      selectedColor: Colors.red[800]!,
                      onSelected: (selected) {
                        setState(() {
                          selectedBloodGroup = selected ? bloodGroup : null;
                        });
                      },
                    );
                  }).toList(),
                ),
                SizedBox(height: 20),
                Text('Location:', style: TextStyle(color: Colors.white)),
                SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: locations.map((location) {
                    return ChoiceChip(
                      label: Text(location, style: TextStyle(color: Colors.white)),
                      selected: selectedLocation == location,
                      backgroundColor: Colors.grey[600]!,
                      selectedColor: Colors.red,
                      onSelected: (selected) {
                        setState(() {
                          selectedLocation = selected ? location : null;
                        });
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Close', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void _showUserDetailsDialog(Map<String, dynamic> user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[850],
          title: Text('User Details', style: TextStyle(color: Colors.white)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Name: ${user['username']}', style: TextStyle(color: Colors.white)),
              SizedBox(height: 10),
              Text('Blood Group: ${user['blood_group']}', style: TextStyle(color: Colors.white)),
              SizedBox(height: 10),
              Text('Location: ${user['state']}', style: TextStyle(color: Colors.white)),
              SizedBox(height: 10),
              Text('Phone Number: ${user['phone_number']}', style: TextStyle(color: Colors.white)),
              SizedBox(height: 10),
              Text('Alternate Phone: ${user['alt_phone_number']}', style: TextStyle(color: Colors.white)),
              SizedBox(height: 10),
              Text('Address: ${user['address']}', style: TextStyle(color: Colors.white)),
              SizedBox(height: 10),
              Text('Email: ${user['email']}', style: TextStyle(color: Colors.white)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Close', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
