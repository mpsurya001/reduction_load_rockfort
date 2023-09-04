import 'package:flutter/material.dart';

import '../model/capital_class.dart';
import '../model/cost_data.dart';
import '../services/data_services.dart';

class CapitalEstimate extends StatefulWidget {
  const CapitalEstimate({super.key});

  @override
  State<CapitalEstimate> createState() => _CapitalEstimateState();
}

class _CapitalEstimateState extends State<CapitalEstimate> {
  late List<User> _userList = <User>[];
  final _costDataService = UserService();
  final List<CapitalDataModel> capitadata = [];

  getAllCostDetails() async {
    var costData = await _costDataService.readAllUsers();
    _userList = <User>[];
    costData.forEach((cost) {
      setState(() {
        var costDataModel = User();
        costDataModel.id = cost['id'];
        costDataModel.description = cost['description'];
        costDataModel.rate = cost['rate'];
        costDataModel.per = cost['per'];

        _userList.add(costDataModel);
      });
    });
  }

  var _qtyController = TextEditingController();
  var ErpDescription;
  var _itemper, _itemrate;
  final TextStyle textStyle =
      const TextStyle(fontWeight: FontWeight.bold, fontSize: 16);

  @override
  void initState() {
    getAllCostDetails();

    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF674AEF),
          title: Text('Capital Estimate'),
          centerTitle: true,
        ),
        body: Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: Colors.red),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.yellow),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          padding: EdgeInsets.all(16.0),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              value: _userList.length < 1
                                  ? _userList[0].description
                                  : ErpDescription,
                              iconSize: 36,
                              icon: const Icon(Icons.arrow_drop_down,
                                  color: Colors.black),
                              isExpanded: true,
                              onChanged: (val) {
                                setState(() {
                                  ErpDescription = val.toString();
                                });
                              },
                              items: _userList.map((item) {
                                return DropdownMenuItem(
                                  value: item.description.toString(),
                                  child: Text(
                                    item.description.toString(),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            style: TextStyle(fontSize: 20),
                            controller: _qtyController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: 'Qty',
                              // border: OutlineInputBorder(
                              //     borderRadius: BorderRadius.circular(10),
                              //     borderSide: BorderSide(
                              //         width: 2.0, color: Colors.yellow))
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  final index = _userList.indexWhere(
                                      (element) =>
                                          element.description ==
                                          ErpDescription);
                                  _itemrate = _userList[index].rate.toString();
                                  _itemper = _userList[index].per.toString();
                                  capitadata.add(CapitalDataModel(
                                      ErpDescription,
                                      int.parse(_qtyController.text),
                                      int.parse(_itemrate),
                                      _itemper,
                                      int.parse(_qtyController.text) *
                                          int.parse(_itemrate)));
                                });
                                _qtyController.text = '';
                              },
                              child: Icon(
                                Icons.add_task,
                                weight: 24,
                              )),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      border: TableBorder.all(width: 1, color: Colors.teal),
                      headingRowHeight: 30,
                      dataRowHeight: 30,
                      headingRowColor: MaterialStateColor.resolveWith(
                          (states) => Colors.teal),
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
                      rows: capitadata.map((item) {
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
                                      content:
                                          Text('Are you sure want to delete?'),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              setState(() {
                                                final index = capitadata
                                                    .indexWhere((element) =>
                                                        element.description ==
                                                        item.description);
                                                capitadata.removeAt(index);
                                              });
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              'Yes',
                                              style:
                                                  TextStyle(color: Colors.red),
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
                  ),
                  buildTotal(capitadata, capitadata.length.toString()),
                ],
              ),
            ),
          ),
        ));
  }

  buildTotal(data, cnt) {
    // final netTotal = data.tableitems
    //     .map((item) => item.watt * item.qty)
    //     .reduce((item1, item2) => item1 + item2);
    //
    // final total = netTotal;

    final dataTotal = cnt == '0'
        ? 0
        : data
            .map((item) => item.total)
            .reduce((item1, item2) => item1 + item2);

    final contigenciey = (dataTotal.toDouble() * 1 / 100);
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Spacer(flex: 2),
              Expanded(
                flex: 8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(),
                    buildText(
                      title: 'Cost of Materials',
                      value: NumUtils.formatCell(dataTotal.toDouble()),
                      unite: true,
                    ),
                    // SizedBox(height: 2),
                    // Container(height: 1, color: Colors.grey.shade400),
                    // SizedBox(height: 0.5), //* PdfPageFormat.mm
                    // Container(height: 1, color: Colors.grey.shade400),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Spacer(flex: 2),
              Expanded(
                flex: 8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(),
                    buildText(
                      title: 'Contigencies 1 %',
                      value: NumUtils.formatCell((contigenciey)),
                      unite: true,
                    ),
                    // SizedBox(height: 2),
                    // Container(height: 1, color: Colors.grey.shade400),
                    // SizedBox(height: 0.5), //* PdfPageFormat.mm
                    // Container(height: 1, color: Colors.grey.shade400),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  buildText({
    required String title,
    required String value,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
  }) {
    final mystyle = TextStyle(fontWeight: FontWeight.bold);

    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(
            child: Text(title, style: unite ? null : mystyle),
          ),
          Text(value, style: mystyle),
        ],
      ),
    );
  }
}

class NumUtils {
  static formatPrice(double price) => '\$ ${price.toStringAsFixed(2)}';
  static formatCell(double load) => 'Rs. ${load.toStringAsFixed(0)} /-';
}
