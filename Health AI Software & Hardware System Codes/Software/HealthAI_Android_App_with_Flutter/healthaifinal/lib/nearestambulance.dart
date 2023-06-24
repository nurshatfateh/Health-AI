import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:url_launcher/url_launcher.dart';

class SOSPage extends StatelessWidget {

  final Map<String, String> ambulanceServices = {
    'mirpur': '+8801712367859',
    'uttara': '+8801778713649',
    'azimpur': '+8801911125156',
    'motijheel': '+8801793162925',
    'shavar': '+8801795695697',
  };
  String locationname = "";

  final String sosMessage =
      'Emergency! Please send an ambulance to my location:';
  final List<String> ambulanceNumbers = ['01729953189'];

  void _sendSOSMessage() async {
    Location location = Location();
    LocationData locationData;
    try {
      locationData = await location.getLocation();
    } catch (e) {
      print('Error getting location: $e');
      return;
    }

    double latitude = locationData.latitude ?? 0.0;
    double longitude = locationData.longitude ?? 0.0;

    double mindistance=99.99;

    if(mindistance > (23.822350-latitude).abs()+(90.365417-longitude).abs()) {
      locationname = "mirpur";
      mindistance =  (23.822350-latitude).abs()+(90.365417-longitude).abs();
    }
    if(mindistance > (23.8667-latitude).abs()+(90.4042-longitude).abs()) {
      locationname = "uttara";
      mindistance =  (23.8667-latitude).abs()+(90.4042-longitude).abs();
    }
    if(mindistance > (23.7298-latitude).abs()+(90.3854-longitude).abs()) {
      locationname = "azimpur";
      mindistance =  (23.7298-latitude).abs()+(90.3854-longitude).abs();
    }
    if(mindistance > (23.73330-latitude).abs()+(90.417458-longitude).abs()) {
      locationname = "motijheel";
      mindistance =  (23.73330-latitude).abs()+(90.417458-longitude).abs();
    }
    if(mindistance > (23.858334-latitude).abs()+(90.266670-longitude).abs()) {
      locationname = "shavar";
      mindistance =  (23.858334-latitude).abs()+(23.858334-longitude).abs();
    }

    String message = '$sosMessage\nLocation: https://maps.google.com/?q=$latitude,$longitude';

    if(locationname == "mirpur") {
      launch('sms:+8801712367859?body=$message');
    }
    if(locationname == "uttara") {
      launch('sms:+8801778713649?body=$message');
    }
    if(locationname == "azimpur") {
      launch('sms:+8801911125156?body=$message');
    }
    if(locationname == "motijheel") {
      launch('sms:+8801793162925?body=$message');
    }
    if(locationname == "shavar") {
      launch('sms:+8801795695697?body=$message');
    }

    for (String number in ambulanceNumbers) {
      await sendSMS(message: message, recipients: [number]);
    }

    print('SOS message sent to ambulance services');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emergency Ambulance'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _sendSOSMessage,
          style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          shape: CircleBorder(),
          padding: EdgeInsets.all(50), // Increase the padding to make the circle bigger
        ),
        child: Text(
          '      Call\n       for\nAmbulance',
          style: TextStyle(
            fontSize: 22, // Increase the font size to fit the text
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        ),
      ),
    );
  }
}
