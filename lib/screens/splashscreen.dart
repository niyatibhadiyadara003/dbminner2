import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../model/animalmodel.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late List<Animalmodel> fetch;
  late int i;

  Random r1 = Random();

  initState() {
    super.initState();

    jsondata();
    Timer(const Duration(seconds: 6), () {
      Navigator.of(context).pushReplacementNamed('/');
    });
  }

  jsondata() async {
    String data = await rootBundle.loadString("assets/file/animal.json");
    List alldata = jsonDecode(data);
    fetch = alldata.map((e) => Animalmodel.frommap(e)).toList();
    i = r1.nextInt(fetch.length);
    print(fetch[i].image);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Stack(
            children: [
              Container(
                child: Container(
                  alignment: Alignment.bottomCenter,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      //color: Colors.red,
                      image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(fetch[i].image),
                  )),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.black.withOpacity(0.6),
              ),
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        Text(
                          "aplanet",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        const Text(
                          "we love the planet",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )),
                const SizedBox(
                  height: 300,
                ),
                Expanded(
                  flex: 12,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Ready to \nwatch?",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 50,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        fetch[i].description,
                        style: const TextStyle(
                          wordSpacing: 5,
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Start Enjoying",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
