import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:joke_app/utilities/appbar/appbar_custom.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helper/helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Helper().loadVault();
  }

  int index = 0;
  int id = 0;
  int length = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 100,
              width: MediaQuery.of(context).size.width,
              color: Colors.green,
              child: const Center(
                child: Text.rich(
                  TextSpan(
                    text: 'A joke day keeps the doctor away \n',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                    children: <InlineSpan>[
                      TextSpan(
                        text:
                            '\nIf you joke wrong way, your teeth have to pay. (Serious)',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                        ),
                      )
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 320,
              child: FutureBuilder(
                future: Helper().loadVault(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (!snapshot.hasData) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          "That's all jokes for today! Come back another day!",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    );
                  }
                  if (snapshot.hasData) {
                    snapshot.data!.isEmpty
                        ? length = 0
                        : length = snapshot.data!.length;

                    if (length != 0) {
                      index = Random().nextInt(length);
                      id = snapshot.data![index]['id'];
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        length > 0
                            ? snapshot.data![index]['joke']
                            : "That's all jokes for today! Come back another day!",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                        textAlign: TextAlign.start,
                      ),
                    );
                  }
                  return const Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      "That's all jokes for today! Come back another day!",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                customButton(Colors.blue, 'This is Funny!', () {
                  length != 0
                      ? setState(() {
                          Helper().saveJoke(jokeId: id);
                        })
                      : null;
                }),
                customButton(Colors.green, 'This is not funny.', () {
                  length != 0
                      ? setState(() {
                          Helper().saveJoke(jokeId: id);
                        })
                      : null;
                }),
              ],
            ),
            Divider(
              color: Colors.grey.withOpacity(0.3),
            ),
            const Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'This app is created as part of Hlsolutions program. The materials contained on this website are provided for general information only and do not constitute any form of device. HLS assumes no responsibility for the accuracy of any particular statement and accepts no liability for any loss or damage which may arise from reliance on the information contained on this site.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                'Copyright 2021 HLS',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget customButton(Color color, String text, Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: color,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
