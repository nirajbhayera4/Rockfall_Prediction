import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

void main() {
  runApp(RockfallDashboard());
}

class RockfallDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rockfall Prediction Dashboard',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: DashboardScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DashboardScreen extends StatelessWidget {
  final List<FlSpot> riskData = [
    FlSpot(0, 1),
    FlSpot(1, 1.5),
    FlSpot(2, 1.8),
    FlSpot(3, 2.2),
    FlSpot(4, 2.5),
    FlSpot(5, 3),
    FlSpot(6, 4),
  ];

  final List<Marker> markers = [
  Marker(
    point: LatLng(20.5937, 78.9629),
    width: 50.0,
    height: 50.0,
    child: Icon(Icons.warning, color: Colors.red, size: 40),
  ),
  Marker(
    point: LatLng(27.9881, 86.9250),
    width: 50.0,
    height: 50.0,
    child: Icon(Icons.warning, color: Colors.orange, size: 40),
  ),
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Rockfall Prediction Dashboard")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("📊 Risk Forecast (Demo Data)",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              SizedBox(
                height: 250,
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(show: true),
                    titlesData: FlTitlesData(show: true),
                    borderData: FlBorderData(show: true),
                    lineBarsData: [
                      LineChartBarData(
                        spots: riskData,
                        isCurved: true,
                        barWidth: 3,
                        color: Colors.red, // updated from colors: []
                        dotData: FlDotData(show: true),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 40),

              Text("🗺️ Vulnerable Mine Zones",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              SizedBox(
                height: 250,
                child: FlutterMap(
                  options: MapOptions(
                    center: LatLng(20.5937, 78.9629),
                    zoom: 3,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: ['a', 'b', 'c'],
                    ),
                    MarkerLayer(markers: markers),
                  ],
                ),
              ),
              SizedBox(height: 40),

              Text("⚠️ Alerts",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Card(
                color: Colors.orange[100],
                child: ListTile(
                  leading: Icon(Icons.warning, color: Colors.red),
                  title: Text("High Rockfall Risk"),
                  subtitle: Text("Immediate inspection required at Sector B"),
                ),
              ),
              Card(
                color: Colors.yellow[100],
                child: ListTile(
                  leading: Icon(Icons.info, color: Colors.orange),
                  title: Text("Moderate Risk"),
                  subtitle: Text("Sector C shows moderate instability"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
