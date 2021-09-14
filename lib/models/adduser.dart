import 'package:cloud_firestore/cloud_firestore.dart';

class AddUser {
  final String email;
  final String fullName;
  final bool paid;
  final String dob;
  final String phn;
  final String photourl;
  final String gender;
  final String country;
  final bool added;
  final List nexercises;

  AddUser(
    this.fullName,
    this.paid,
    this.phn,
    this.email,
    this.photourl,
    this.dob,
    this.gender,
    this.country,
    this.added,
    this.nexercises,
  );

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> addUser() {
    if (added == false) {
      return users
          .doc(email)
          .set({
            "email": email,
            'full_name': fullName,
            "paid": paid,
            "phoneno": phn,
            "photourl": photourl,
            "dob": dob,
            "gender": gender,
            "country": country,
            "npaid": nexercises,
            "cc": "+91"
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }
  }
}
