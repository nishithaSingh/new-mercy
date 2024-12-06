import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:nmercy/auth/login_screen.dart';
import 'food_hunger_page.dart';
import 'blood_loss_page.dart';
import 'orphan_donations.dart';
import 'orphans_page.dart';
import 'AboutPage.dart';

class DonationApp extends StatefulWidget {
  @override
  _DonationAppState createState() => _DonationAppState();
}

class _DonationAppState extends State<DonationApp> {
  late VideoPlayerController _orphansController;
  late VideoPlayerController _bloodController;
  late VideoPlayerController _foodController;
  bool _isOrphansVideoPlaying = true;
  bool _isBloodVideoPlaying = false;
  bool _isControllerInitialized = false;

  @override
  void initState() {
    super.initState();
    _orphansController = VideoPlayerController.asset('assets/helping.mp4')
      ..initialize().then((_) {
        setState(() {
          _isControllerInitialized = true;
        });
        _orphansController.play();
        _orphansController.setLooping(false);
        _orphansController.addListener(() {
          if (_orphansController.value.position == _orphansController.value.duration) {
            _switchToBloodVideo();
          }
        });
      });

    _bloodController = VideoPlayerController.asset('assets/orphan.mp4')..initialize();
    _foodController = VideoPlayerController.asset('assets/hungry.mp4')..initialize();
  }

  void _switchToBloodVideo() {
    setState(() {
      _isOrphansVideoPlaying = false;
      _isBloodVideoPlaying = true;
    });
    _bloodController.play();
    _bloodController.setLooping(false);
    _bloodController.addListener(() {
      if (_bloodController.value.position == _bloodController.value.duration) {
        _switchToFoodVideo();
      }
    });
  }

  void _switchToFoodVideo() {
    setState(() {
      _isBloodVideoPlaying = false;
    });
    _foodController.play();
    _foodController.setLooping(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft, // Move the title to the left
          child: Text(
            'Mercy Hands',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(Icons.info, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutPage()),
              );
            },
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
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
      body: Stack(
        fit: StackFit.expand,
        children: [
          _isControllerInitialized
              ? (_isOrphansVideoPlaying
                  ? VideoPlayer(_orphansController)
                  : _isBloodVideoPlaying
                      ? VideoPlayer(_bloodController)
                      : VideoPlayer(_foodController))
              : Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _orphansController.dispose();
    _bloodController.dispose();
    _foodController.dispose();
    super.dispose();
  }
}
