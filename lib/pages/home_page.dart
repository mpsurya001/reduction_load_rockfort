import 'package:flutter/material.dart';
import '../helper_class/helperclass.dart';
import '../pages/user_dialoge.dart';

import '../model/custom_widgets.dart';
import '../model/date_picker.dart';
import '/pages/pdf_page.dart';

import '../model/data_model.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //HomePage({super.key});

  final List<DataModel> data = [];

  final items = ['001', '002', '003', '004', '005', '006'];
  final Tariffitems = ['IA', 'IIA', 'IIB', 'IIIA1', 'IIIB', 'IV', 'V', 'VI'];
  final phaseitems = ['1 Phase', '3 Phase'];
  final MeterAmpsitems = ['5-20A', '10-60 A', '5A LTCT', '100 A', '120 A'];
  final Makeitems = [
    'Avon',
    'BHEL',
    'Bentex',
    'Capital',
    'Conti',
    'ECE',
    'Elster',
    'Genus',
    'Havells',
    'HPL',
    'Holley',
    'Himachal',
    'India',
    'Inesh',
    'L&G',
    'L&T',
    'Linkwell',
    'Omni Agate',
    'RC',
    'REMCO',
    'Secure',
    'UE',
    'VisionTek'
  ];
  final Typeitems = [
    'Static with MD',
    'Static without MD',
    'EM',
    'HQ',
    'Smart Meter'
  ];
  var scnoController = TextEditingController();
  var snameAddressController = TextEditingController();
  var SloadController = TextEditingController();
  var RloadController = TextEditingController();
  var PartyController = TextEditingController();
  var McapController = TextEditingController();
  var RecommendedController = TextEditingController();
  var InsDateController = TextEditingController();
  var RegNoController = TextEditingController();
  var AmountController = TextEditingController();
  var PRController = TextEditingController();
  var SlNoController = TextEditingController();
  var meterAdequateController = TextEditingController();
  var KWHController = TextEditingController();
  var KVAHController = TextEditingController();
  var KWController = TextEditingController();

  int currentStep = 0;
  final TextStyle textStyle =
      const TextStyle(fontWeight: FontWeight.bold, fontSize: 16);
  String? value = "001";
  String? Tariffvalue = "IA";
  String? Phasevalue = "1 Phase";
  String? MeterAmps = '5-20A';
  String? Make = 'Avon';
  String? Type = 'Static with MD';
  String? Distribution = 'Mounspuram';

  DateTime date = DateTime.now();
  DateTime dateofinspection = DateTime.now();
  DateTime regDate = DateTime.now();
  DateTime PRDate = DateTime.now();
  DateTime CRDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    void addUserData(DataModel dataModel) {
      setState(() {
        data.add(dataModel);
      });
    }

    void showUserDialoge() {
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: AddUserDialoge(addUserData),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          );
        },
      );
    }

    List<Step> getSteps() => [
          Step(
            state: currentStep > 0 ? StepState.complete : StepState.indexed,
            isActive: currentStep >= 0,
            title: StepperWrap('Service'),
            content: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.35,

                          // margin: const EdgeInsets.all(16),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border:
                                  Border.all(color: Colors.black, width: 2)),
                          child: Column(
                            children: [
                              const Text('Dist.Code',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green)),
                              // const Divider(thickness: 1),
                              DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                    value: value,
                                    iconSize: 36,
                                    icon: const Icon(Icons.arrow_drop_down,
                                        color: Colors.black),
                                    isExpanded: true,
                                    items: items.map(buildMenuItem).toList(),
                                    onChanged: (value) => setState(() {
                                          this.value = value;
                                          switch (value) {
                                            case '001':
                                              Distribution = 'Mounspuram';
                                              break;
                                            case '002':
                                              Distribution = 'Palani Road';
                                              break;
                                            case '003':
                                              Distribution = 'RV Nagar';
                                              break;
                                            case '004':
                                              Distribution = 'South Car Street';
                                              break;
                                            case '005':
                                              Distribution = 'Muthalagupatty';
                                              break;
                                            case '006':
                                              Distribution = 'Paraipatty';
                                              break;
                                          }
                                        })),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.50,
                          child: TextField(
                              style: textStyle,
                              // maxLengthEnforcement: true,
                              keyboardType: TextInputType.number,
                              maxLength: 4,
                              controller: scnoController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                hintText: 'Enter SC No',
                                labelText: 'SC No',
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
                CustomTextFields(
                  keyboard: 'text',
                  myController: snameAddressController,
                  labelText: 'Name and Address',
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.35,

                          // margin: const EdgeInsets.all(16),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border:
                                  Border.all(color: Colors.black, width: 2)),
                          child: Column(
                            children: [
                              const Text('Tariff',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green)),
                              DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                    value: Tariffvalue,
                                    iconSize: 36,
                                    icon: const Icon(Icons.arrow_drop_down,
                                        color: Colors.black),
                                    isExpanded: true,
                                    items:
                                        Tariffitems.map(buildMenuItem).toList(),
                                    onChanged: (value) => setState(() {
                                          Tariffvalue = value;
                                        })),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // CustomDatePicker(
                    //   Customtitle: 'Date of SC',
                    // ),
                    Expanded(
                      child: Column(
                        children: [
                          const Text('Date of SC',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('${date.day}/${date.month}/${date.year}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                              const SizedBox(
                                width: 10,
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  DateTime? newDate = await showDatePicker(
                                    context: context,
                                    initialDate: date,
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime(2100),
                                    initialEntryMode: DatePickerEntryMode.input,
                                  );

                                  if (newDate == null) return;

                                  setState(() => date = newDate);
                                },
                                child: const Icon(Icons.calendar_today),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFields(
                        keyboard: 'num',
                        myController: SloadController,
                        labelText: 'Sanctioned Load',
                      ),
                    ),
                    Expanded(
                      child: CustomTextFields(
                        keyboard: 'num',
                        myController: RloadController,
                        labelText: 'Required Load',
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
          Step(
            state: currentStep > 1 ? StepState.complete : StepState.indexed,
            isActive: currentStep >= 1,
            title: StepperWrap('Collection'),
            content: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CustomTextFields(
                          keyboard: 'text',
                          labelText: 'Reason ',
                          myController: PartyController,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            const Text('Inspection Date',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                    '${dateofinspection.day}/${dateofinspection.month}/${dateofinspection.year}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                                const SizedBox(
                                  width: 10,
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    DateTime? newDate = await showDatePicker(
                                      context: context,
                                      initialDate: dateofinspection,
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime(2100),
                                      initialEntryMode:
                                          DatePickerEntryMode.input,
                                    );

                                    if (newDate == null) return;

                                    setState(() => dateofinspection = newDate);
                                  },
                                  child: const Icon(Icons.calendar_today),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                CustomTextFields(
                  keyboard: 'text',
                  labelText: 'Recommendation ',
                  myController: RecommendedController,
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFields(
                        keyboard: 'num',
                        labelText: 'Reg.No. ',
                        myController: RegNoController,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          const Text('Registration Date',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                  '${regDate.day}/${regDate.month}/${regDate.year}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                              const SizedBox(
                                width: 10,
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  DateTime? newDate = await showDatePicker(
                                    context: context,
                                    initialDate: regDate,
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime(2100),
                                    initialEntryMode: DatePickerEntryMode.input,
                                  );

                                  if (newDate == null) return;

                                  setState(() => regDate = newDate);
                                },
                                child: const Icon(Icons.calendar_today),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFields(
                        keyboard: 'num',
                        labelText: 'Amount ',
                        myController: AmountController,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          const Text('PR Date',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                  '${PRDate.day}/${PRDate.month}/${PRDate.year}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                              const SizedBox(
                                width: 10,
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  DateTime? newDate = await showDatePicker(
                                    context: context,
                                    initialDate: PRDate,
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime(2100),
                                    initialEntryMode: DatePickerEntryMode.input,
                                  );

                                  if (newDate == null) return;

                                  setState(() => PRDate = newDate);
                                },
                                child: const Icon(Icons.calendar_today),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                CustomTextFields(
                  keyboard: 'text',
                  labelText: 'PR Number ',
                  myController: PRController,
                ),
              ],
            ),
          ),
          Step(
            state: currentStep > 2 ? StepState.complete : StepState.indexed,
            isActive: currentStep >= 2,
            title: StepperWrap('Metering'),
            content: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.35,

                          // margin: const EdgeInsets.all(16),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border:
                                  Border.all(color: Colors.black, width: 2)),
                          child: Column(
                            children: [
                              const Text('Phase',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green)),
                              DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                    value: Phasevalue,
                                    iconSize: 36,
                                    icon: const Icon(Icons.arrow_drop_down,
                                        color: Colors.black),
                                    isExpanded: true,
                                    items:
                                        phaseitems.map(buildMenuItem).toList(),
                                    onChanged: (value) => setState(() {
                                          Phasevalue = value;

                                          Phasevalue == '1 Phase'
                                              ? MeterAmps = '5-20A'
                                              : MeterAmps = '10-60 A';
                                        })),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.35,

                          // margin: const EdgeInsets.all(16),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border:
                                  Border.all(color: Colors.black, width: 2)),
                          child: Column(
                            children: [
                              const Text('Meter Amps',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green)),
                              DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                    value: MeterAmps,
                                    iconSize: 36,
                                    icon: const Icon(Icons.arrow_drop_down,
                                        color: Colors.black),
                                    isExpanded: true,
                                    items: MeterAmpsitems.map(buildMenuItem)
                                        .toList(),
                                    onChanged: (value) => setState(() {
                                          MeterAmps = value;
                                          MeterAmps == '5-20A'
                                              ? Phasevalue = '1 Phase'
                                              : Phasevalue = '3 Phase';
                                        })),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.35,

                          // margin: const EdgeInsets.all(16),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border:
                                  Border.all(color: Colors.black, width: 2)),
                          child: Column(
                            children: [
                              const Text('Make',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green)),
                              DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                    value: Make,
                                    iconSize: 36,
                                    icon: const Icon(Icons.arrow_drop_down,
                                        color: Colors.black),
                                    isExpanded: true,
                                    items:
                                        Makeitems.map(buildMenuItem).toList(),
                                    onChanged: (value) => setState(() {
                                          Make = value;
                                        })),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.35,

                          // margin: const EdgeInsets.all(16),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border:
                                  Border.all(color: Colors.black, width: 2)),
                          child: Column(
                            children: [
                              const Text('Meter Type',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green)),
                              DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                    value: Type,
                                    iconSize: 36,
                                    icon: const Icon(Icons.arrow_drop_down,
                                        color: Colors.black),
                                    isExpanded: true,
                                    items:
                                        Typeitems.map(buildMenuItem).toList(),
                                    onChanged: (value) => setState(() {
                                          Type = value;
                                        })),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  child: Phasevalue == "1 Phase"
                      ? CustomTextFields(
                          myController: meterAdequateController,
                          labelText: 'Meter adequate',
                          keyboard: 'text')
                      : Row(
                          children: [
                            Expanded(
                              child: CustomTextFields(
                                  myController: meterAdequateController,
                                  labelText: 'Meter adequate',
                                  keyboard: 'text'),
                            ),
                            Expanded(
                              child: CustomTextFields(
                                  myController: KVAHController,
                                  labelText: 'KVAH',
                                  keyboard: 'num'),
                            )
                          ],
                        ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFields(
                          myController: SlNoController,
                          labelText: 'Serial No',
                          keyboard: 'text'),
                    ),
                    Expanded(
                      child: CustomTextFields(
                          myController: KWController,
                          labelText: 'MD',
                          keyboard: 'num'),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFields(
                          myController: KWHController,
                          labelText: 'KWH',
                          keyboard: 'num'),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          const Text('Check Reading Date',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                  '${CRDate.day}/${CRDate.month}/${CRDate.year}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                              const SizedBox(
                                width: 10,
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  DateTime? newDate = await showDatePicker(
                                    context: context,
                                    initialDate: CRDate,
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime(2100),
                                    initialEntryMode: DatePickerEntryMode.input,
                                  );

                                  if (newDate == null) return;

                                  setState(() => CRDate = newDate);
                                },
                                child: const Icon(Icons.calendar_today),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Step(
            isActive: currentStep >= 3,
            title: StepperWrap('Load'),
            // const Text('4'),
            content: Column(
              children: [
                const Text('Load Details',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: showUserDialoge,
                      icon: const Icon(Icons.add_box),
                      color: Colors.teal,
                      iconSize: 35,
                    ),
                  ],
                ),
                SingleChildScrollView(
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
                        label: Text('Description'),
                      ),
                      DataColumn(label: Text('Qty')),
                      DataColumn(label: Text('Watt')),
                      DataColumn(label: Text('Total')),
                    ],
                    rows: data.map((item) {
                      return DataRow(
                        color: MaterialStateColor.resolveWith(
                            (Set<MaterialState> states) =>
                                states.contains(MaterialState.selected)
                                    ? Colors.grey
                                    : Colors.white),
                        cells: [
                          DataCell(
                            Text(item.description),
                            onLongPress: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Confirm'),
                                    content:
                                        Text('Are you sure want to delete?'),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            setState(() {
                                              final index = data.indexWhere(
                                                  (element) =>
                                                      element.description ==
                                                      item.description);
                                              data.removeAt(index);
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
                            Text(item.qty.toString()),
                          ),
                          DataCell(
                            Text(item.watt.toString()),
                          ),
                          DataCell(
                            Text(item.total.toString()),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ];
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Load Reduction'), centerTitle: true,
      ),
      body: Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(primary: Colors.red),
        ),
        child: Stepper(
          type: StepperType.horizontal,
          steps: getSteps(),
          currentStep: currentStep,
          onStepContinue: () {
            final isLastStep = currentStep == getSteps().length - 1;
            if (isLastStep) {
            } else {
              setState(() => currentStep += 1);
            }
          },
          onStepTapped: (step) => setState(() => currentStep = step),
          onStepCancel:
              currentStep == 0 ? null : () => setState(() => currentStep -= 1),
          controlsBuilder: (context, ControlsDetails details) {
            final isLastStep = currentStep == getSteps().length - 1;
            return SizedBox(
              //width: MediaQuery.of(context).size.width * 0.60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 45,
                    width: 100,
                    child: ElevatedButton(
                      onPressed: details.onStepCancel,
                      child: Text(currentStep == 0 ? 'Cancel' : 'Back',
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
                      onPressed: isLastStep
                          ? () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PdfPage(
                                            scno:
                                                '207-${value.toString()}-${scnoController.text},${Distribution.toString()}',
                                            data: data,
                                            NameandAddress:
                                                snameAddressController.text,
                                            Date:
                                                'Tariff : ${Tariffvalue.toString()}   Date of SC: ${date.day}-${date.month}-${date.year}',
                                            Sload: SloadController.text,
                                            Rload: RloadController.text,
                                            Mcap: '$Phasevalue, $MeterAmps',
                                            Madequate:
                                                meterAdequateController.text,
                                            Reason: PartyController.text,
                                            inspectionDate:
                                                '${dateofinspection.day}-${dateofinspection.month}-${dateofinspection.year}',
                                            recommendendation:
                                                RecommendedController.text,
                                            RegDetails:
                                                'Application Registration No:${RegNoController.text},Dt:${regDate.day}-${regDate.month}-${regDate.year}',
                                            Applicationdetails:
                                                'Application Registration fees Rs.${AmountController.text} /- collected vide PR No.${PRController.text} Dt. ${PRDate.day}-${PRDate.month}-${PRDate.year}',
                                            Hscno:
                                                '207-$value-${scnoController.text}',
                                            Mdetails:
                                                '$Phasevalue, Cap: $MeterAmps, Type: $Type,\nMake:$Make ,Serial No: ${SlNoController.text}',
                                            Slnorow: Phasevalue == "1 Phase"
                                                ? 'CR:${KWHController.text} KWH, MD: ${KWController.text} KW, Dt:${CRDate.day}-${CRDate.month}-${CRDate.year}'
                                                : 'CR:${KWHController.text} KWH,${KVAHController.text} KVAH, MD: ${KWController.text} KW, Dt:${CRDate.day}-${CRDate.month}-${CRDate.year}',
                                            tf: Tariffvalue.toString(),
                                          )));
                            }
                          : details.onStepContinue,
                      child: Text(isLastStep ? 'Confirm' : 'Next',
                          style: textStyle),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
    // PdfPage(data1: 'Hai');
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(item, style: textStyle),
      );
}
