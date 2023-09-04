import 'package:flutter/material.dart';

import '../model/data_model.dart';

class AddUserDialoge extends StatefulWidget {
  // const AddUserDialoge({super.key});
  final Function(DataModel) addDatamodel;

  AddUserDialoge(this.addDatamodel);

  @override
  State<AddUserDialoge> createState() => _AddUserDialogeState();
}

class _AddUserDialogeState extends State<AddUserDialoge> {
  var _qtyController = TextEditingController();
  var _wattController = TextEditingController();
  var _DescriptionController = TextEditingController();
  bool _validateqty = false;
  bool _validatewatt = false;
  bool _validateDescription = false;

  bool isChecked = false;
  String? MeterAmps = '5-20A';
  final MeterAmpsitems = ['5-20A', '10-60 A', '5A LTCT', '100 A', '120 A'];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: const Text(
              'Add Load ',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.teal,
                  fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: [
          //     Checkbox(
          //         checkColor: Colors.white,
          //         fillColor: MaterialStateProperty.resolveWith(getColor),
          //         value: isChecked,
          //         onChanged: (bool? value) {
          //           setState(() {
          //             isChecked = value!;
          //             if (isChecked == true) {
          //               // PartyController.text = "Party Request";
          //             } else {
          //               //  PartyController.text = "";
          //             }
          //           });
          //         }),
          //     Text('Custom Load Details'),
          //   ],
          // ),
          const SizedBox(
            height: 20.0,
          ),
          Container(
            child: Column(
              children: [
                TextField(
                    controller: _DescriptionController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'Description',
                      labelText: 'Description',
                      errorText: _validateDescription
                          ? 'Name Value Can\'t Be Empty'
                          : null,
                    )),
                const SizedBox(
                  height: 20.0,
                ),
                TextField(
                    controller: _qtyController,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'Qty',
                      labelText: 'Qty',
                      errorText:
                          _validateqty ? 'Contact Value Can\'t Be Empty' : null,
                    )),
                const SizedBox(
                  height: 20.0,
                ),
                TextField(
                    controller: _wattController,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'Watts',
                      labelText: 'Watts',
                      errorText: _validatewatt
                          ? 'Description Value Can\'t Be Empty'
                          : null,
                    )),
              ],
            ),

            //Checkbox Control add in future
            // isChecked == false
            //     ? Column(
            //         children: [
            //           TextField(
            //               controller: _DescriptionController,
            //               textInputAction: TextInputAction.next,
            //               decoration: InputDecoration(
            //                 border: const OutlineInputBorder(),
            //                 hintText: 'Description',
            //                 labelText: 'Description',
            //                 errorText: _validateDescription
            //                     ? 'Name Value Can\'t Be Empty'
            //                     : null,
            //               )),
            //           const SizedBox(
            //             height: 20.0,
            //           ),
            //           TextField(
            //               controller: _wattController,
            //               keyboardType: TextInputType.number,
            //               textInputAction: TextInputAction.done,
            //               decoration: InputDecoration(
            //                 border: const OutlineInputBorder(),
            //                 hintText: 'Watts',
            //                 labelText: 'Watts',
            //                 errorText: _validatewatt
            //                     ? 'Description Value Can\'t Be Empty'
            //                     : null,
            //               )),
            //           const SizedBox(
            //             height: 20.0,
            //           ),
            //           TextField(
            //               controller: _qtyController,
            //               keyboardType: TextInputType.number,
            //               textInputAction: TextInputAction.next,
            //               decoration: InputDecoration(
            //                 border: const OutlineInputBorder(),
            //                 hintText: 'Qty',
            //                 labelText: 'Qty',
            //                 errorText: _validateqty
            //                     ? 'Contact Value Can\'t Be Empty'
            //                     : null,
            //               )),
            //         ],
            //       )
            //     : SingleChildScrollView(
            //         child: Padding(
            //           padding: const EdgeInsets.all(8.0),
            //           child: Column(
            //             children: [
            //               const Text('Select Description',
            //                   style: TextStyle(
            //                       fontSize: 15,
            //                       fontWeight: FontWeight.bold,
            //                       color: Colors.green)),
            //               DropdownButtonHideUnderline(
            //                 child: DropdownButton<String>(
            //                     value: MeterAmps,
            //                     iconSize: 36,
            //                     icon: const Icon(Icons.arrow_drop_down,
            //                         color: Colors.black),
            //                     isExpanded: true,
            //                     items:
            //                         MeterAmpsitems.map(buildMenuItem).toList(),
            //                     onChanged: (value) => setState(() {
            //                           MeterAmps = value;
            //                         })),
            //               ),
            //               const SizedBox(
            //                 height: 20.0,
            //               ),
            //               TextField(
            //                   controller: _wattController,
            //                   keyboardType: TextInputType.number,
            //                   textInputAction: TextInputAction.done,
            //                   decoration: InputDecoration(
            //                     border: const OutlineInputBorder(),
            //                     hintText: 'Watts',
            //                     labelText: 'Watts',
            //                     errorText: _validatewatt
            //                         ? 'Description Value Can\'t Be Empty'
            //                         : null,
            //                   )),
            //               const SizedBox(
            //                 height: 20.0,
            //               ),
            //               TextField(
            //                   controller: _qtyController,
            //                   keyboardType: TextInputType.number,
            //                   textInputAction: TextInputAction.next,
            //                   decoration: InputDecoration(
            //                     border: const OutlineInputBorder(),
            //                     hintText: 'Qty',
            //                     labelText: 'Qty',
            //                     errorText: _validateqty
            //                         ? 'Contact Value Can\'t Be Empty'
            //                         : null,
            //                   )),
            //             ],
            //           ),
            //         ),
            //       ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                  style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.teal,
                      textStyle: const TextStyle(fontSize: 15)),
                  onPressed: () {
                    final datamodel = DataModel(
                        _DescriptionController.text,
                        int.parse(_qtyController.text),
                        int.parse(_wattController.text),
                        int.parse(_qtyController.text) *
                            int.parse(_wattController.text));
                    widget.addDatamodel(datamodel);
                    Navigator.pop(context);
                  },
                  child: const Text('Save Details')),
              const SizedBox(
                width: 10.0,
              ),
              TextButton(
                  style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.red,
                      textStyle: const TextStyle(fontSize: 15)),
                  onPressed: () {
                    _DescriptionController.text = '';
                    _qtyController.text = '';
                    _wattController.text = '';
                  },
                  child: const Text('Clear Details'))
            ],
          )
        ],
      ),
    );
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.black;
    }
    return Colors.red;
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(item, style: textStyle),
      );
  final TextStyle textStyle =
      const TextStyle(fontWeight: FontWeight.bold, fontSize: 16);
}
