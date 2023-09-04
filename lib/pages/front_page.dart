import 'package:contactus/contactus.dart';
import 'package:flutter/material.dart';

import '../pages/welcome_page.dart';

import 'calculator.dart';
import 'capital_Estimate.dart';
import 'contactus.dart';
import 'conversion.dart';
import 'dcw_estimate.dart';
import 'erp_costdata.dart';
import 'home_page.dart';
import 'tariff_calculator.dart';

class FrontPage extends StatelessWidget {
  List catName = [
    'Load Reduction',
    'Capital Estimate',
    'DCW Estimate',
    'Unit Converter',
    'Tariff Calculator',
    'Calculator',
    'Cost Data'
  ];
  List<Color> catColors = [
    Color(0xFFFFCF2F),
    Color(0xFF6FE08D),
    Color(0xFF61BDFD),
    Color(0xFFCB84FB),
    Color(0xFF78E667),
    Color(0xFFFF1493),
    Color(0xFF800000),
  ];
  List<Icon> catIcon = [
    Icon(
      Icons.trending_down,
      color: Colors.white,
      size: 30,
    ),
    Icon(
      Icons.category,
      color: Colors.white,
      size: 30,
    ),
    Icon(
      Icons.assignment,
      color: Colors.white,
      size: 30,
    ),
    Icon(
      Icons.store,
      color: Colors.white,
      size: 30,
    ),
    Icon(
      Icons.functions,
      color: Colors.white,
      size: 30,
    ),
    Icon(
      Icons.calculate,
      color: Colors.white,
      size: 30,
    ),
    Icon(
      Icons.price_change,
      color: Colors.white,
      size: 30,
    ),
  ];
  List<Widget> pageRoute = [
    HomePage(),
    CapitalEstimate(),
    DCWEstimate(),
    Conversion(),
    TariffClculator(),
    Calculator(),
    ERPcostData(),
  ];

  @override
  Widget build(BuildContext context) {
    double _screenSizeWidth = MediaQuery.of(context).size.width;
    int cnt = _screenSizeWidth >= 600 ? 3 : 2;
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 10),
            decoration: BoxDecoration(
              color: Color(0xFF674AEF),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
            ),
            child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.dashboard,
                        size: 30,
                        color: Colors.white,
                      ),
                      GestureDetector(
                        child: Icon(
                          Icons.notifications,
                          size: 30,
                          color: Colors.white,
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Contact()));
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 3, bottom: 5),
                      child: Text(
                        'Rockfort Section',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                            wordSpacing: 2,
                            color: Colors.white),
                      )),
                  Padding(
                      padding: EdgeInsets.only(left: 3, bottom: 5),
                      child: Text(
                        'Dindigul EDC',
                        style: TextStyle(
                            fontSize: 15,
                            //fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                            wordSpacing: 2,
                            color: Colors.white),
                      )),
                  Container(
                    margin: EdgeInsets.only(top: 5, bottom: 20),
                    width: MediaQuery.of(context).size.width,
                    height: 55,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                        'Coding and Designed by Er.M.P.Senthil Kumaran.B.E.,',
                        style: TextStyle(color: Colors.black.withOpacity(0.7))),
                  ),
                ]),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, right: 15, left: 15),
            child: Column(
              children: [
                GridView.builder(
                  itemCount: catName.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: cnt,
                    childAspectRatio: 1.1,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    mainAxisExtent: 100,
                  ),
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / cnt,
                          child: Column(
                            children: [
                              GestureDetector(
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    color: catColors[index],
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: catIcon[index],
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              pageRoute[index]));
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                child: Center(
                                  child: Align(
                                    child: Text(
                                      catName[index],
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black.withOpacity(0.7)),
                                    ),
                                    alignment: Alignment.center,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
                Divider(thickness: 2, color: Colors.grey.shade300),
              ],
            ),
          )
        ],
      ),
    );
  }
}
