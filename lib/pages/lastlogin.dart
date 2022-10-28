import 'package:flutter/material.dart';
import 'package:flutter_task/pages/otplogin.dart';
import 'package:flutter_task/pages/qrcode.dart';

class LastLogin extends StatefulWidget {
  const LastLogin({Key? key}) : super(key: key);

  @override
  State<LastLogin> createState() => _LastLoginState();
}

class _LastLoginState extends State<LastLogin> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const QrCode()));
              },
              icon: const Icon(Icons.arrow_back_ios_new)),
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
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 50,
                ),
                height: 775,
                width: double.infinity,
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
                      'LAST LOGIN ',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Container(
                width: 330,
                margin: const EdgeInsets.only(
                  top: 100,
                ),
                child: Column(
                  children: const [
                    TabBar(padding: EdgeInsets.all(8.0), tabs: [
                      Tab(
                        text: 'Today',
                      ),
                      Tab(
                        text: 'Yesterday',
                      ),
                      Tab(
                        text: 'Other',
                      ),
                    ]),
                  ],
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
                  onTap: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
