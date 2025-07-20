import 'package:firebase_auth/firebase_auth.dart';

class Authentication{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signupWithEmailPassword(String email, String password) async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      return result.user;
    } catch(e){
      print(e.toString());
      return null;
    }
  }

  Future<User?> loginWithEmailPassword(String email, String password) async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password);
      return result.user;
    } catch(e){
      print(e.toString());
      return null;
    }
  }

  Future<void> signOut() async{
    try{
      await _auth.signOut();
    } catch(e){
      print(e.toString());
    }
  }
}