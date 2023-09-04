import 'package:contactus/contactus.dart';
import 'package:flutter/material.dart';

class Contact extends StatelessWidget {
  const Contact({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blue,
        body: ContactUs(
          logo: AssetImage('images/logo.jpg'),
          email: 'mpsurya001@gmail.com',
          companyName: 'ShanaSoft@inc',
          phoneNumber: '+919994859638',
          dividerThickness: 2,
          // githubUserName: 'SenthilKumran.M.P',
          //  linkedinURL: 'https://www.linkedin.com/in/abhishek-doshi-520983199/',
          tagLine: 'Flutter Developer',
          //  twitterHandle: 'AbhishekDoshi26',
          textColor: Colors.black,
          companyColor: Colors.black,
          taglineColor: Colors.black,
          cardColor: Colors.white,
        ),
        bottomNavigationBar: ContactUsBottomAppBar(
          companyName: 'Er.M.P.Senthil Kumaran,B.E.,',
          textColor: Colors.white,
          backgroundColor: Colors.blue.shade300,
          email: 'adoshi26.ad@gmail.com',
        ),
      ),
    );
  }
}
