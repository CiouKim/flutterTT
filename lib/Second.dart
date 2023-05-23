import 'package:flutter/material.dart';
import 'package:my_app/three.dart';

class Second extends StatelessWidget {
  const Second({super.key, required this.pwd});
  final String pwd;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("提示"),
      ),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Center(
          child: Column(
            children: <Widget>[
              Text('$pwd'),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Three(),
                      ));
                },
                child: Text("go-Three"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
