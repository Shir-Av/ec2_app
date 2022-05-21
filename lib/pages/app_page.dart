import 'dart:convert';

import 'package:ec2_app/models/ec2_data.dart';
import 'package:ec2_app/widgets/ec2_table.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AppPage extends StatefulWidget {
  const AppPage({Key? key}) : super(key: key);

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  var _isLoading = false;
  final _defualtRegion = 'us-east-1';
  late var _chosenRegion = '';

  var msg = 'Hi, Please choose region and click Fetch';
  final List<Ec2Data> ec2List = [];

  Future<void> _getEc2Data() async {
    ec2List.clear();
    const _API_KEY = 'h1uEaSuac07Ctg0V1Dj2I8anDw4pU0G41E1KOJBD';
    const _URL =
        'https://qkh609xt59.execute-api.us-east-1.amazonaws.com/default/getEc2List?region={region}';
    var url = Uri.parse(_URL.replaceAll('{region}', _chosenRegion));
    try {
      setState(() {
        _isLoading = true;
        msg = 'Fetching data...';
      });
      var response = await http.get(
        url,
        headers: {
          'x-api-key': _API_KEY,
        },
      );

      if (response.statusCode == 200) {
        _chosenRegion = '';
        print(response.body);

        setState(() {
          _isLoading = false;
        });

        var ec2Instances = json.decode(response.body);
        for (var value in (ec2Instances as Map<String, dynamic>).values) {
          var ec2 = Ec2Data.fromJson(data: value);
          ec2List.add(ec2);
        }

        if (ec2List.isEmpty) {
          msg = 'No data to display';
        }
      } else {
        print('Error: response statusCode = ${response.statusCode}');
        print('Error: response body = ${response.body}');
        setState(() {
          _isLoading = false;
          msg =
              'response body: ${response.body}, statusCode: ${response.statusCode}';
          _chosenRegion = '';
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _chosenRegion = '';
         msg = e.toString();

      });
      print('e.toString() = ${e.toString()}, e.runtimeType = ${e.runtimeType}');
    }
  }

  @override
  void initState() {
    _chosenRegion = '';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ec2List.isEmpty
                ? Text(
                    msg,
                    style: const TextStyle(
                      fontSize: 40,
                    ),
                  )
                : Ec2Table(ec2list: ec2List),
            const SizedBox(height: 50),
            _isLoading
                ? const CircularProgressIndicator()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 200,
                        child: TextField(
                          decoration: const InputDecoration(
                            hintText: 'Enter region',
                          ),
                          onChanged: (value) {
                            _chosenRegion = value;
                          },
                        ),
                      ),
                      const SizedBox(width: 20),
                      SizedBox(
                        height: 50,
                        width: 200,
                        child: ElevatedButton(
                          onPressed: _getEc2Data,
                          child: const Text(
                            'Fetch',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}