import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:musopathy/models/data.dart';

import 'package:musopathy/screens/loginUi.dart';
import 'package:musopathy/widgets/BUtton.dart';

import 'package:musopathy/widgets/custom_drawer.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:io';

class WebViewExample extends StatefulWidget {
  @override
  WebViewExampleState createState() => WebViewExampleState();
}

class WebViewExampleState extends State<WebViewExample> {
  final GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  Future<int> checkConnection() async {
    // var connectivityResult = await (Connectivity().checkConnectivity());
    // if (connectivityResult == ConnectivityResult.mobile) {
    //   // I am connected to a mobile network.
    //   return 1;
    // } else if (connectivityResult == ConnectivityResult.wifi) {
    //   // I am connected to a wifi network.
    //   return 1;
    // }
    // return Future.error(
    //     "This is the error", StackTrace.fromString("This is its trace"));
    if (await DataConnectionChecker().hasConnection) return 1;
    return Future.error(
        "This is the error", StackTrace.fromString("This is its trace"));
  }

  WebViewController _controller;

  bool loggedin = false;
  String url =
      //"https://player.vimeo.com/video/563210963?badge=0&amp;autopause=0&amp;player_id=0&amp;app_id=58479";
      "https://player.vimeo.com/video/571124806?badge=0&amp;autopause=0&amp;player_id=0&amp;app_id=58479";
  @override
  void initState() {
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    final Future<int> result = checkConnection();
    return SafeArea(
      child: Scaffold(
        key: key,
        drawer: CustomDrawer(),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Color.fromRGBO(40, 115, 161, 1.0)),
          // elevation: 0,
          // bottomOpacity: 0.0,
          // leading: IconButton(
          //     icon: Icon(Icons.menu),
          //     iconSize: 30.0,
          //     color: Theme.of(context).primaryColor,
          //     onPressed: () => key.currentState.openDrawer()),
          // iconTheme: IconThemeData(color: Color.fromRGBO(40, 115, 161, 1.0)),
          // centerTitle: true,
          backgroundColor: Colors.white,
          title: Text(
            'C L I S O N I C S',
            style: TextStyle(
              fontFamily: 'Ubuntu',
              fontSize: 20,
              color: Color.fromRGBO(40, 115, 161, 1.0),
              fontWeight: FontWeight.normal,
              //fontWeight: FontWeight.bold,
            ),
          ),
          elevation: 4,
        ),
        // drawer: Drawer(),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              LimitedBox(
                maxHeight: 230,
                maxWidth: double.infinity,
                child: FutureBuilder<int>(
                  future:
                      result, // a previously-obtained Future<String> or null
                  builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                    if (snapshot.hasData) {
                      return WebView(
                          initialUrl: url,
                          javascriptMode: JavascriptMode.unrestricted,
                          onWebViewCreated: (WebViewController c) {
                            _controller = c;
                          });
                    } else if (snapshot.hasError) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.error_outline,
                            color: Colors.red,
                            size: 60,
                          ),
                          Text(
                            "net:: ERR_INTERNET_DISCONNECTED",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GestureDetector(
                            child: Text("Tap to retry once connected"),
                            onTap: () {
                              setState(() {});
                            },
                          ),
                        ],
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "The Clisonics TBT Health and Wellness App consists of instructional videos of non-strenuous Tonation Breathing Techniques (TBTs) that can help you combat several conditions.  Respiratory issues from Common Cold to ARDS & COPD, Muscular tension, Sinus headaches, Sleep disorders, Stress, Anxiety, Depression, Aggression, Anger, Panic & Phobia and other Behavioral issues.  It also helps in Pain Management and Mind Management by increasing focus, clarity, calmness, energy, stamina, and equanimity. The TBT Wellness Videos** are of two types: (a) TBT Techniques such as Nasal Tonation, Buzz Tonation, Pursed Lips Tonation & Pronal Tonation and (b) Applications for various conditions mentioned above.  The duration of each video has been intentionally kept short to enable participants to stay focused and grasp the technique easily and do it themselves thereafter. For optimal results, it is strongly recommended that you schedule online or live individual or group Wellness or Excellence training sessions with out experts by emailing wellness@clisonics.com.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontFamily: 'Poppins', fontSize: 18),
                ),
              ),
              // SizedBox(
              //   height: 20.0,
              // ),
              Button(
                "Login/Register",
                //   style: TextStyle(fontSize: 20),
                //   textAlign: TextAlign.center,
                // ),

                () {
                  _controller.clearCache();
                  // _controller1.pause();
                  if (Provider.of<Data>(context, listen: false).loggedin ==
                      true) {
                    // return AlertDialog(
                    //   title: const Text('Dear User'),
                    //   content: SingleChildScrollView(
                    //     child: ListBody(
                    //       children: const <Widget>[
                    //         Text('You are already logged in'),
                    //       ],
                    //     ),
                    //   ),
                    //   actions: <Widget>[
                    //     TextButton(
                    //       child: const Text('Okay'),
                    //       onPressed: () {
                    //         Navigator.of(context).pop();
                    //       },
                    //     ),
                    //   ],
                    // );
                    // final snackBar =
                    //     SnackBar(content: Text('You are already logged in!!!'));

                    // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    Fluttertoast.showToast(
                        msg: "You are already loggedin",
                        toastLength: Toast.LENGTH_LONG);
                    // }
                  } else {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => MyHomePage()));
                  }
                },
              ),
              SizedBox(
                height: 2.0,
              ),
              // Button(
              //   "Exercises",
              //   // style: TextStyle(fontSize: 20),
              //   // textAlign: TextAlign.center,

              //   () async {
              //     await _controller.clearCache();
              //     Navigator.pushReplacement(
              //         context, MaterialPageRoute(builder: (_) => Language()));
              //   },
              // )
            ],
          ),
        ),
      ),
    );
  }
}
