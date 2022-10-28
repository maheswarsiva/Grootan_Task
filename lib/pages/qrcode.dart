import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task/pages/lastlogin.dart';
import 'package:flutter_task/pages/otplogin.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class QrCode extends StatefulWidget {
  const QrCode({super.key});

  @override
  State<QrCode> createState() => _QrCodeState();
}

class _QrCodeState extends State<QrCode> {
  // final Color first = const Color(0xff3E3E3E);
  // final Color second = const Color(0xff121212);

  //  Last<Color> gradient = [first, second];
  @override
  void dispose() {
    super.dispose();
    GeneratedOTP();
  }

  User? user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            child: const Text(
              'Logout',
              style: TextStyle(
                color: Colors.white, fontSize: 22.0, // 2
              ),
            ),
            onPressed: () {
              Navigator.pop(context,
                  MaterialPageRoute(builder: (context) => const OtpLogin()));
            },
          ),
        ),
      ),
      body: Stack(clipBehavior: Clip.none, children: <Widget>[
        Container(
          margin: const EdgeInsets.only(
            top: 50,
          ),
          height: 775,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 25),
              height: 50,
              width: 200,
              decoration: BoxDecoration(
                color: const Color(0xff00A3FF),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'PLUGIN ',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        Container(
            height: 150,
            width: 250,
            margin: const EdgeInsets.only(top: 325, left: 70),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment(1, -1),
                  end: Alignment(-1, 1),
                  stops: [
                    0.5,
                    0.1,
                  ],
                  colors: [
                    Color(0xff2E2B5F),
                    Color(0xff121212)
                  ]),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text('Generated Number'),
                // const SizedBox(
                //   height: 25,
                // ),
                Text(
                  GeneratedOTP().toString(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ],
            )),
        Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                height: 175,
                width: 175,
                margin: const EdgeInsets.only(
                  top: 175,
                ),
                decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(20)),
                child: Stack(
                  children: [
                    Center(
                      child: PrettyQr(
                          size: 150,
                          elementColor: Colors.black,
                          data: GeneratedOTP().toString()),
                    ),
                  ],
                ),
              ),
            ),
            // ignore: avoid_unnecessary_containers
          ],
        ),
        Positioned(
          bottom: 160,
          left: 75,
          child: InkWell(
            child: Container(
              height: 65,
              width: 250,
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.white),
                  borderRadius: BorderRadius.circular(20)),
              child: Center(
                  child: Text(
                      "Last Logged In ${DateFormat('KK:mm').format(DateTime.now())}")),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LastLogin()));
            },
          ),
        ),
        Positioned(
          bottom: 70,
          left: 75,
          child: InkWell(
            child: Container(
              height: 65,
              width: 250,
              decoration: BoxDecoration(
                  color: const Color(0xff3E3E3E),
                  borderRadius: BorderRadius.circular(20)),
              child: const Center(
                  child: Text("SAVE",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18))),
            ),
            onTap: () {
              Map<String, dynamic> data = {"field1": GeneratedOTP()};
              FirebaseFirestore.instance.collection("phone_num").add(data);
              Fluttertoast.showToast(
                  msg: "Saved",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.limeAccent,
                  textColor: Colors.white,
                  fontSize: 18.0);
            },
          ),
        ),
      ]),
    );
  }

  // ignore: non_constant_identifier_names
  int GeneratedOTP() {
    var rand = Random();
    int otp = rand.nextInt(9999) + 10000;

    return otp;
  }
}
