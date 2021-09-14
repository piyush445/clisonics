import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String userName;
  bool iSignedIn = false;
  GoogleSignInAccount _currentUser;

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {
        setState(() {
          iSignedIn = true;
          userName = account.displayName;
          print("");
        });
      }
    });
    _googleSignIn.signInSilently().then((value) {
      if (value != null) {
        setState(() {
          userName = value.displayName;
        });
      }
    });
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn().then((value) {
        value.authentication.then((valueq) {
          print(valueq.idToken);
        });
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Material App Bar'),
      ),
      body: Center(
        child: Container(
          child: Text(iSignedIn ? userName : 'empty user name'),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add),
        label: Text(iSignedIn ? 'Sign Out' : 'Sign In'),
        onPressed: () {
          if (!iSignedIn) {
            _handleSignIn();
          } else {
            _googleSignIn.signOut();
            setState(() {
              iSignedIn = false;
            });
          }
        },
      ),
    );
  }
}
