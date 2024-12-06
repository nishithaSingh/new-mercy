import 'package:flutter/material.dart';

class FoodHungerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Food Hunger Deaths',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        color: Colors.black,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Image Section
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset(
                  'assets/hungry.jpg', // Replace with your image asset
                  fit: BoxFit.cover,
                ),
              ),
              // Text Section
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  '''
Estimates of the number of people dying from hunger in India daily vary:

* **2,500,000 per year**: Some reports estimate that 25 lakh Indians die from hunger each year.
* **Over 7,000 per day**: Other reports estimate that more than 7,000 Indians die from hunger daily.
* **4,500 children per day**: According to Drishti IAS, approximately 4,500 children under the age of five die from hunger and malnutrition every day.

These alarming statistics highlight the urgent need to address food insecurity and malnutrition in the country. Hunger not only takes lives but also impacts the future of countless children who are deprived of proper nutrition.

It is crucial to take immediate steps to combat this crisis and provide food to those in need.
                  ''',
                  style: TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
