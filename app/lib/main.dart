import 'dart:html';

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Form Validation Demo';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        body: const MyCustomForm(),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}
/*
fault widget

*/

class faultWidget extends StatefulWidget {
  faultWidget({Key? key, this.checked = false, this.faultName = ""})
      : super(key: key);
  String faultName;
  bool checked;

  @override
  _faultWidgetState createState() => _faultWidgetState();
}

class _faultWidgetState extends State<faultWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: new Row(
      children: [
        Text(this.widget.faultName),
        Switch(
            value: this.widget.checked,
            onChanged: (value) {
              setState(() {
                this.widget.checked = value;
                print("value $this.widget.checked");
              });
            })
      ],
    ));
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  bool passedState = false;
  bool minor1 = false;
  bool minor2 = false;
  bool minor3 = false;

  bool major1 = false;
  bool major2 = false;
  bool major3 = false;

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            decoration: const InputDecoration(labelText: 'First name *'),
          ),
          TextFormField(
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            decoration: const InputDecoration(labelText: 'Last name *'),
          ),
          Container(
            child: new Row(
              children: [
                Text("Passed / Failed (off = failed)"),
                Switch(
                    value: passedState,
                    onChanged: (value) {
                      setState(() {
                        passedState = value;
                      });
                    }),
              ],
            ),
          ),
          ExpansionTile(
            title: Text('Minor faults'),
            children: [
              faultWidget(faultName: "Minor 1", checked: minor1),
              faultWidget(faultName: "Minor 2", checked: minor2),
              faultWidget(faultName: "Minor 3", checked: minor3)
            ],
          ),
          ExpansionTile(
            title: Text('Major faults'),
            children: [
              faultWidget(faultName: "Major 1", checked: major1),
              faultWidget(faultName: "Major 2", checked: major2),
              faultWidget(faultName: "Major3", checked: major3)
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
