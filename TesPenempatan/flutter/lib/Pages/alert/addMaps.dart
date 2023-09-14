import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:udctespenempatan/Pages/MainPages.dart';
import 'dart:io';

import 'package:udctespenempatan/Pages/fitur/beranda.dart';

class AddMaps extends StatefulWidget {
  const AddMaps({Key? key}) : super(key: key);

  @override
  State<AddMaps> createState() => _AddMapsState();
}

class _AddMapsState extends State<AddMaps> {
  File? gambar_kampus;

  final TextEditingController namaController = TextEditingController();
  final TextEditingController lokasiController = TextEditingController();
  final TextEditingController no_hpController = TextEditingController();
  final TextEditingController lat_kampusController = TextEditingController();
  final TextEditingController long_kampusController = TextEditingController();

  Future<void> _getImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        gambar_kampus = File(pickedImage.path);
      });
    }
  }

  Future<void> _upload(BuildContext context) async {
    var url = Uri.parse('http://192.168.56.1/udc_maps/postMaps.php');
    var request = http.MultipartRequest('POST', url);

    // Menambahkan data teks ke permintaan
    request.fields['nama'] = namaController.text;
    request.fields['lokasi'] = lokasiController.text;
    request.fields['no_hp'] = no_hpController.text;
    request.fields['lat_kampus'] = lat_kampusController.text;
    request.fields['long_kampus'] = long_kampusController.text;


    // Menambahkan gambar ke permintaan multipart
    if (gambar_kampus != null) {
      request.files.add(http.MultipartFile(
        'gambar_kampus',
        gambar_kampus!.readAsBytes().asStream(),
        gambar_kampus!.lengthSync(),
        filename: gambar_kampus!.path.split('/').last,
      ));
    }

    var response = await request.send();
    if (response.statusCode == 200) {
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);

      var data = jsonDecode(responseString);
      if (data['value'] == 1) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Upload Successful'),
              content: Text('The data sekolah has been uploaded successfully.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                    Navigator.pushReplacement(context,MaterialPageRoute(builder: (_) => MainPage()));// Tutup dialog dan kirim true
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
      else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Upload Failed'),
              content: Text('Failed to upload data sekolah. Please try again.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Tutup dialog
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to connect to server.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Tutup dialog
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text("Input Data Sekolah",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(labelText: 'nama'),
                controller: namaController,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'lokasi'),
                controller: lokasiController,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'No Hp'),
                controller: no_hpController,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'lat_kampus'),
                controller: lat_kampusController,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'long_kampus'),
                controller: long_kampusController,
              ),
              SizedBox(height: 16.0),
              InkWell(
                onTap: _getImage,
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.image, color: Colors.white),
                      SizedBox(width: 8.0),
                      Text('Pick Image', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ),
              gambar_kampus == null
                  ? Text('No image selected')
                  : Image.file(gambar_kampus!, height: 100),
              ElevatedButton(
                onPressed: () {
                  // Cek apakah ada kolom yang kosong
                  if (namaController.text.isEmpty ||
                      lokasiController.text.isEmpty ||
                      no_hpController.text.isEmpty ||
                      lat_kampusController.text.isEmpty ||
                      long_kampusController.text.isEmpty ||
                      gambar_kampus == null) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Masih ada data yang kosong'),
                          content: Text('Tolong di isi semua field dan gambar juga '),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context); // Tutup dialog
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                    return;
                  }
                  _upload(context); // Panggil fungsi upload jika semua kolom terisi
                },
                child: Text('Upload'),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
