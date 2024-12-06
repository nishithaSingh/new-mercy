import 'package:flutter/material.dart';

class BloodLossPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Blood Loss Deaths',
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
                  'assets/blood.jpg', // Replace with your image asset
                  fit: BoxFit.cover,
                ),
              ),
              // Text Section
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  '''
In India, roughly 12,000 people die each day due to a lack of blood. The country faces a shortfall of approximately one million units annually, leading to life-threatening situations.

### Reasons for Blood Shortages:
- **Demand**: Emergencies and natural disasters increase the demand for blood.
- **Donations**: Lower donation rates during holidays and vacations contribute to shortages.
- **Rare Blood Types**: Maintaining a sufficient supply of rare blood types is challenging.
- **Awareness**: Myths and lack of awareness about blood donation discourage many potential donors.

### Who Needs Blood:
- Children with severe anemia.
- Patients with hemoglobin disorders like Thalassemia and sickle cell anemia.
- Accident victims.
- Cancer patients.
- Women in childbirth.

Blood is vital for saving lives, and addressing these challenges can help reduce preventable deaths caused by blood shortages. 
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
