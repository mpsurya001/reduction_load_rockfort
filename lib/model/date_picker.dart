import 'package:flutter/material.dart';

class CustomDatePicker extends StatefulWidget {
  // CustomDatePicker({super.key});
  String Customtitle;
//const ServerIpText ({ Key? key, this.serverIP }): super(key: key);
  CustomDatePicker({Key? key, required this.Customtitle}) : super(key: key);

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  DateTime date = DateTime(2022, 12, 24);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(widget.Customtitle,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.green)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('${date.day}/${date.month}/${date.year}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16)),
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
    );
  }
}
