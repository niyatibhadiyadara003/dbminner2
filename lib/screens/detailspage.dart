import 'dart:typed_data';

import 'package:dbmanner/helpers/dbhelper.dart';
import 'package:dbmanner/model/animalmodel.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    dynamic args = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Animals"),
      ),
      body: FutureBuilder(
        future: args,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("ERROR : ${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            List<Mammalmodel> fetch = snapshot.data;
            print(fetch.length);
            return ListView.builder(
                itemCount: fetch.length,
                itemBuilder: (context, i) {
                  return InkWell(
                    onTap: () {
                      Mammalmodel a = Mammalmodel(
                          id: fetch[i].id,
                          name: fetch[i].name,
                          image: fetch[i].image,
                          description: fetch[i].description);

                      Navigator.of(context)
                          .pushNamed('animaldetailspage', arguments: a);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 100,
                      height: 200,
                      padding: const EdgeInsets.all(15),
                      margin: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.black,
                          image: DecorationImage(
                            opacity: .6,
                            image: AssetImage(fetch[i].image),
                            fit: BoxFit.contain,
                          )),
                      child: Text(
                        fetch[i].name,
                        style: TextStyle(
                          fontSize: 35,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                });
          } else {
            return const Center(
              child: const CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
