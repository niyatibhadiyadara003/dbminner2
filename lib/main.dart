import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:dbmanner/screens/animaldetailspage.dart';
import 'package:dbmanner/screens/detailspage.dart';
import 'package:dbmanner/screens/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'helpers/dbhelper.dart';
import 'model/animalmodel.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'splashscreen',
    routes: {
      '/': (contex) => const HomePage(),
      'splashscreen': (context) => const SplashScreen(),
      'detailspage': (context) => const DetailsPage(),
      'animaldetailspage': (context) => const AnimalDetailPage(),
    },
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<FormState> insertformkey = GlobalKey();

  TextEditingController idcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController imagecontroller = TextEditingController();
  TextEditingController descreptioncontroller = TextEditingController();

  String id = '';
  String name = '';
  String image = '';
  String descreption = '';

  late Future<List<Mammalmodel>> fetchalldata;

  Random r1 = Random();
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text(
            "Animal Biography",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.black,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () async {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          content: Column(
                            children: [
                              TextButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            content: Form(
                                              key: insertformkey,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  TextFormField(
                                                    decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                      hintText: "id",
                                                    ),
                                                    controller: idcontroller,
                                                    validator: (val) {
                                                      if (val!.isEmpty) {
                                                        return "Enter id first...";
                                                      }
                                                      return null;
                                                    },
                                                    onSaved: (val) {
                                                      setState(() {
                                                        id = val!;
                                                      });
                                                    },
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  TextFormField(
                                                    decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                      hintText: "name",
                                                    ),
                                                    controller: namecontroller,
                                                    validator: (val) {
                                                      if (val!.isEmpty) {
                                                        return "Enter name first...";
                                                      }
                                                      return null;
                                                    },
                                                    onSaved: (val) {
                                                      setState(() {
                                                        name = val!;
                                                      });
                                                    },
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  TextFormField(
                                                    decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                      hintText: "image",
                                                    ),
                                                    controller: imagecontroller,
                                                    validator: (val) {
                                                      if (val!.isEmpty) {
                                                        return "Enter image first...";
                                                      }
                                                      return null;
                                                    },
                                                    onSaved: (val) {
                                                      setState(() {
                                                        image = val!;
                                                      });
                                                    },
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  TextFormField(
                                                    decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                      hintText: "discription",
                                                    ),
                                                    controller:
                                                        descreptioncontroller,
                                                    validator: (val) {
                                                      if (val!.isEmpty) {
                                                        return "Enter discription first...";
                                                      }
                                                      return null;
                                                    },
                                                    onSaved: (val) {
                                                      setState(() {
                                                        descreption = val!;
                                                      });
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                            actions: [
                                              ElevatedButton(
                                                onPressed: () async {
                                                  if (insertformkey
                                                      .currentState!
                                                      .validate()) {
                                                    insertformkey.currentState!
                                                        .save();
                                                    int i = await Dbhelper
                                                        .dbhelper
                                                        .insertdb(
                                                            id: id,
                                                            name: name,
                                                            image: image,
                                                            description:
                                                                descreption);
                                                  }
                                                  setState(() {
                                                    id = "";
                                                    name = "";
                                                    image = "";
                                                    descreption = "";

                                                    idcontroller.clear();
                                                    namecontroller.clear();
                                                    imagecontroller.clear();
                                                    descreptioncontroller
                                                        .clear();
                                                  });
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text("Insert"),
                                              ),
                                              OutlinedButton(
                                                onPressed: () {
                                                  setState(() {
                                                    id = "";
                                                    name = "";
                                                    image = "";
                                                    descreption = "";

                                                    idcontroller.clear();
                                                    namecontroller.clear();
                                                    imagecontroller.clear();
                                                    descreptioncontroller
                                                        .clear();
                                                  });
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text("Cancle"),
                                              ),
                                            ],
                                          ));
                                },
                                child: Text("mammal"),
                              ),
                              TextButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            content: Form(
                                              key: insertformkey,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  TextFormField(
                                                    decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                      hintText: "id",
                                                    ),
                                                    controller: idcontroller,
                                                    validator: (val) {
                                                      if (val!.isEmpty) {
                                                        return "Enter id first...";
                                                      }
                                                      return null;
                                                    },
                                                    onSaved: (val) {
                                                      setState(() {
                                                        id = val!;
                                                      });
                                                    },
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  TextFormField(
                                                    decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                      hintText: "name",
                                                    ),
                                                    controller: namecontroller,
                                                    validator: (val) {
                                                      if (val!.isEmpty) {
                                                        return "Enter name first...";
                                                      }
                                                      return null;
                                                    },
                                                    onSaved: (val) {
                                                      setState(() {
                                                        name = val!;
                                                      });
                                                    },
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  TextFormField(
                                                    decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                      hintText: "image",
                                                    ),
                                                    controller: imagecontroller,
                                                    validator: (val) {
                                                      if (val!.isEmpty) {
                                                        return "Enter image first...";
                                                      }
                                                      return null;
                                                    },
                                                    onSaved: (val) {
                                                      setState(() {
                                                        image = val!;
                                                      });
                                                    },
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  TextFormField(
                                                    decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                      hintText: "discription",
                                                    ),
                                                    controller:
                                                        descreptioncontroller,
                                                    validator: (val) {
                                                      if (val!.isEmpty) {
                                                        return "Enter discription first...";
                                                      }
                                                      return null;
                                                    },
                                                    onSaved: (val) {
                                                      setState(() {
                                                        descreption = val!;
                                                      });
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                            actions: [
                                              ElevatedButton(
                                                onPressed: () async {
                                                  if (insertformkey
                                                      .currentState!
                                                      .validate()) {
                                                    insertformkey.currentState!
                                                        .save();
                                                    int i = await Dbhelper
                                                        .dbhelper
                                                        .insertbirddb(
                                                            id: id,
                                                            name: name,
                                                            image: image,
                                                            description:
                                                                descreption);
                                                  }
                                                  setState(() {
                                                    id = "";
                                                    name = "";
                                                    image = "";
                                                    descreption = "";

                                                    idcontroller.clear();
                                                    namecontroller.clear();
                                                    imagecontroller.clear();
                                                    descreptioncontroller
                                                        .clear();
                                                  });
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text("Insert"),
                                              ),
                                              OutlinedButton(
                                                onPressed: () {
                                                  setState(() {
                                                    id = "";
                                                    name = "";
                                                    image = "";
                                                    descreption = "";

                                                    idcontroller.clear();
                                                    namecontroller.clear();
                                                    imagecontroller.clear();
                                                    descreptioncontroller
                                                        .clear();
                                                  });
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text("Cancle"),
                                              ),
                                            ],
                                          ));
                                },
                                child: Text("Bird"),
                              ),
                              TextButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            content: Form(
                                              key: insertformkey,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  TextFormField(
                                                    decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                      hintText: "id",
                                                    ),
                                                    controller: idcontroller,
                                                    validator: (val) {
                                                      if (val!.isEmpty) {
                                                        return "Enter id first...";
                                                      }
                                                      return null;
                                                    },
                                                    onSaved: (val) {
                                                      setState(() {
                                                        id = val!;
                                                      });
                                                    },
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  TextFormField(
                                                    decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                      hintText: "name",
                                                    ),
                                                    controller: namecontroller,
                                                    validator: (val) {
                                                      if (val!.isEmpty) {
                                                        return "Enter name first...";
                                                      }
                                                      return null;
                                                    },
                                                    onSaved: (val) {
                                                      setState(() {
                                                        name = val!;
                                                      });
                                                    },
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  TextFormField(
                                                    decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                      hintText: "image",
                                                    ),
                                                    controller: imagecontroller,
                                                    validator: (val) {
                                                      if (val!.isEmpty) {
                                                        return "Enter image first...";
                                                      }
                                                      return null;
                                                    },
                                                    onSaved: (val) {
                                                      setState(() {
                                                        image = val!;
                                                      });
                                                    },
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  TextFormField(
                                                    decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                      hintText: "discription",
                                                    ),
                                                    controller:
                                                        descreptioncontroller,
                                                    validator: (val) {
                                                      if (val!.isEmpty) {
                                                        return "Enter discription first...";
                                                      }
                                                      return null;
                                                    },
                                                    onSaved: (val) {
                                                      setState(() {
                                                        descreption = val!;
                                                      });
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                            actions: [
                                              ElevatedButton(
                                                onPressed: () async {
                                                  if (insertformkey
                                                      .currentState!
                                                      .validate()) {
                                                    insertformkey.currentState!
                                                        .save();
                                                    int i = await Dbhelper
                                                        .dbhelper
                                                        .insertfishdb(
                                                            id: id,
                                                            name: name,
                                                            image: image,
                                                            description:
                                                                descreption);
                                                  }
                                                  setState(() {
                                                    id = "";
                                                    name = "";
                                                    image = "";
                                                    descreption = "";

                                                    idcontroller.clear();
                                                    namecontroller.clear();
                                                    imagecontroller.clear();
                                                    descreptioncontroller
                                                        .clear();
                                                  });
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text("Insert"),
                                              ),
                                              OutlinedButton(
                                                onPressed: () {
                                                  setState(() {
                                                    id = "";
                                                    name = "";
                                                    image = "";
                                                    descreption = "";

                                                    idcontroller.clear();
                                                    namecontroller.clear();
                                                    imagecontroller.clear();
                                                    descreptioncontroller
                                                        .clear();
                                                  });
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text("Cancle"),
                                              ),
                                            ],
                                          ));
                                },
                                child: Text("Fish"),
                              ),
                            ],
                          ),
                        ));
              },
              icon: const Icon(Icons.more_vert),
            ),
          ],
        ),
        body: Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  "Choose Category",
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    fetchalldata = Dbhelper.dbhelper.fetch();
                    Navigator.of(context)
                        .pushNamed('detailspage', arguments: fetchalldata);
                  },
                  child: category(
                      image: "assets/images/lion.png",
                      name: "Mammals\nAnimals",
                      thumbnail: "🦁",
                      length: 8),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    fetchalldata = Dbhelper.dbhelper.fetchfish();
                    Navigator.of(context)
                        .pushNamed('detailspage', arguments: fetchalldata);
                  },
                  child: category(
                      image: "assets/images/fishanimal.jpg",
                      name: "Fish\nAnimals",
                      thumbnail: "🐬",
                      length: 8),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    fetchalldata = Dbhelper.dbhelper.fetchbird();
                    Navigator.of(context)
                        .pushNamed('detailspage', arguments: fetchalldata);
                  },
                  child: category(
                      image: "assets/images/birdanimal.jpg",
                      name: "Bird\nAnimals",
                      thumbnail: "🕊",
                      length: 5),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    //fetchalldata = Dbhelper.dbhelper.fetch();
                    Navigator.of(context)
                        .pushNamed('detailspage', arguments: fetchalldata);
                  },
                  child: category(
                      image: "assets/images/snackanimal.jpg",
                      name: "Reptiles\nAnimals",
                      thumbnail: "🐍",
                      length: 9),
                ),
              ],
            ),
          ),
        ));
  }

  Widget category(
      {required String image,
      required String name,
      required String thumbnail,
      required int length}) {
    return Container(
      alignment: Alignment.center,
      height: 150,
      width: 350,
      decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            opacity: 0.6,
            image: AssetImage(image),
            fit: BoxFit.cover,
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 40,
              color: Colors.white,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                thumbnail,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "$length",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  color: Colors.white,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
