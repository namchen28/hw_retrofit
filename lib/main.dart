import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hw_retrofit/bio.dart';
import 'package:hw_retrofit/log.dart';
import 'package:hw_retrofit/test.dart';
import 'package:logger/logger.dart';

final logger = Logger();
void main() {
  printLog();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  Future<Bio> fetchBioData() async {
    final bio = Dio();

    bio.options.headers = {
      'X-RapidAPI-Key': 'a05f098654msh774b1fe074234ccp18d309jsncc8e7acb55db',
      'X-RapidAPI-Host': 'imdb8.p.rapidapi.com'
    };
    bio.options.baseUrl = 'https://imdb8.p.rapidapi.com';
    final client = RestClient(bio);
    var result = await client.getBio('nm0001667');
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bio Data'),
      ),
      body: Center(
        child: FutureBuilder<Bio>(
          future: fetchBioData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData) {
              return const Text('No data available');
            } else {
              final bio = snapshot.data;

              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.all(4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Name: ${bio?.name ?? 'N/A'}'),
                        Text(
                            'Birth Date: ${bio?.birthDate?.toString() ?? 'N/A'}'),
                        Text(
                            'Nicknames: ${bio?.nicknames?.join(', ') ?? 'N/A'}'),
                        Text('Real Name: ${bio?.realName ?? 'N/A'}'),
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
