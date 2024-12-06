import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class MyOrphanDonationsPage extends StatefulWidget {
  @override
  _MyOrphanDonationsPageState createState() => _MyOrphanDonationsPageState();
}

class _MyOrphanDonationsPageState extends State<MyOrphanDonationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Orphan Donations',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.red,
      ),
      body: Container(
        color: Colors.black,
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: AnimatedTextKit(
                animatedTexts: [
                  ColorizeAnimatedText(
                    'Mercy Hands',
                    textStyle: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                    colors: [
                      Colors.red,
                      Colors.grey,
                      Colors.white,
                    ],
                  ),
                ],
                isRepeatingAnimation: true,
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                'Your Contributions to Orphanages',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Center(
                child: Text(
                  'Currently, we do not have this service.',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                '"Whoever is generous to the poor lends to the Lord, and he will repay him for his deed." - Proverbs 19:17',
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(
                        'Thank You!',
                        style: TextStyle(color: Colors.red),
                      ),
                      content: Text(
                        'Thank you for spreading kindness and hope to those in need.',
                        style: TextStyle(color: Colors.black),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Close'),
                        ),
                      ],
                    ),
                  );
                },
                icon: Icon(Icons.thumb_up, color: Colors.black),
                label: Text(
                  'Spread Love',
                  style: TextStyle(color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
