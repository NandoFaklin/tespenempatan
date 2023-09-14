import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class mapsPage extends StatefulWidget {
  const mapsPage({Key? key}) : super(key: key);

  @override
  State<mapsPage> createState() => _mapsPageState();
}

class _mapsPageState extends State<mapsPage> {
  late GoogleMapController mapController;
  List<LatLng> coordinates = [];
  List<Map<String, dynamic>> campusData = [];

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.56.1/udc_maps/getMaps.php'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        if (responseData['is_success']) {
          final List<dynamic> data = responseData['data'];

          for (var item in data) {
            double lat = double.parse(item['lat_kampus']);
            double lng = double.parse(item['long_kampus']);
            coordinates.add(LatLng(lat, lng));
            campusData.add(item);
          }
        } else {
          print('Failed to fetch data from API: ${responseData['message']}');
        }
      } else {
        print('Failed to load data from API. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  void _onMarkerTapped(Map<String, dynamic> campusInfo) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Detail Kampus'),
          content: Text('Nama: ${campusInfo['nama']}\nLokasi: ${campusInfo['lokasi']}'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Semua Kampus'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(-0.94924, 100.35427),
          zoom: 17,
        ),
        onMapCreated: (controller) {
          setState(() {
            mapController = controller;
          });
        },
        markers: Set<Marker>.from(coordinates.asMap().entries.map((entry) {
          LatLng position = entry.value;
          Map<String, dynamic> campusInfo = campusData[entry.key];

          return Marker(
            markerId: MarkerId(position.toString()),
            position: position,
            infoWindow: InfoWindow(
              title: '${campusInfo['nama']}',
              snippet: '${campusInfo['lokasi']}',
            ),
            onTap: () {
              _onMarkerTapped(campusInfo);
            },
          );
        })),
      ),
    );
  }
}
