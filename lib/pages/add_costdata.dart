import 'package:flutter/material.dart';

import '../model/cost_data.dart';
import '../services/data_services.dart';

class AddCostData extends StatefulWidget {
  const AddCostData({super.key});

  @override
  State<AddCostData> createState() => _AddCostDataState();
}

class _AddCostDataState extends State<AddCostData> {
  var _descriptionController = TextEditingController();
  var _rateController = TextEditingController();
  var _perController = TextEditingController();

  bool _validatedescription = false;
  bool _validaterate = false;
  bool _validateper = false;
  var _costDataService = UserService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Cost Data as per ERP"),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text(
                'Add Cost Data',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.teal,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Description',
                    labelText: 'Description',
                    errorText: _validatedescription
                        ? 'Description Value Can\'t Be Empty'
                        : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _rateController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Rate',
                    labelText: 'Rate',
                    errorText:
                        _validaterate ? 'Rate Value Can\'t Be Empty' : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _perController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Per',
                    labelText: 'Per',
                    errorText:
                        _validateper ? 'Per Value Can\'t Be Empty' : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  TextButton(
                      style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.teal,
                          textStyle: const TextStyle(fontSize: 15)),
                      onPressed: () async {
                        setState(() {
                          _descriptionController.text.isEmpty
                              ? _validatedescription = true
                              : _validatedescription = false;
                          _rateController.text.isEmpty
                              ? _validaterate = true
                              : _validaterate = false;
                          _perController.text.isEmpty
                              ? _validateper = true
                              : _validateper = false;
                        });
                        if (_validatedescription == false &&
                            _validaterate == false &&
                            _validateper == false) {
                          // print("Good Data Can Save");
                          var _user = User();
                          _user.description = _descriptionController.text;
                          _user.rate = _rateController.text;
                          _user.per = _perController.text;

                          var result = await _costDataService.SaveUser(_user);
                          print(result);
                          Navigator.pop(context, result);
                        }
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
                        _descriptionController.text = '';
                        _rateController.text = '';
                        _perController.text = '';
                      },
                      child: const Text('Clear Details'))
                ],
              ),
            ]),
          ),
        ));
  }
}
