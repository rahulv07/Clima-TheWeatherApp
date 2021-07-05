import 'package:flutter/material.dart';

class WeatherComponent extends StatelessWidget {
  final String icon;
  final int value;
  final String component;
  final String unit;
  WeatherComponent({this.component, this.value, this.icon, this.unit});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF212E50),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      height: 105,
      width: 95,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 8),
            Expanded(
              child: Container(
                child: Image.asset('assets/' + icon),
              ),
            ),
            Expanded(
              child: Text(
                value.round().toString() + unit,
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF95a0b0),
                ),
              ),
            ),
            Expanded(
              child: Text(
                component,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
