import 'package:flutter/material.dart';

class OrphansPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Orphans Problems',
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
                  'assets/kind.jpg', // Replace with your image asset
                  fit: BoxFit.cover,
                ),
              ),
              // Text Section
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  '''
In India, millions of orphaned children face severe challenges in their daily lives. These issues stem from a lack of basic necessities, including food, education, healthcare, and a stable living environment.

 **Food Challenges**
One of the most pressing issues for orphans is food insecurity. Many orphanages lack adequate funding and resources to provide nutritious meals. This leads to malnutrition, stunted growth, and poor health among children. Malnourished orphans are more prone to illnesses, which further hampers their ability to lead a normal life.

 **Educational Struggles**
Education is a significant challenge for orphaned children. While some orphanages manage to provide basic education, a large number of orphans do not have access to quality schooling. Limited funding means fewer resources, untrained teachers, and a lack of facilities like books, computers, and libraries. As a result, many orphans fail to acquire the skills and knowledge necessary to break the cycle of poverty.

 **Infrastructure Issues**
The infrastructure of orphanages in India is often inadequate. Overcrowding is a common problem, with many children crammed into small spaces. Basic amenities like clean water, proper sanitation, and safe living conditions are frequently missing. The lack of recreational areas and study spaces further affects their mental and physical well-being.

 **Social Stigma**
Orphans also face social stigma and discrimination, making it difficult for them to integrate into society. Many orphans grow up feeling isolated and unsupported, which affects their confidence and ability to form healthy relationships.

 **The Way Forward**
To address these issues, concerted efforts are needed from both government and non-governmental organizations. Increased funding for orphanages, better infrastructure, and access to quality education are essential. Community involvement and awareness campaigns can help reduce stigma and create opportunities for orphans to lead fulfilling lives.

By addressing these challenges, we can provide orphaned children with a better future, ensuring they have the resources and opportunities they need to thrive.
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
