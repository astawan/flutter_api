import 'dart:convert';

import 'package:chat_app/zodiac.class.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditForm extends StatefulWidget {
  const EditForm({Key? key, required this.data}) : super(key: key);

  final data;

  @override
  _EditFormState createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {
  final _formKey = GlobalKey<FormState>();
  final fotoZodiakController = TextEditingController();
  final namaZodiakController = TextEditingController();
  final tanggalZodiakController = TextEditingController();
  final deskripsiZodiakController = TextEditingController();

  @protected
  @mustCallSuper
  void initState() {
    fotoZodiakController.text = widget.data.photo;
    namaZodiakController.text = widget.data.name;
    tanggalZodiakController.text = widget.data.date;
    deskripsiZodiakController.text = widget.data.description;
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    fotoZodiakController.dispose();
    namaZodiakController.dispose();
    tanggalZodiakController.dispose();
    deskripsiZodiakController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Zodiak"),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: fotoZodiakController,
                decoration: InputDecoration(
                  hintText: "Masukan URL foto zodiak",
                  labelText: "URL Foto Zodiak",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "URL foto zodiak tidak boleh kosong";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 16.0,
              ),
              TextFormField(
                controller: namaZodiakController,
                decoration: InputDecoration(
                  hintText: "Masukkan nama zodiak",
                  labelText: "Nama Zodiak",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Nama zodiak tidak boleh kosong";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 16.0,
              ),
              TextFormField(
                controller: tanggalZodiakController,
                decoration: InputDecoration(
                  hintText: "Masukkan tanggal zodiak",
                  labelText: "Tanggal Zodiak",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Tanggal zodiak tidak boleh kosong";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 16.0,
              ),
              TextFormField(
                controller: deskripsiZodiakController,
                maxLines: 5,
                decoration: InputDecoration(
                  alignLabelWithHint: true,
                  hintText: "Masukan deskripsi zodiak",
                  labelText: "Deskripsi Zodiak",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Deskripsi zodiak tidak boleh kosong";
                  }
                  return null;
                },
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_formKey.currentState?.validate() ?? false) {
            final result = await update();
            Navigator.pop(context, result);
          }
        },
        child: Icon(Icons.save),
      ),
    );
  }

  Future<dynamic> update() async {
    final map = new Map<String, dynamic>();
    map['id'] = widget.data.id.toString();
    map['photo'] = fotoZodiakController.text;
    map['name'] = namaZodiakController.text;
    map['date'] = tanggalZodiakController.text;
    map['description'] = deskripsiZodiakController.text;
    final response = await http.post(
      Uri.parse('http://localhost/zodiac/update.php'),
      body: map,
    );
    if (jsonDecode(response.body)['statusCode'] == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      final Map json = {
        'id': widget.data.id.toString(),
        'photo': fotoZodiakController.text,
        'name': namaZodiakController.text,
        'date': tanggalZodiakController.text,
        'description': deskripsiZodiakController.text,
      };
      final returnData = jsonEncode(json);
      return Zodiac.fromJson(jsonDecode(returnData));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create zodiac.');
    }
  }
}
