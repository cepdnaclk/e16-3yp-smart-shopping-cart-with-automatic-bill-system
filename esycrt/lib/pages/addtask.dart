import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';

class addtask extends StatefulWidget {
  @override
  _addtaskState createState() => _addtaskState();
}

class _addtaskState extends State<addtask> {
  @override
  final _formkey = GlobalKey<FormState>();
  String _item = '';
  String _priority;
  DateTime _date = DateTime.now();
  TextEditingController _datecontroller = TextEditingController();
  final DateFormat _dateFormatter = DateFormat('MMM dd ,yyyy');
  final List<String> _prioritylist = ['Low', 'Medium', 'High'];

  _handleDatepicker() async {
    final DateTime date = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (date != null && date != _date) {
      setState(() {
        _date = date;
      });
      _datecontroller.text = _dateFormatter.format(date);
    }
  }

  void initState() {
    super.initState();
    _datecontroller.text = _dateFormatter.format(_date);
  }

  void dispose() {
    _datecontroller.dispose();
    super.dispose();
  }

  _todo() {
    if (_formkey.currentState.validate()) {
      _formkey.currentState.save();
      print('$_item,$_date,$_priority');
    }
    Navigator.pop(context);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 30,
                    color: Colors.deepOrange,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Add Task',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: TextFormField(
                          style: TextStyle(fontSize: 18),
                          decoration: InputDecoration(
                              labelText: 'Item',
                              labelStyle: TextStyle(fontSize: 18),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          validator: (input) => input.trim().isEmpty
                              ? 'please enter the item name'
                              : null,
                          onSaved: (input) => _item = input,
                          initialValue: _item,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: TextFormField(
                          readOnly: true,
                          controller: _datecontroller,
                          style: TextStyle(fontSize: 18),
                          onTap: _handleDatepicker(),
                          decoration: InputDecoration(
                              labelText: 'Date',
                              labelStyle: TextStyle(fontSize: 18),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: DropdownButtonFormField(
                          isDense: true,
                          icon: Icon(Icons.arrow_drop_down_circle),
                          iconSize: 22,
                          iconEnabledColor: Colors.deepOrange,
                          items: _prioritylist.map((String priority) {
                            return DropdownMenuItem(
                              value: priority,
                              child: Text(
                                priority,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
                              ),
                            );
                          }).toList(),
                          style: TextStyle(fontSize: 18),
                          decoration: InputDecoration(
                              labelText: 'Priority',
                              labelStyle: TextStyle(fontSize: 18),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          validator: (input) =>
                              _priority == null ? 'Select the priority' : null,
                          onChanged: (value) {
                            setState(() {
                              _priority = value;
                            });
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 20),
                        height: 60,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.deepOrange,
                            borderRadius: BorderRadius.circular(50)),
                        child: FlatButton(
                          child: Text(
                            'Add',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: _todo(),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
