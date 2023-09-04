import 'package:flutter/material.dart';

import '../helper_class/helperclass.dart';
import '../model/capital_class.dart';

class DCWEstimate extends StatefulWidget {
  const DCWEstimate({super.key});

  @override
  State<DCWEstimate> createState() => _DCWEstimateState();
}

class _DCWEstimateState extends State<DCWEstimate> {
  @override
  int dcwCurrentStep = 0;
  final List<DCWDataModel> dcwdata = [];
  final TextStyle textStyle =
      const TextStyle(fontWeight: FontWeight.bold, fontSize: 16);
  List<Step> getDCWsteps() => [
        Step(
            state: dcwCurrentStep > 0 ? StepState.complete : StepState.indexed,
            isActive: dcwCurrentStep >= 0,
            title: StepperWrap('Credit'),
            content: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                border: TableBorder.all(width: 1, color: Colors.teal),
                headingRowHeight: 30,
                dataRowHeight: 30,
                headingRowColor:
                    MaterialStateColor.resolveWith((states) => Colors.teal),
                headingTextStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13),
                columns: const [
                  DataColumn(
                    label: Text('Qty'),
                  ),
                  DataColumn(label: Text('Description')),
                  DataColumn(label: Text('Rate')),
                  DataColumn(label: Text('Per')),
                  DataColumn(label: Text('Total')),
                ],
                rows: dcwdata.map((item) {
                  return DataRow(
                    color: MaterialStateColor.resolveWith(
                        (Set<MaterialState> states) =>
                            states.contains(MaterialState.selected)
                                ? Colors.grey
                                : Colors.white),
                    cells: [
                      DataCell(
                        Text(item.qty.toString()),
                      ),
                      DataCell(
                        Text(item.description),
                        onLongPress: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Confirm'),
                                content: Text('Are you sure want to delete?'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        setState(() {
                                          final index = dcwdata.indexWhere(
                                              (element) =>
                                                  element.description ==
                                                  item.description);
                                          dcwdata.removeAt(index);
                                        });
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        'Yes',
                                        style: TextStyle(color: Colors.red),
                                      )),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('No')),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      DataCell(
                        Text(item.rate.toString()),
                      ),
                      DataCell(
                        Text(item.per.toString()),
                      ),
                      DataCell(
                        Text(item.total.toString()),
                      ),
                    ],
                  );
                }).toList(),
              ),
            )),
        Step(
            state: dcwCurrentStep > 1 ? StepState.complete : StepState.indexed,
            isActive: dcwCurrentStep >= 1,
            title: StepperWrap('Estimate'),
            content: Container()),
        Step(
            state: dcwCurrentStep > 2 ? StepState.complete : StepState.indexed,
            isActive: dcwCurrentStep >= 2,
            title: StepperWrap('Details'),
            content: Container()),
        Step(
            state: dcwCurrentStep > 3 ? StepState.complete : StepState.indexed,
            isActive: dcwCurrentStep >= 3,
            title: StepperWrap('Details'),
            content: Container()),
      ];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        backgroundColor: Color.fromRGBO(51, 51, 255, 60),
        title: Text('DCW Estimate'),
        centerTitle: true,
      ),
      body: Stepper(
        type: StepperType.horizontal,
        steps: getDCWsteps(),
        currentStep: dcwCurrentStep,
        onStepTapped: (step) => setState(() => dcwCurrentStep = step),
        onStepContinue: () {
          final isLastStep = dcwCurrentStep == getDCWsteps().length - 1;
          if (isLastStep) {
          } else {
            setState(() => dcwCurrentStep += 1);
          }
        },
        onStepCancel: () {
          dcwCurrentStep == 0 ? null : setState(() => dcwCurrentStep -= 1);
        },
        controlsBuilder: (context, ControlsDetails details) {
          final isLastStep = dcwCurrentStep == getDCWsteps().length - 1;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              //width: MediaQuery.of(context).size.width * 0.60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 45,
                    width: 100,
                    child: ElevatedButton(
                      onPressed: details.onStepCancel,
                      child: Text(dcwCurrentStep == 0 ? 'Cancel' : 'Back',
                          style: textStyle),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    height: 45,
                    width: 100,
                    child: ElevatedButton(
                      onPressed: isLastStep ? () {} : details.onStepContinue,
                      child: Text(isLastStep ? 'Confirm' : 'Next',
                          style: textStyle),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
