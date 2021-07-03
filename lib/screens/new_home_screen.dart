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
  String weatherText;
  int condition;
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
        condition = 0;
        cityName = '';
        countryCode = '';
        wind = 0;
        humidity = 0;
        pressure = 0;
      } else {
        temperature = double.parse(weatherData['main']['temp'].toString());
        condition = weatherData['weather'][0]['id'].toInt();
        cityName = weatherData['name'].toString();
        countryCode = weatherData['sys']['country'].toString();
        wind = weatherData['wind']['speed'].toInt();
        humidity = weatherData['main']['humidity'].toInt();
        pressure = weatherData['main']['pressure'].toInt();
      }
    });
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
              child: Icon(Icons.cloud, size: 200),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      WeatherComponent(
                          component: 'Wind', value: wind, icon: Icons.air),
                      WeatherComponent(
                          component: 'Humidity',
                          value: humidity,
                          icon: Icons.water),
                      WeatherComponent(
                          component: 'Pressure',
                          value: pressure,
                          icon: Icons.lock_clock),
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

class WeatherComponent extends StatelessWidget {
  final IconData icon;
  final int value;
  final String component;
  WeatherComponent({this.component, this.value, this.icon});

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
      height: 110,
      width: 95,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 30),
          Text(
            value.round().toString(),
            style: TextStyle(
              fontSize: 20,
              color: Color(0xFF95a0b0),
            ),
          ),
          Text(
            component,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class BezierCurve extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0.0, size.height);
    path.lineTo(0.0, size.height / 5);

    var firstControlPoint = new Offset(size.width / 4, size.height / 8);
    var firstEndPoint = new Offset(size.width / 2, size.height / 4);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint = new Offset(size.width * 3 / 4, size.height / 3);
    var secondEndPoint = new Offset(size.width, size.height / 5);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, 0.0);
    path.lineTo(size.width, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
