import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class Screen extends StatefulWidget {
  const Screen({super.key});

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  double _currentSlideValue = 0;
  List<int> timeduring = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  int? onSelect;

  void speedMotor() async {
    await FirebaseFirestore.instance.collection('EspData').doc('MOTOR').set({
      'speed durring': _currentSlideValue,
      'time durring': onSelect,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hệ thống tưới cây"),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Text('Tốc độ bơm', style: TextStyle(fontSize: 26)),
          Text('${_currentSlideValue.round()}', style: TextStyle(fontSize: 80)),
          Slider(
            value: _currentSlideValue,
            max: 100,
            divisions: 100,
            onChanged: (double value) {
              setState(() {
                _currentSlideValue = value;
              });
            },
          ),
          SizedBox(height: 20),
          Container(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Thời gian tưới cây : ', style: TextStyle(fontSize: 16)),
                DropdownButton2<int>(
                  hint: Text('Chọn'),
                  items:
                      timeduring
                          .map(
                            (int time) => DropdownMenuItem<int>(
                              value: time,
                              child: Text('$time'),
                            ),
                          )
                          .toList(),
                  value: onSelect,
                  onChanged: (int? value) {
                    setState(() {
                      onSelect = value;
                    });
                  },
                  dropdownStyleData: DropdownStyleData(
                    decoration: BoxDecoration(border: Border.all(width: 1)),
                  ),
                ),
                Text('Phút', style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: speedMotor,

            child: Text(
              "Bắt đầu tưới",
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
