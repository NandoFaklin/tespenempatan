import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:udctespenempatan/Pages/fitur/detail.dart';
import 'package:udctespenempatan/res/res_maps.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Beranda extends StatefulWidget {
  const Beranda({Key? key}) : super(key: key);

  @override
  State<Beranda> createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  Welcome? welcome;
  TextEditingController searchController = TextEditingController();
  List<Datum> filteredData = [];

  void search(String query) {
    if (query.isEmpty) {
      filteredData = List.from(welcome!.data); // Menyalin seluruh data ke filteredData
    } else {
      filteredData = welcome!.data
          .where((store) =>
          store.nama.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    setState(() {});
  }



  Future<void> fetchAndParseData() async {
    final response = await http.get(Uri.parse('http://192.168.56.1/udc_maps/getMaps.php'));

    if (response.statusCode == 200) {
      welcome = welcomeFromJson(response.body);
      setState(() {}); // Memicu pembaharuan tampilan setelah data diterima
    }
  }


  Future<void> deleteData(String id, int index) async {
    final url = 'http://192.168.56.1/udc_maps/deleteMaps.php';

    try {
      final response = await http.post(
        Uri.parse(url),
        body: {'id': id},
      );

      final responseData = json.decode(response.body);

      if (responseData['value'] == 1) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Berhasil Hapus Data'),
          ),
        );

        setState(() {
          filteredData!.removeAt(index); // Hapus item dari daftar
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal Hapus Data'),
          ),
        );
      }
    } catch (error) {
      print(error);
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchAndParseData();
  }
  Future<void> updateData() async {
    await fetchAndParseData(); // Memanggil fungsi yang memuat data dari server
    setState(() {
      filteredData!.length; // Hapus item dari daftar
    }); // Memicu pembaharuan tampilan
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Column(
        children: [
          SizedBox(height: 30,),
          /*TextField(
            controller: searchController,
            onChanged: (query) {
              search(query);
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(30),
              ),
              labelText: 'Temukan sekolah...',
              prefixIcon: Icon(Icons.search),
            ),
          ),*/

          SizedBox(height: 20,),
          Text("L I S T",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30)),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Container(
                color: Colors.grey.shade200,
                child: welcome != null
                    ? RefreshIndicator(
                  onRefresh: () async {
                    await fetchAndParseData();
                  },
                      child: ListView.builder(
                  itemCount: welcome!.data.length,
                  itemBuilder: (BuildContext context, int index) {
                      Datum store = welcome!.data[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => Detail(store.nama,store.lokasi,store.noHp,store.latKampus,store.longKampus,store.gambarKampus)));
                          },
                          child: Container(
                            height: 180,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,  // Tambahkan baris ini
                                children: [
                                  Image.network('http://192.168.56.1/udc_maps/gambar_kampus/${store.gambarKampus}', width: 120),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${store.nama}",
                                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(height: 10,),
                                          Text(
                                            "No.Hp ${store.noHp}",
                                            style: TextStyle(fontSize: 15),),
                                          Spacer(),
                                          Text(
                                            "${store.lokasi}",
                                            style: TextStyle(fontSize: 13),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                  },
                ),
                    )
                    : Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

