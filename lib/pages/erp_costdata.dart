import 'package:flutter/material.dart';
import '../model/cost_data.dart';
import '../services/data_services.dart';
import 'add_costdata.dart';

class ERPcostData extends StatefulWidget {
  const ERPcostData({super.key});

  @override
  State<ERPcostData> createState() => _ERPcostDataState();
}

class _ERPcostDataState extends State<ERPcostData> {
  late List<User> _userList = <User>[];

  final _costDataService = UserService();
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

  _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
      ),
    );
  }

  _deleteFormDialog(BuildContext context, userId) {
    return showDialog(
        context: context,
        builder: (param) {
          return AlertDialog(
            title: const Text(
              'Are You Sure to Delete',
              style: TextStyle(color: Colors.teal, fontSize: 20),
            ),
            actions: [
              TextButton(
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red),
                  onPressed: () async {
                    var result = await _costDataService.deleteUser(userId);
                    if (result != null) {
                      Navigator.pop(context);
                      getAllCostDetails();
                      _showSuccessSnackBar('Cost Detail Deleted Success');
                    }
                  },
                  child: const Text('Delete')),
              TextButton(
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.teal),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Close'))
            ],
          );
        });
  }

  @override
  void initState() {
    getAllCostDetails();

    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
              'ERP COST DATA',
            ),
            centerTitle: true),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: DataTable(
            border: TableBorder.all(width: 1, color: Colors.teal),
            headingRowHeight: 30,
            dataRowHeight: 30,
            headingRowColor:
                MaterialStateColor.resolveWith((states) => Colors.teal),
            headingTextStyle: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
            columns: const [
              DataColumn(
                label: Text('Description'),
              ),
              DataColumn(label: Text('Rate')),
              DataColumn(label: Text('Per')),
            ],
            rows: _userList.map((item) {
              return DataRow(
                color: MaterialStateColor.resolveWith(
                    (Set<MaterialState> states) =>
                        states.contains(MaterialState.selected)
                            ? Colors.grey
                            : Colors.white),
                cells: [
                  DataCell(
                    Text(item.description.toString()),
                    onLongPress: () {
                      // showDialog(
                      //   context: context,

                      // builder: (BuildContext context) {
                      //   return AlertDialog(
                      //     title: Text('Confirm'),
                      //     content: Text('Are you sure want to delete?'),
                      //     actions: [
                      //       TextButton(
                      //           onPressed: () {
                      // setState(() {
                      //   final index = _userList.indexWhere(
                      //       (element) =>
                      //           element.description ==
                      //           item.description);
                      //   _userList.removeAt(index);
                      //
                      //
                      // });
                      //             _deleteFormDialog(
                      //                 context, _userList[0].id);
                      //             Navigator.of(context).pop();
                      //           },
                      //           child: Text(
                      //             'Yes',
                      //             style: TextStyle(color: Colors.red),
                      //           )),
                      //       TextButton(
                      //           onPressed: () {
                      //             Navigator.of(context).pop();
                      //           },
                      //           child: Text('No')),
                      //     ],
                      //   );
                      // },
                      // );

                      final index = _userList.indexWhere(
                          (element) => element.description == item.description);

                      _deleteFormDialog(context, _userList[index].id);
                    },
                  ),
                  DataCell(
                    Text(item.rate.toString()),
                  ),
                  DataCell(
                    Text(item.per.toString()),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
        // ListView.builder(
        //     itemCount: _userList.length,
        //     itemBuilder: (context, index) {
        //       return Card(
        //         child: ListTile(
        //           onTap: () {
        //             // Navigator.push(
        //             //     context,
        //             //     MaterialPageRoute(
        //             //         builder: (context) => ViewUser(
        //             //           user: _userList[index],
        //             //         )));
        //           },
        //           leading: const Icon(Icons.person),
        //           title: Text(_userList[index].description ?? ''),
        //           subtitle: Text(_userList[index].rate ?? ''),
        //           trailing: Row(
        //             mainAxisSize: MainAxisSize.min,
        //             children: [
        //               IconButton(
        //                   onPressed: () {
        //                     // Navigator.push(
        //                     //     context,
        //                     //     MaterialPageRoute(
        //                     //         builder: (context) => EditUser(
        //                     //           user: _userList[index],
        //                     //         ))).then((data) {
        //                     //   if (data != null) {
        //                     //     getAllCostDetails();
        //                     //     _showSuccessSnackBar(
        //                     //         'User Detail Updated Success');
        //                     //   }
        //                     // });
        //                     // ;
        //                   },
        //                   icon: const Icon(
        //                     Icons.edit_note,
        //                     color: Colors.teal,
        //                   )),
        //               IconButton(
        //                   onPressed: () {
        //                     _deleteFormDialog(context, _userList[index].id);
        //                   },
        //                   icon: const Icon(
        //                     Icons.delete,
        //                     color: Colors.red,
        //                   ))
        //             ],
        //           ),
        //         ),
        //       );
        //     }),

        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AddCostData())).then((data) {
              if (data != null) {
                getAllCostDetails();
                //  _showSuccessSnackBar('User Detail Added Success');
              }
            });
          },
          child: const Icon(Icons.add),
        ));
  }
}
