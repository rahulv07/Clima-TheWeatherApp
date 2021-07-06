import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';

class NewCityScreen extends StatefulWidget {
  final Function updateUI;

  NewCityScreen({this.updateUI});
  @override
  _NewCityScreenState createState() => _NewCityScreenState();
}

class _NewCityScreenState extends State<NewCityScreen> {
  String cityName;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF0F1524),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
        decoration: BoxDecoration(
          color: Color(0xFF212E50),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: Column(
          children: [
            Text(
              'Search for a city',
              style: TextStyle(fontSize: 30.0, color: Colors.cyan),
              textAlign: TextAlign.center,
            ),
            TextField(
              autofocus: true,
              cursorColor: Colors.yellowAccent,
              cursorHeight: 30.0,
              decoration: InputDecoration(
                hintText: "Enter here",
                hintStyle: TextStyle(color: Colors.grey),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.yellowAccent,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.yellowAccent,
                  ),
                ),
              ),
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
              onChanged: (enteredName) {
                cityName = enteredName;
              },
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF364677),
              ),
              onPressed: () async {
                if (cityName != null) {
                  var cityData = await WeatherModel().getCityWeather(cityName);
                  widget.updateUI(cityData);
                  Navigator.pop(context);
                } else
                  Navigator.pop(context);
              },
              child: Text(
                'Get Weather',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
