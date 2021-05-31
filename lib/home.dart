import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _formKey = GlobalKey<FormState>();
  String _url = 'ini teks';
  String _get = '';

  Future<String> getData() async{
    _formKey.currentState.save();
    // print('$_url');
    var response = await http.get(
      Uri.parse('$_url'),
      headers: {
        "Accept": "application/json"
      }
    );
    setState(() {
      _get = response.body;
    });
    // print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('REST API'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: IntrinsicHeight(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText:'URL'),
                  keyboardType: TextInputType.text,
                  onSaved: (input) => _url = input,
                  initialValue: _url,
                ),
                Container(
                  child: Text('$_get'),
                )
              ]
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getData,
      ),
    );
  }
}
