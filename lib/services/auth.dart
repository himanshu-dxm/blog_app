import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;


  Future signInWithEmailAndPassword(String email,String password) async {
    try {
      if(email.isEmpty) {
        print("Empty Email");
      } else if(password.isEmpty) {
        print("Password Empty");
      } else {
        print("Noting is Empty");
      }
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? fireBaseUser = userCredential.user;
      return fireBaseUser!.uid;
      // return _userFromFirebaseUser(fireBaseUser);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        return 1;
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        return 2;
      }
    } catch(e) {
      print(e);
    }
  }

  Future signUpWithEmailAndPassword(String email,String password,userMap) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      User? fireBaseUser = userCredential.user;
      FirebaseFirestore.instance.collection("users").add(userMap).
      catchError((e) {
        print(e.toString());
      });
      return fireBaseUser!.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

}