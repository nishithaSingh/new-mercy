// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'OrphanageDetailsPage.dart';
// import 'package:nmercy/auth/login_screen.dart';
// import 'food_hunger_page.dart';
// import 'blood_loss_page.dart';
// import 'orphan_donations.dart';
// import 'orphans_page.dart';

// class OrphanKidPage extends StatefulWidget {
//   OrphanKidPage({Key? key}) : super(key: key);

//   @override
//   _OrphanKidPageState createState() => _OrphanKidPageState();
// }

// class _OrphanKidPageState extends State<OrphanKidPage> {
//   List<Map<String, dynamic>> orphanages = [];
//   List<Map<String, dynamic>> filteredOrphanages = [];
//   String searchQuery = '';

//   @override
//   void initState() {
//     super.initState();
//     fetchOrphanages();
//   }

//   void fetchOrphanages() async {
//     try {
//       // Fetch data from Firestore
//       QuerySnapshot snapshot =
//           await FirebaseFirestore.instance.collection('orphanages').get();

//       // Map Firestore data to local state
//       List<Map<String, dynamic>> fetchedOrphanages = snapshot.docs.map((doc) {
//         return {
//           'id': doc.id,
//           ...doc.data() as Map<String, dynamic>,
//         };
//       }).toList();

//       setState(() {
//         orphanages = fetchedOrphanages;
//         filteredOrphanages = fetchedOrphanages;
//       });
//     } catch (error) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error fetching orphanages: $error')),
//       );
//     }
//   }

//   void updateSearchQuery(String query) {
//     setState(() {
//       searchQuery = query;
//       filteredOrphanages = orphanages
//           .where((orphanage) =>
//               orphanage['name'].toLowerCase().contains(query.toLowerCase()))
//           .toList();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Orphanages',
//           style: TextStyle(color: Colors.black),
//         ),
//         backgroundColor: Colors.white,
//       ),
//       drawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: [
//             DrawerHeader(
//               decoration: BoxDecoration(
//                 color: Colors.black,
//               ),
//               child: Text(
//                 'Menu',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             ListTile(
//               leading: Icon(Icons.fastfood, color: Colors.black),
//               title: Text(
//                 'Food Hunger Deaths',
//                 style: TextStyle(color: Colors.black),
//               ),
//               onTap: () {
//                 Navigator.push(context, MaterialPageRoute(builder: (context) => FoodHungerPage()));
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.bloodtype, color: Colors.black),
//               title: Text(
//                 'Blood Loss Deaths',
//                 style: TextStyle(color: Colors.black),
//               ),
//               onTap: () {
//                 Navigator.push(context, MaterialPageRoute(builder: (context) => BloodLossPage()));
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.child_care, color: Colors.black),
//               title: Text(
//                 'Orphans Problems',
//                 style: TextStyle(color: Colors.black),
//               ),
//               onTap: () {
//                 Navigator.push(context, MaterialPageRoute(builder: (context) => OrphansPage()));
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.volunteer_activism, color: Colors.black),
//               title: Text(
//                 'My Orphan Donations',
//                 style: TextStyle(color: Colors.black),
//               ),
//               onTap: () {
//                 Navigator.push(context, MaterialPageRoute(builder: (context) => MyOrphanDonationsPage()));
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.logout, color: Colors.black),
//               title: Text(
//                 'Logout',
//                 style: TextStyle(color: Colors.black),
//               ),
//               onTap: () {
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(builder: (context) => LoginScreen()),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//       backgroundColor: Colors.black,
//       body: Container(
//         padding: const EdgeInsets.all(10),
//         child: Column(
//           children: [
//             TextField(
//               onChanged: updateSearchQuery,
//               style: const TextStyle(color: Colors.black),
//               decoration: InputDecoration(
//                 hintText: 'Search for an orphanage...',
//                 hintStyle: TextStyle(color: Colors.grey[600]),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(20),
//                   borderSide: BorderSide(color: Colors.grey[400]!),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(20),
//                   borderSide: BorderSide(color: Colors.blueGrey[700]!),
//                 ),
//                 filled: true,
//                 fillColor: Colors.grey[200],
//                 prefixIcon: Icon(Icons.search, color: Colors.blueGrey[700]),
//               ),
//             ),
//             const SizedBox(height: 10),
//             Expanded(
//               child: filteredOrphanages.isNotEmpty
//                   ? AnimationLimiter(
//                       child: ListView.builder(
//                         itemCount: filteredOrphanages.length,
//                         itemBuilder: (context, index) {
//                           var orphanage = filteredOrphanages[index];
//                           return AnimationConfiguration.staggeredList(
//                             position: index,
//                             duration: const Duration(milliseconds: 500),
//                             child: SlideAnimation(
//                               verticalOffset: 50.0,
//                               child: FadeInAnimation(
//                                 child: Container(
//                                   margin: const EdgeInsets.symmetric(vertical: 10),
//                                   padding: const EdgeInsets.all(15),
//                                   decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: BorderRadius.circular(15),
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: Colors.grey.withOpacity(0.5),
//                                         blurRadius: 8,
//                                         offset: const Offset(0, 4),
//                                       ),
//                                     ],
//                                   ),
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         orphanage['name'],
//                                         style: const TextStyle(
//                                           color: Colors.black,
//                                           fontSize: 20,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                       const SizedBox(height: 8),
//                                       Text(
//                                         orphanage['description'],
//                                         style: const TextStyle(
//                                           color: Colors.black54,
//                                           fontSize: 14,
//                                         ),
//                                       ),
//                                       const SizedBox(height: 8),
//                                       Text(
//                                         orphanage['childrenDetails'],
//                                         style: const TextStyle(
//                                           color: Colors.black54,
//                                           fontSize: 14,
//                                         ),
//                                       ),
//                                       const SizedBox(height: 8),
//                                       Row(
//                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           ElevatedButton(
//                                             onPressed: () {
//                                               Navigator.push(
//                                                 context,
//                                                 MaterialPageRoute(
//                                                   builder: (context) => OrphanageDetailsPage(
//                                                     name: orphanage['name'],
//                                                     mapLink: orphanage['mapLink'],
//                                                     description: orphanage['description'],
//                                                     contact: orphanage['contact'],
//                                                     childrenDetails: orphanage['childrenDetails'],
//                                                   ),
//                                                 ),
//                                               );
//                                             },
//                                             style: ElevatedButton.styleFrom(
//                                               backgroundColor: Colors.black,
//                                               shape: RoundedRectangleBorder(
//                                                 borderRadius: BorderRadius.circular(10),
//                                               ),
//                                             ),
//                                             child: const Text(
//                                               'View',
//                                               style: TextStyle(
//                                                 color: Colors.white,
//                                                 fontWeight: FontWeight.bold,
//                                               ),
//                                             ),
//                                           ),
//                                           SizedBox(
//                                             width: 140,
//                                             child: ElevatedButton.icon(
//                                               onPressed: () async {
//                                                 final Uri url =
//                                                     Uri.parse(orphanage['mapLink']);
//                                                 if (await canLaunchUrl(url)) {
//                                                   await launchUrl(url);
//                                                 } else {
//                                                   ScaffoldMessenger.of(context).showSnackBar(
//                                                     const SnackBar(
//                                                       content: Text(
//                                                           'Could not launch the map link'),
//                                                     ),
//                                                   );
//                                                 }
//                                               },
//                                               icon: const Icon(
//                                                 Icons.map,
//                                                 color: Colors.white,
//                                               ),
//                                               label: const Text(
//                                                 'View on Map',
//                                                 style: TextStyle(
//                                                   color: Colors.white,
//                                                   fontWeight: FontWeight.bold,
//                                                 ),
//                                               ),
//                                               style: ElevatedButton.styleFrom(
//                                                 backgroundColor: Colors.blue,
//                                                 shape: RoundedRectangleBorder(
//                                                   borderRadius: BorderRadius.circular(10),
//                                                 ),
//                                                 padding: const EdgeInsets.symmetric(
//                                                     vertical: 15.0, horizontal: 10.0),
//                                                 elevation: 5,
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     )
//                   : const Center(
//                       child: Text(
//                         'Currently our services are not available',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 18,
//                         ),
//                       ),
//                     ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'food_hunger_page.dart';

import 'blood_loss_page.dart';
import 'orphan_donations.dart';
import 'orphans_page.dart';
import 'package:nmercy/auth/login_screen.dart';

class OrphanKidPage extends StatefulWidget {
  OrphanKidPage({Key? key}) : super(key: key);

  @override
  _OrphanKidPageState createState() => _OrphanKidPageState();
}

class _OrphanKidPageState extends State<OrphanKidPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Orphanages',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
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
        child: Text(
          'Currently, our services are not available',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
