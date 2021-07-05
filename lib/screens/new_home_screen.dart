import 'package:clima/utilities/beziercurve.dart';
import 'package:clima/utilities/weather_component.dart';
import 'package:flutter/material.dart';

class NewHome extends StatefulWidget {
  final weatherInfo;
  NewHome({this.weatherInfo});

  @override
  _NewHomeState createState() => _NewHomeState();
}

class _NewHomeState extends State<NewHome> {
  double temperature;
  int deg = 0x00B0;
  String cityName, countryCode;
  String weatherIcon;
  String condition;
  String weatherText;
  int pressure, humidity, wind;

  @override
  void initState() {
    super.initState();
    updateUI(weatherData: widget.weatherInfo);
  }

  void updateUI({dynamic weatherData}) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        condition = '';
        cityName = '';
        countryCode = '';
        wind = 0;
        humidity = 0;
        pressure = 0;
      } else {
        temperature = double.parse(weatherData['main']['temp'].toString());
        condition = weatherData['weather'][0]['icon'].toString();
        cityName = weatherData['name'].toString();
        countryCode = weatherData['sys']['country'].toString();
        wind = weatherData['wind']['speed'].toInt();
        humidity = weatherData['main']['humidity'].toInt();
        pressure = weatherData['main']['pressure'].toInt();
        weatherIcon = updateWeatherIcon(condition);
      }
    });
  }

  String updateWeatherIcon(String condition) {
    String output;

    if (condition == '01d')
      output = 'sun.png';
    else if (condition == '01n')
      output = 'night.png';
    else if (condition == '02d')
      output = 'cloudy-day.png';
    else if (condition == '02n')
      output = 'cloudy-night.png';
    else if (condition == '03d' ||
        condition == '03n' ||
        condition == '04d' ||
        condition == '04n')
      output = 'cloud.png';
    else if (condition == '09d' ||
        condition == '09n' ||
        condition == '10d' ||
        condition == '10n')
      output = 'cloud+rain.png';
    else if (condition == '11d' || condition == '11n')
      output = 'storm.png';
    else if (condition == '13d' || condition == '13n')
      output = 'snowing.png';
    else if (condition == '50d' || condition == '50n') output = 'mist.png';

    return output;
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

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
          children: [
            Container(
              height: screenHeight * 0.2,
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).padding.top * 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$cityName, $countryCode',
                    style: TextStyle(
                      fontSize: 30,
                      color: Color(0xFF95a0b0),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).padding.top / 3),
                  Text(
                    '$temperature' + String.fromCharCode(deg) + 'C',
                    style: TextStyle(fontSize: 50),
                  ),
                ],
              ),
            ),
            Container(
              height: screenHeight * 0.32,
              child: Image.asset('assets/' + weatherIcon),
            ),
            Expanded(
              child: ClipPath(
                clipper: BezierCurve(),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF2e3761), Color(0xFF3c5185)],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                    ),
                  ),
                  height: screenHeight * 0.38,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          WeatherComponent(
                            component: 'Wind',
                            value: wind,
                            icon: 'wind.png',
                            unit: ' kmph',
                          ),
                          WeatherComponent(
                            component: 'Humidity',
                            value: humidity,
                            icon: 'humidity.png',
                            unit: '%',
                          ),
                          WeatherComponent(
                            component: 'Pressure',
                            value: pressure ~/ 10,
                            icon: 'pressure.png',
                            unit: ' kPa',
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 50, bottom: 50),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                onPressed: () {},
                                child: Icon(Icons.location_on)),
                            ElevatedButton(
                              onPressed: () {},
                              child: Icon(Icons.search),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
