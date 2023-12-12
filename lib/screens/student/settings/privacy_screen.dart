import 'package:flutter/material.dart';
import 'package:schoolapp/screens/widgets/my_appbar.dart';

class ScreenPrivacyPolicyStudent extends StatelessWidget {
  const ScreenPrivacyPolicyStudent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppbar('Privacy Policy'),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Privacy Policy for EDU PLAN Mobile App',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Effective Date: 01-01-2024',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 16.0),

              Text(
                '1. Information We Collect:',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                '1.1 User Data:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'The App collects information provided by users during the registration process. This includes, but is not limited to, names, contact details, and role identification as a teacher or student.',
              ),
              SizedBox(height: 8.0),
              Text(
                '1.2 School Administration Data:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'The App may collect data related to the school administration, such as the name and contact details of the school principal or head of the school.',
              ),
              SizedBox(height: 16.0),

              Text(
                '2. Data Control:',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                '2.1 School Admin Control:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'The collected data is under the control of the school administrator, who is typically the principal or head of the school. The administrator has exclusive access to and control over user data.',
              ),
              SizedBox(height: 8.0),
              Text(
                '2.2 Developer Access:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'The Developer, FlutterVerseOfficial, does not have access to the user data collected by the App. All data is solely controlled and managed by the school administrator.',
              ),
              SizedBox(height: 16.0),
              Text(
                '3. Data Usage:',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                '3.1 Educational Purpose:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'The collected data is used for educational purposes within the school environment. This includes facilitating communication between teachers and students, managing academic activities, and other educational functionalities.',
              ),
              SizedBox(height: 8.0),
              Text(
                '3.2 No Data Sharing:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'The App does not share user data with any external third parties, including the Developer. The data is strictly controlled within the school environment.',
              ),
              SizedBox(height: 16.0),
              Text(
                '4. Data Security:',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                '4.1 Encryption:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'The App employs industry-standard encryption protocols to secure user data during transmission and storage.',
              ),
              SizedBox(height: 8.0),
              Text(
                '4.2 Access Controls:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Access to user data is restricted to the school administrator. The Developer and other third parties do not have access to this data.',
              ),
              SizedBox(height: 16.0),
              Text(
                '5. Contact Information:',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                '5.1 Contacting the Developer:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text( 
                'For any questions or concerns regarding privacy, you can contact FlutterVerseOfficial at flutterverseofficial@gmail.com.', 
              ),
              SizedBox(height: 16.0),

              Text(
                '6. Consent:',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'By using the EDU PLAN App, you consent to the terms outlined in this Privacy Policy.',
              ),
              SizedBox(height: 8.0),
              Text(
                'Please review this Privacy Policy regularly, as it may be updated from time to time.',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
