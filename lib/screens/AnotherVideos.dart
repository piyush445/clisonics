import 'package:draggable_bottom_sheet/draggable_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:musopathy/models/data.dart';
import 'package:musopathy/screens/loginUi.dart';
import 'package:musopathy/screens/payment.dart';
import 'package:musopathy/widgets/custom_drawer.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'dart:io';

class Special extends StatefulWidget {
  @override
  _SpecialState createState() => _SpecialState();
}

class _SpecialState extends State<Special> {
  // bool isLoading = true;
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

  @override
  void initState() {
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    super.initState();
  }

  WebViewController _controller;
  // final flutterWebviewPlugin = new FlutterWebviewPlugin();
  final GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final Future<int> result = checkConnection();
    return Scaffold(
      key: key,
      drawer: CustomDrawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color.fromRGBO(40, 115, 161, 1.0)),
        backgroundColor: Colors.white,
        title: Text(
          'C L I S O N I C S',
          style: TextStyle(
            fontFamily: 'Ubuntu',
            fontSize: 20,
            color: Color.fromRGBO(40, 115, 161, 1.0),
            fontWeight: FontWeight.normal,
          ),
        ),
        elevation: 4,
      ),
      body: DraggableBottomSheet(
        backgroundWidget: SingleChildScrollView(
            child: Container(
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
                    if (snapshot.hasData &&
                        Provider.of<Data>(context).currentnUrl != null) {
                      return WebView(
                          initialUrl: Provider.of<Data>(context).currentnUrl,
                          javascriptMode: JavascriptMode.unrestricted,
                          onWebViewCreated: (WebViewController c) {
                            _controller = c;
                          });
                    } else if (snapshot.hasError) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                child: Text(
                  // Provider.of<Data>(context, listen: false).name,
                  Provider.of<Data>(context).currentnname == null
                      ? "loading.."
                      : Provider.of<Data>(context).currentnname,
                  style: TextStyle(
                    fontFamily: 'Ubuntu',
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  Provider.of<Data>(context, listen: false).currentndesc == null
                      ? "loading.."
                      : Provider.of<Data>(context).currentndesc,
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontFamily: 'Poppins', fontSize: 18),
                ),
              ),
              SizedBox(
                height: 70,
              )
            ],
          ),
        )),
        expandedChild: DraggableScrollableSheet(
          initialChildSize: 0.8,
          minChildSize: 0.8,
          maxChildSize: 1.0,
          builder: (BuildContext context, ScrollController scrollController) =>
              FutureBuilder<int>(
            future: result, // a previously-obtained Future<String> or null
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              if (snapshot.hasData && Provider.of<Data>(context).nli != null) {
                return Scaffold(
                    body: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                        color: Colors.white,
                        child: ListTile(
                          trailing: (index > 0) &&
                                  (Provider.of<Data>(context).loggedin ==
                                          false ||
                                      Provider.of<Data>(context, listen: false)
                                              .npaid[index] ==
                                          false)
                              ? Icon(
                                  Icons.lock,
                                  color: Colors.black,
                                )
                              : null,
                          leading: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Text(
                              "${index + 1}",
                              style: TextStyle(
                                  color: Color.fromRGBO(40, 115, 161, 1.0)),
                            ),
                          ),
                          title: Text(
                            Provider.of<Data>(context).nli[index]["name"],
                            style: TextStyle(
                                color: Color.fromRGBO(40, 115, 161, 1.0)),
                          ),
                          // subtitle: Text(
                          //     Provider.of<Data>(context, listen: false)
                          //         .nli[index]["description"]),
                          onTap: () {
                            if ((Provider.of<Data>(context, listen: false)
                                        .loggedin ==
                                    true) &&
                                Provider.of<Data>(context, listen: false)
                                    .npaid[index]) {
                              Provider.of<Data>(context, listen: false)
                                  .updateCurrentnDetails(index);
                              _controller.loadUrl(
                                  Provider.of<Data>(context, listen: false)
                                      .currentnUrl);
                            } else if (Provider.of<Data>(context, listen: false)
                                    .loggedin ==
                                true) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => Payment(index)));
                            } else {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => MyHomePage()));
                            }
                          },
                        ));
                  },
                  itemCount:
                      Provider.of<Data>(context, listen: false).nli.length,
                ));
              }

              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
        previewChild: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Color.fromRGBO(40, 115, 161, 1.0),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Column(children: <Widget>[
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
              ),
              SizedBox(
                height: 8,
              ),
              Text('Wellness Solutions',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
              //SizedBox(height: 16),
            ])),
        minExtent: 65,
        maxExtent: MediaQuery.of(context).size.height * 0.8,
      ),
    );
  }
}
