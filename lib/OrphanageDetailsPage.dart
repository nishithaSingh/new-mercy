import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'DonationPage.dart'; // Import the DonationPage

class OrphanageDetailsPage extends StatelessWidget {
  final String name;
  final String mapLink;
  final String description;
  final String contact;
  final String childrenDetails;

  const OrphanageDetailsPage({
    Key? key,
    required this.name,
    required this.mapLink,
    required this.description,
    required this.contact,
    required this.childrenDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          name,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(
          color: Colors.white, // Set the back arrow color to white
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.grey],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[850],
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    const Divider(color: Colors.white, thickness: 0.5),
                    buildSectionTitle('Description:'),
                    buildSectionContent(description),
                    const SizedBox(height: 10),
                    const Divider(color: Colors.white, thickness: 0.5),
                    buildSectionTitle('Contact:'),
                    buildSectionContent(contact),
                    const SizedBox(height: 10),
                    const Divider(color: Colors.white, thickness: 0.5),
                    buildSectionTitle('Children Details:'),
                    buildSectionContent(childrenDetails),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: buildActionButton(
                  icon: Icons.map,
                  label: 'View Map',
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                  onPressed: () async {
                    final Uri url = Uri.parse(mapLink);
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Could not launch $mapLink'),
                        ),
                      );
                    }
                  },
                ),
              ),
              const SizedBox(height: 10),
              Center(
  child: Text(
    'Currently, we won\'t have services for donations',
    style: TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    textAlign: TextAlign.center,
  ),
)

              // Center(
              //   child: buildActionButton(
              //     icon: Icons.volunteer_activism,
              //     label: 'Donate',
              //     backgroundColor: const Color(0xFF28A745),
              //     textColor: Colors.white,
              //     onPressed: () {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(builder: (context) => DonationPage()),
              //       );
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget buildSectionContent(String content) {
    return Text(
      content,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
      textAlign: TextAlign.left,
    );
  }

  Widget buildActionButton({
    required IconData icon,
    required String label,
    required Color backgroundColor,
    required Color textColor,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: textColor),
      label: Text(
        label,
        style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
        elevation: 5,
      ),
    );
  }
}