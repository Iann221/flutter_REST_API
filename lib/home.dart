import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _formKey = GlobalKey<FormState>();
  String _url = '';
  String _get = '';
  String _token = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3YTVhNDMxNTdmZDY3OGMwMGQzY2RjNzFhYmI4ZDEyMyIsInN1YiI6IjYwYTczZDFjYzJiY2M2MDA2YzFiMjdjYSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.GNxJniMpZ2nfRblGbNkbsaVw8X6XeXsl-Th_ubFb6wI';

  Future<String> getData() async{
    _formKey.currentState.save();
    // print('$_url');
    var response = await http.get(
      Uri.parse('$_url'),
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${_token}",
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
                  decoration: InputDecoration(
                    labelText:'URL',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.text,
                  onSaved: (input) => _url = input,
                  initialValue: _url,
                ),
                ElevatedButton(
                  child: Text('Get'),
                  onPressed: getData,
                ),
                Container(
                  child: Text('$_get'),
                ),
              ]
            ),
          ),
        ),
      ),
    );
  }
}
