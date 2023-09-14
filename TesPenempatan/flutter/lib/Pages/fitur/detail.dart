import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Detail extends StatefulWidget {
  String nama;
  String gambar_kampus;
  String lokasi;
  String no_hp;
  String lat_kampus;
  String long_kampus;
  Detail(this.nama,this.lokasi,this.no_hp,this.lat_kampus,this.long_kampus,this.gambar_kampus);


  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  late GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    LatLng kampusLocation = LatLng(double.parse(widget.lat_kampus), double.parse(widget.long_kampus));

    Set<Marker> markers = {
      Marker(
        markerId: MarkerId('kampus'),
        position: kampusLocation,
        infoWindow: InfoWindow(title: widget.nama),
      ),
    };

    return Scaffold(
      body: Column(
        children: [
          Column(
            children: [
              SizedBox(height: 30,),
              Text(widget.nama),
              SizedBox(height: 10,),
              Text(widget.no_hp),
              SizedBox(height: 10,),
              Image.network('http://192.168.56.1/udc_maps/gambar_kampus/${widget.gambar_kampus}', width: 120),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: kampusLocation,
                  zoom: 17,
                ),
                onMapCreated: (controller) {
                  setState(() {
                    mapController = controller;
                  });
                },
                markers: markers,
              ),
            ),
          ),
        ],
      ),
    );
  }
}