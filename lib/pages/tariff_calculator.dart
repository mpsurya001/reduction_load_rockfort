import 'package:flutter/material.dart';

import '../model/tariff_rate.dart';

class TariffClculator extends StatefulWidget {
  const TariffClculator({super.key});

  @override
  State<TariffClculator> createState() => _TariffClculatorState();
}

class _TariffClculatorState extends State<TariffClculator> {
  double unitsConsumed = 0;
  double totalBillAmount = 0;
  final List<TariffSlab> tariffSlabs = [
    TariffSlab(units: 100, rate: 4.50),
    TariffSlab(units: 400, rate: 6.00),
    TariffSlab(units: 500, rate: 6.00),
    TariffSlab(units: 600, rate: 6.00),
    TariffSlab(units: 800, rate: 9.00),
    TariffSlab(units: 1000, rate: 10.00),
    TariffSlab(units: double.infinity, rate: 11.00), // For units above 500
  ];

  double calculateBill(double units) {
    double totalBill = 0;
    double remainingUnits = units;

    for (final slab in tariffSlabs) {
      if (remainingUnits <= 0) {
        break; // No more units to calculate
      }

      final unitsInSlab =
          (remainingUnits > slab.units) ? slab.units : remainingUnits;
      totalBill += unitsInSlab * slab.rate;
      remainingUnits -= unitsInSlab;
    }

    return totalBill;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TANGEDCO Bill Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Units Consumed',
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  unitsConsumed = double.tryParse(value) ?? 0;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  totalBillAmount = calculateBill(unitsConsumed);
                });
              },
              child: Text('Calculate'),
            ),
            SizedBox(height: 20),
            Text(
              'Total Bill Amount: \u20B9 $totalBillAmount',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  // double calculateBill(double units) {
  //   // Implement your TANGEDCO bill calculation logic here.
  //   // You'll need to replace this with the actual calculation logic.
  //   // For simplicity, we are using a placeholder calculation.
  //   return units * 5; // Replace with your formula.
  // }
}
