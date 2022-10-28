// ignore_for_file: deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:flutter_task/pages/qrcode.dart';

class OtpLogin extends StatefulWidget {
  const OtpLogin({Key? key}) : super(key: key);

  @override
  State<OtpLogin> createState() => _OtpLoginState();
}

class _OtpLoginState extends State<OtpLogin> {
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  String verificationID = "";
  User? user;
  // ignore: prefer_typing_uninitialized_variables
  var signupDate;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   title: const Text('QR Code'),
        // ),
        body: SingleChildScrollView(
          child: Stack(children: [
            Container(
              margin: const EdgeInsets.only(top: 100),
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
                  margin: const EdgeInsets.only(top: 75),
                  height: 50,
                  width: 200,
                  decoration: BoxDecoration(
                    color: const Color(0xff00A3FF),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'LOGIN ',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 200,
              left: 30,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(top: 60),
                      height: 390,
                      width: 320,
                      decoration: BoxDecoration(
                        //color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const PhoneNumTextWidget(),
                          const SizedBoxWidget(),
                          TextFormField(
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color(0xff2E2B5F),
                              prefixText: '+91',
                              hintText: 'Phone Number',
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            controller: _mobileController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please Enter Mobile Number";
                              }
                              if (value.contains('@')) {
                                return "Invalid Mobile Number";
                              }
                              return null;
                            },
                            maxLength: 10,
                          ),
                          const SizedBoxWidget(),
                          Container(
                            height: 50,
                            width: 280,
                            margin: const EdgeInsets.only(left: 20),
                            decoration: BoxDecoration(
                                color: const Color(0xff3E3E3E),
                                borderRadius: BorderRadius.circular(20)),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary:
                                    const Color(0xff3E3E3E), // Background color
                              ),
                              onPressed: () async {
                                _auth.verifyPhoneNumber(
                                  phoneNumber: "+91${_mobileController.text}",
                                  verificationCompleted:
                                      (PhoneAuthCredential credential) async {
                                    await _auth
                                        .signInWithCredential(credential)
                                        .then((value) =>
                                            {print("OTP sent Successfully")});
                                  },
                                  verificationFailed:
                                      (FirebaseAuthException exception) {
                                    print(
                                        "exception.toString() ${exception.toString()}");
                                  },
                                  codeSent: (String verificationId,
                                      int? resendToken) {
                                    setState(() {
                                      verificationID = verificationId;
                                    });

                                    resendToken;
                                    _auth;
                                  },
                                  codeAutoRetrievalTimeout:
                                      (String verificationID) {},
                                  timeout: const Duration(seconds: 120),
                                );
                              },
                              child: const Text(
                                'Verify',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          const OtpTextWidget(),
                          const SizedBoxWidget(),
                          TextFormField(
                            controller: _otpController,
                            keyboardType: TextInputType.number,
                            //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            decoration: InputDecoration(
                              hintText: 'Enter the OTP',
                              filled: true,
                              fillColor: const Color(0xff2E2B5F),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            maxLength: 6,
                          ),
                          const SizedBoxWidget(),
                        ],
                      )),
                  Container(
                    height: 50,
                    width: 280,
                    decoration: BoxDecoration(
                        color: const Color(0xff3E3E3E),
                        borderRadius: BorderRadius.circular(20)),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xff3E3E3E), // Background color
                      ),
                      onPressed: () async {
                        PhoneAuthCredential credential =
                            PhoneAuthProvider.credential(
                                verificationId: verificationID,
                                smsCode: _otpController.text.trim());
                        await _auth.signInWithCredential(credential).then(
                          (value) async {
                            setState(() {
                              user = FirebaseAuth.instance.currentUser;
                              print(user!.metadata.lastSignInTime);
                            });
                            // print("Text:$user.");
                          },
                        ).whenComplete(() {
                          if (user != null) {
                            Fluttertoast.showToast(
                                msg: "You are logged in successfully",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.limeAccent,
                                textColor: Colors.white,
                                fontSize: 16.0);

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const QrCode()));
                          } else {
                            Fluttertoast.showToast(
                                msg: "Your Login is Failed",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.limeAccent,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        });
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class PhoneNumTextWidget extends StatelessWidget {
  const PhoneNumTextWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'Phone Number',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class OtpTextWidget extends StatelessWidget {
  const OtpTextWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'OTP',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class SizedBoxWidget extends StatelessWidget {
  const SizedBoxWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 13,
    );
  }
}
