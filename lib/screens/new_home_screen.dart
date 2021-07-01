import 'package:flutter/material.dart';

class NewHome extends StatefulWidget {
  final weatherInfo;
  NewHome({this.weatherInfo});

  @override
  _NewHomeState createState() => _NewHomeState();
}

class _NewHomeState extends State<NewHome> {
  @override
  void initState() {
    print(widget.weatherInfo);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Color(0xFF32426f), Color(0xFF141c32)],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [Container()],
        ),
      ),
    );
  }
}
