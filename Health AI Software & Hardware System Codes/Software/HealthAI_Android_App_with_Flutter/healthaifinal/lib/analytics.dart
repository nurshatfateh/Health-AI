import 'dart:async';
import 'dart:developer';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'navbar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:intl/intl.dart';

int heartRate = 0;
int oxygenLevel = 0;
double temp = 0.0;

String risk1 = "";
String advice = "";

List<SalesData> chartData = [];
final DatabaseReference ref = FirebaseDatabase.instance.ref('SensorData');

class SalesData {
  SalesData(this.heart_rate, this.oxygen_level, this.temperature, this.time);

  final int heart_rate;
  final int oxygen_level;
  final double temperature;
  final String time;
}

void fetchDataFromFirebase() {
  ref.limitToLast(5).onValue.listen((DatabaseEvent event) {
    Map<dynamic, dynamic> values =
    event.snapshot.value as Map<dynamic, dynamic>;
    chartData.clear();
    values.forEach((key, value) {
      dynamic data = value;
      //print(data);
      final int heartRate = int.tryParse(data['heart_rate'].toString()) ?? 0;
      final int oxygenLevel =
          int.tryParse(data['oxygen_level'].toString()) ?? 0;
      final double temp =
          double.tryParse(data['temperature'].toString()) ?? 0.0;
      final String Time = data['time'];
      SalesData obj = SalesData(heartRate, oxygenLevel, temp, Time);
      chartData.add(obj);
    });
  }, onError: (error) {
    print('Error: $error');
  });
}

void fetchDataFirebase() {
  ref.limitToLast(1).onValue.listen((DatabaseEvent event) {
    Map<dynamic, dynamic> values =
    event.snapshot.value as Map<dynamic, dynamic>;
    values.forEach((key, value) {
      dynamic data = value;
      heartRate = int.tryParse(data['heart_rate'].toString()) ?? 0;
      oxygenLevel = int.tryParse(data['oxygen_level'].toString()) ?? 0;
      temp = double.tryParse(data['temperature'].toString()) ?? 0.0;
      riskGenerator();
    });
  }, onError: (error) {
    print('Error: $error');
  });
}

void riskGenerator() {
  if (temp > 101.3 && heartRate > 100) {
    risk1 = "High body temperature and high pulse rate.";
    advice =
    "It could indicate a fever or an infection. It is advisable to seek medical attention.";
  } else if (temp > 101.3 && oxygenLevel < 90) {
    risk1 = "High body temperature and low oxygen level.";
    advice =
    " It may suggest an infection or another underlying health issue. It is recommended to consult a healthcare professional.";
  } else if (temp < 95.0 && heartRate < 60) {
    risk1 = "Low body temperature and low pulse rate.";
    advice =
    "It may be a sign of hypothermia or a circulation problem. Immediate medical attention is recommended.";
  } else if (heartRate > 100 && oxygenLevel < 90) {
    risk1 = "High pulse rate and low oxygen level.";
    advice =
    "It could indicate an issue with the heart or lungs, leading to inadequate oxygen supply. It is advisable to seek medical attention.";
  } else if (temp > 101.3) {
    risk1 = "High body temperature,";
    advice =
    "It may indicate a fever or an infection. It is recommended to monitor your symptoms and consult a healthcare professional if necessary.";
  } else if (temp < 95.0) {
    risk1 = "Low body temperature.";
    advice =
    "It could be a sign of hypothermia or circulation issues. It is recommended to take measures to warm up and seek medical attention if symptoms persist.";
  } else if (heartRate > 100) {
    risk1 = "High pulse rate.";
    advice =
    " It may indicate an increased heart rate, which could be due to various factors like physical exertion, anxiety, or an underlying medical condition. Monitoring the situation and consulting a healthcare professional is advised.";
  } else if (heartRate < 60) {
    risk1 = "Low pulse rate.";
    advice =
    "It may indicate a slower heart rate, which could be a result of several factors, including certain medications or an underlying heart condition. It is recommended to consult a healthcare professional for further evaluation.";
  } else if (oxygenLevel < 90) {
    risk1 = "Low oxygen level.";
    advice =
    "It suggests inadequate oxygenation, which could be due to respiratory problems or other health conditions. It is advised to seek medical attention for proper evaluation and treatment.";
  } else {
    risk1 = "Normal health parameters";
    advice =
    "Your temperature, pulse rate, and oxygen level appear to be within the normal range. However, if you have any concerns or symptoms, it is always a good idea to consult a healthcare professional.";
  }
}


void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: analyticsFirstRoute(),
    ),
  );
}

class analyticsFirstRoute extends StatelessWidget {
  const analyticsFirstRoute({super.key});


  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      backgroundColor: Color(0xFF5FB2FF),
      appBar: AppBar(
        backgroundColor: Color(0xFF5FB2FF),
        title: Text(
          "      Health AI  ",
          style: TextStyle(
              fontSize: 35.0, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xFFB0F1FF),
                      borderRadius: BorderRadius.circular(30)),
                  margin: EdgeInsets.only(bottom: 0, left: 5, right: 5, top: 0),
                  height: 450,
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 100.0,
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        elevation: 5,
                        color: Colors.white,
                        margin: EdgeInsets.all(15.0),
                        child: new InkWell(
                          onTap: () => showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('❓Do you have the hardware?\n'
                                  '🔔If you have please do the following steps before using the hardware.\n'
                                  '➡ Create a mobile hotspot named "HealthAI"\n'
                                  '➡ Make the password "12345678"\n'
                                  '➡ If the light 🚨 of the hardware starts blinking means it detecting heartbeat.\n'
                                  '➡ Wait at least 45 second\n'
                                  '➡ After successful measurement the ligth 🚨 will stop blinking and it will turn red 🔴.\n'
                                  '➡ Press the reset button of the hardware to measure again.'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Cancel'),
                                  child: const Text('No'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const hardware()),
                                  ),
                                  child: const Text('Yes'),
                                ),
                              ],
                            ),
                          ),
                          //padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 5.0),
                          child: Center(
                            child: ListTile(
                              title: Text(
                                "Measure Health Parameters",
                                style: TextStyle(
                                  fontSize: 21.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              contentPadding: EdgeInsets.all(15.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        elevation: 5,
                        color: Colors.white,
                        margin: EdgeInsets.all(15.0),
                        child: new InkWell(
                          onTap: () => showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text(
                                  'Do you want to see detailed analytics?'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Cancel'),
                                  child: const Text('No'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                        const analyticsSecondRoute()),
                                  ),
                                  child: const Text('Yes'),
                                ),
                              ],
                            ),
                          ),
                          //padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 5.0),
                          child: Center(
                            child: ListTile(
                              title: Text(
                                "Detail Analytics",
                                style: TextStyle(
                                  fontSize: 21.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              contentPadding: EdgeInsets.all(15.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
      drawer: Navbar(),
    );
  }
}

class analyticsSecondRoute extends StatelessWidget {
  const analyticsSecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    fetchDataFromFirebase();
    fetchDataFirebase();
   // print("List ${chartData.length}");
    // chartData = [
    //SalesData(50,90, 80.00,"2023-06-05T12:21:29Z"),
    //SalesData(DateTime.parse('2012-07-20 20:18:04Z'), 60),
    //   SalesData(DateTime.parse('2014-07-20 20:18:04Z'), 85),
    //   SalesData(DateTime.parse('2016-07-20 20:18:04Z'), 50),
    //   SalesData(DateTime.parse('2018-07-20 20:18:04Z'), 90)
    // ];

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      backgroundColor: Color(0xFF5FB2FF),
      appBar: AppBar(
        backgroundColor: Color(0xFF5FB2FF),
        title: Text(
          "      Health AI  ",
          style: TextStyle(
              fontSize: 35.0, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
          padding:
          const EdgeInsets.only(left: 10, top: 50, right: 10, bottom: 30),
          child: Column(
            children: [
              Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xFFB0F1FF),
                      borderRadius: BorderRadius.circular(30)),
                  margin:
                  EdgeInsets.only(bottom: 30, left: 0, right: 0, top: 0),
                  height: 600,
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 15.0,
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),

                        color: Colors.white,
                        elevation: 5,
                        margin: EdgeInsets.all(15.0),
                        //padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 5.0),
                        child: new InkWell(
                          onTap: () {},
                          child: Center(
                            child: ListTile(
                              leading: Icon(
                                Icons.check_circle_outline,
                                size: 30.0,
                                color: Colors.green,
                              ),
                              title: Text(
                                "Current parameters \n 🤒 Temperature: $temp °F 🟥 \n 🫀 Heart rate: $heartRate BPM 🟩 \n 🫁Oxygen level: $oxygenLevel % 🟦",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              contentPadding: EdgeInsets.all(5.0),
                              trailing: Icon(
                                Icons.check_circle_outline,
                                size: 30.0,
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        elevation: 5,
                        color: Colors.white,
                        margin: EdgeInsets.all(15.0),
                        //padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 6.0),
                        child: Center(
                          child: ListTile(
                            title: Center(
                                child: Container(
                                    child: SfCartesianChart(
                                        primaryXAxis: CategoryAxis(isInversed: true,
                                        arrangeByIndex: false,
                                        zoomFactor: 1.0,
                                        placeLabelsNearAxisLine: true,
                                       ),
                                        enableAxisAnimation: true,
                                        zoomPanBehavior: ZoomPanBehavior(enablePanning: true,
                                            enableSelectionZooming: true,
                                            enableMouseWheelZooming: true,
                                        enablePinching: true),

                                        series: <ChartSeries>[
                                          StackedLineSeries<SalesData, String>(
                                            groupName: 'Group A',
                                            dataLabelSettings: const DataLabelSettings(
                                                isVisible: true,
                                                useSeriesColor: true,
                                                color: Colors.red),
                                            dataSource: chartData,
                                            xValueMapper: (SalesData data, _) =>
                                                DateFormat.yMd().add_jm().format(
                                                    DateTime.parse(
                                                        data.time.toString())),
                                            yValueMapper: (SalesData data, _) =>
                                                data.temperature.toInt(),
                                            color: Colors.red,
                                          ),
                                          StackedLineSeries<SalesData, String>(
                                              groupName: 'Group B',
                                              dataLabelSettings:
                                              const DataLabelSettings(
                                                  isVisible: true,
                                                  useSeriesColor: true,
                                                  color: Colors.green),
                                              dataSource: chartData,
                                              xValueMapper: (SalesData data, _) =>
                                                  DateFormat.yMd().add_jm().format(
                                                      DateTime.parse(
                                                          data.time.toString())),
                                              yValueMapper: (SalesData data, _) =>
                                                  data.heart_rate.toInt(),
                                              color: Colors.green),
                                          StackedLineSeries<SalesData, String>(
                                              groupName: 'Group C',
                                              dataLabelSettings:
                                              const DataLabelSettings(
                                                  isVisible: true,
                                                  useSeriesColor: true,
                                                  color: Colors.blueAccent),
                                              dataSource: chartData,
                                              xValueMapper: (SalesData data, _) =>
                                                  DateFormat.yMd().add_jm().format(
                                                      DateTime.parse(
                                                          data.time.toString())),
                                              yValueMapper: (SalesData data, _) =>
                                                  data.oxygen_level.toInt(),
                                              color: Colors.blueAccent),
                                        ]))),
                            contentPadding: EdgeInsets.all(15.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 13),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          elevation: 8.0,
                          padding: EdgeInsets.all(10.0),
                          textStyle: const TextStyle(
                              color: Colors.blue,
                              fontSize: 15,
                              fontStyle: FontStyle.normal),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const risk()),
                          );
                        },
                        child: const Text(
                          'Detailed Health Analysis \n based on current parameters',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,

                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
      drawer: Navbar(),
    );
  }
}

class risk extends StatelessWidget {
  const risk({super.key});

  @override
  Widget build(BuildContext context) {

    fetchDataFromFirebase();
    fetchDataFirebase();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      backgroundColor: Color(0xFF5FB2FF),
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
          child: Center(
            child: Text(
              'Health AI',
              style: TextStyle(
                fontFamily: 'InknutAntiqua',
                fontSize: 32.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xFFB0F1FF),
                      borderRadius: BorderRadius.circular(30)),
                  margin: EdgeInsets.only(bottom: 0, left: 5, right: 5, top: 0),
                  height: 620,
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 15.0,
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),

                        color: Colors.white,
                        elevation: 5,
                        margin: EdgeInsets.all(12.0),
//padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 5.0),
                        child: new InkWell(
                          onTap: () {},
                          child: Center(
                            child: ListTile(
                              leading: Icon(
                                Icons.medical_information_outlined,
                                size: 50.0,
                                color: Colors.redAccent,
                              ),
                              title: Text(
                                "${risk1}",
                                style: TextStyle(
                                  fontSize: 21.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              trailing: Icon(
                                Icons.medical_information_outlined,
                                size: 50.0,
                                color: Colors.redAccent,
                              ),
                              contentPadding: EdgeInsets.all(15.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        elevation: 5,
                        color: Colors.white,
                        margin: EdgeInsets.all(15.0),
//padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 6.0),
                        child: Center(
                          child: ListTile(
                            leading: Icon(
                              Icons.medication_liquid_sharp,
                              size: 50.0,
                              color: Colors.redAccent,
                            ),
                            title: Center(
                              child: Text(
                                "${advice}",
                                style: TextStyle(
                                    fontSize: 21.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            contentPadding: EdgeInsets.all(15.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
      drawer: Navbar(),
    );
  }
}

class hardware extends StatefulWidget {
  const hardware({super.key});

  @override
  State<hardware> createState() => _hardwareState();
}

class _hardwareState extends State<hardware> {
  final auth = FirebaseAuth.instance;

  final ref = FirebaseDatabase.instance.ref('SensorData');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
          child: Center(
            child: Text(
              'Health Parameter',
              style: TextStyle(
                fontFamily: 'InknutAntiqua',
                fontSize: 32.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: FirebaseAnimatedList(
                  query: ref.limitToLast(1),
                  itemBuilder: (context, snapshot, animation, index) {
                    double temp = double.tryParse(
                        snapshot.child('temperature').value.toString()) ??
                        0.0;
                    double heart = double.tryParse(
                        snapshot.child('heart_rate').value.toString()) ??
                        0;
                    double oxy = double.tryParse(
                        snapshot.child('oxygen_level').value.toString()) ??
                        0;
                    double elasped_time = double.tryParse(
                        snapshot.child('elasped_time').value.toString()) ??
                        0.0;
                    int progress = int.tryParse(
                        snapshot.child('progress').value.toString()) ??
                        0;
                    int connected = int.tryParse(
                        snapshot.child('connected').value.toString()) ??
                        0;

                    double time_value = 0;
                    bool is_Visible = true;
                    bool is_Connected = true;
                    bool is_Progress = true;

                    if (connected == 0)
                      is_Connected = false;
                    else
                      is_Connected = true;

                    if (progress == 0)
                      is_Progress = false;
                    else
                      is_Progress = true;

                    double opacity = 0.0;

                    if (is_Progress ^ is_Connected) opacity = 1.00;
                    if (is_Connected && !is_Progress) opacity = 0.15;

                    if (is_Progress ^ is_Connected)
                      is_Visible = true;
                    else if (is_Progress) is_Visible = false;

                    if (!is_Connected)
                      time_value = 0;
                    else
                      time_value = elasped_time;

                    return Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Visibility(
                          maintainSize: false,
                          maintainAnimation: true,
                          maintainState: true,
                          visible: is_Visible,
                          child: SleekCircularSlider(
                              appearance: CircularSliderAppearance(
                                  customWidths:
                                  CustomSliderWidths(progressBarWidth: 10),
                                  size: 150,
                                  infoProperties: InfoProperties(
                                      bottomLabelStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                      bottomLabelText: 'Progress',
                                      mainLabelStyle: TextStyle(
                                          color: Colors.green,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w600),
                                      modifier: (double value) {
                                        if (connected == 0) {
                                          return 'Not Connected';
                                        } else {
                                          return '${snapshot.child('elasped_time').value.toString()} Second';
                                        }
                                      })),
                              min: 0,
                              max: 45,
                              initialValue: time_value),
                        ),
                        Visibility(
                            maintainSize: false,
                            maintainAnimation: true,
                            maintainState: true,
                            visible: !is_Connected,
                            child: ListTile(
                              title: Text(
                                'Health Parameters of '
                                    '${DateFormat.yMEd().add_jm().format(DateTime.parse(snapshot.child('time').value.toString()))}',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            )),
                        Opacity(
                          opacity: opacity,
                          child: Column(
                            children: [
                              SleekCircularSlider(
                                appearance: CircularSliderAppearance(
                                    customWidths: CustomSliderWidths(
                                        trackWidth: 4,
                                        progressBarWidth: 10,
                                        shadowWidth: 40),
                                    customColors: CustomSliderColors(
                                        trackColor: Colors.deepOrange,
                                        progressBarColor: Colors.orangeAccent,
                                        shadowColor: Colors.orange,
                                        shadowMaxOpacity: 0.5,
                                        //);
                                        shadowStep: 20),
                                    infoProperties: InfoProperties(
                                        bottomLabelStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                        bottomLabelText: 'Temperature',
                                        mainLabelStyle: TextStyle(
                                            color: Colors.green,
                                            fontSize: 25.0,
                                            fontWeight: FontWeight.w600),
                                        modifier: (double value) {
                                          return '${snapshot.child('temperature').value.toString()} ˚F';
                                        }),
                                    startAngle: 90,
                                    angleRange: 360,
                                    size: 150.0,
                                    animationEnabled: true),
                                min: 49,
                                max: 115,
                                initialValue: temp,
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              SleekCircularSlider(
                                appearance: CircularSliderAppearance(
                                    customWidths: CustomSliderWidths(
                                        trackWidth: 4,
                                        progressBarWidth: 10,
                                        shadowWidth: 40),
                                    customColors: CustomSliderColors(
                                        trackColor: Colors.green,
                                        progressBarColor: Colors.lightGreen,
                                        shadowColor: Colors.greenAccent,
                                        shadowMaxOpacity: 0.5,
                                        //);
                                        shadowStep: 20),
                                    infoProperties: InfoProperties(
                                        bottomLabelStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                        bottomLabelText: 'Heart Rate',
                                        mainLabelStyle: TextStyle(
                                            color: Colors.red,
                                            fontSize: 25.0,
                                            fontWeight: FontWeight.w600),
                                        modifier: (double value) {
                                          return '${snapshot.child('heart_rate').value.toString()} BPM';
                                        }),
                                    startAngle: 90,
                                    angleRange: 360,
                                    size: 150.0,
                                    animationEnabled: true),
                                min: 0,
                                max: 500,
                                initialValue: heart,
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              SleekCircularSlider(
                                appearance: CircularSliderAppearance(
                                    customWidths: CustomSliderWidths(
                                        trackWidth: 4,
                                        progressBarWidth: 10,
                                        shadowWidth: 40),
                                    customColors: CustomSliderColors(
                                        trackColor: Colors.deepPurple,
                                        progressBarColor: Colors.indigoAccent,
                                        shadowColor: Colors.blue,
                                        shadowMaxOpacity: 0.5,
                                        //);
                                        shadowStep: 20),
                                    infoProperties: InfoProperties(
                                        bottomLabelStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                        bottomLabelText: 'Oxygen Level',
                                        mainLabelStyle: TextStyle(
                                            color: Colors.blueAccent,
                                            fontSize: 25.0,
                                            fontWeight: FontWeight.w600),
                                        modifier: (double value) {
                                          return '${snapshot.child('oxygen_level').value.toString()} %';
                                        }),
                                    startAngle: 90,
                                    angleRange: 360,
                                    size: 150.0,
                                    animationEnabled: true),
                                min: 0,
                                max: 110,
                                initialValue: oxy,
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
