import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:musopathy/models/data.dart';
import 'package:musopathy/screens/AnotherVideos.dart';

import 'package:musopathy/screens/videopage.dart';
import 'package:musopathy/widgets/custom_drawer.dart';
import 'package:musopathy/widgets/upperUI.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class Payment extends StatefulWidget {
  int value;
  Payment(this.value);
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  //  static const platform = const MethodChannel("razorpay_flutter");

  Razorpay _razorpay;
  int amount = 300;
  bool success = false;
  final GlobalKey<ScaffoldState> key1 = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    if (success == true) {
      if (widget.value == -1) {
        Provider.of<Data>(context, listen: false).updateUserPayment();
        Provider.of<Data>(context, listen: false).updatePayment();
      } else {
        // Provider.of<Data>(context, listen: false)
        //     .updatenUserPayment(widget.value);
        Provider.of<Data>(context, listen: false).updatenPayment(widget.value);
        Provider.of<Data>(context, listen: false).updaten(widget.value);
      }
    }
    if (widget.value != -1) {
      amount = 60;
    }
    return SafeArea(
      child: Scaffold(
          key: key1,
          appBar: AppBar(
            iconTheme: IconThemeData(color: Color.fromRGBO(40, 115, 161, 1.0)),
            backgroundColor: Colors.white,
            title: Text(
              'M U S O P A T H Y',
              style: TextStyle(
                fontFamily: 'Ubuntu',
                fontSize: 20,
                color: Color.fromRGBO(40, 115, 161, 1.0),
                fontWeight: FontWeight.normal,
              ),
            ),
            // elevation: 4,
          ),
          drawer: CustomDrawer(),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                UpperUI(),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 70),
                    child: (success == true)
                        //success == true
                        ? Icon(
                            Icons.check_circle_outline,
                            color: Colors.green,
                            size: 200,
                          )
                        : Container(
                            height: 150,
                            width: 300,
                            child: widget.value == -1
                                ? Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        "Unlock All Premium Content",
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        "One Time Payment",
                                        style: TextStyle(
                                          fontSize: 22,
                                        ),
                                      ),
                                      Text(
                                        "₹ 300",
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  )
                                : Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        "Unlock ${Provider.of<Data>(context, listen: false).nli[widget.value]["name"]}",
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        "One Time Payment",
                                        style: TextStyle(
                                          fontSize: 22,
                                        ),
                                      ),
                                      Text(
                                        "₹ 60",
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              borderRadius: BorderRadius.circular(15),
                            ),
                          )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1.15,
                    height: 55,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(30)),
                    child: ElevatedButton(
                      onPressed: () {
                        if (success == true) {
                          // Provider.of<Data>(context, listen: false)
                          //     .updateUserPayment();
                          // Provider.of<Data>(context, listen: false)
                          //     .updatePayment();
                          // Provider.of<Data>(context, listen: false).verify();
                          if (widget.value == -1)
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (_) => VideoPage()));
                          else
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (_) => Special()));
                        } else {
                          openCheckout();
                        }
                      },
                      child: success == true
                          ? Text(
                              "Back",
                              textAlign: TextAlign.center,
                            )
                          : Text(
                              "Pay Now",
                              style: TextStyle(fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          primary: Color.fromRGBO(20, 115, 161, 1.0),
                          onPrimary: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return SingleChildScrollView(
                              child: AlertDialog(
                                title: Text('Precautions and Disclaimers'),
                                content: Text("""
                There are no known risks associated with the Clinics Tonation Breathing Techniques (TBT) program.  It has been designed to be less strenuous than talking.   But please note and follow the PRECAUTIONS below carefully.
                
                Do not begin any exercises including the Clinics techniques if you have high fever, difficulty breathing, chest pain or heart palpitations or new swelling in your legs.  
                Stop immediately if you develop dizziness, undue shortness of breath, chest pain, cool, clammy skin, fatigue, irregular heartbeat or any symptoms you consider an emergency. 
                Get emergency attention immediately if these symptoms don’t stop with rest or if you experience any change in physical or mental status from your normal capacity. 
                
                Clisonics Tonation Breathing Techniques (TBT) program is only a supplement to - and not a substitute for - standard clinical treatment. So do NOT stop your medication without your Doctor’s consent.  
                
                                          """),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text('OK'),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: RichText(
                        text: TextSpan(
                          text:
                              ' By clicking Pay Now you acknowledge that you have \n read and understood the ',
                          style: TextStyle(
                              color: Color.fromRGBO(40, 115, 161, 1.0)),
                          children: const <TextSpan>[
                            TextSpan(
                                text: 'Precautions and Disclaimers',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                          ],
                        ),
                      )),
                ),
              ],
            ),
          )),
    );
  }

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    //int p = int.parse(Provider.of<Data>(context, listen: false).phn);
    var options = {
      // 'key': 'rzp_test_NHgsWGJDPm1A5h',
      'key': 'rzp_live_Dtdh96ozWrgTWV',
      'amount': amount * 100,
      'name': 'CLISONICS',
      'description': 'videos access',
      'prefill': {
        'contact': Provider.of<Data>(context, listen: false).phn,
        'email': Provider.of<Data>(context, listen: false).email
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: "SUCCESS:  ${response.paymentId}",
        toastLength: Toast.LENGTH_SHORT);

    setState(() {
      success = true;
    });
  }

  void _handlePaymentError(PaymentFailureResponse response) async {
    success = false;
    Fluttertoast.showToast(
        msg: "ERROR:  ${response.code.toString()}  - ${response.message}",
        toastLength: Toast.LENGTH_SHORT);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET:  ${response.walletName}",
        toastLength: Toast.LENGTH_SHORT);
  }
}
