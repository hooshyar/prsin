import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prsin/src/data_models/user_data_model.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  GeneralUser? generalUser;

  String? phoneNumber;
  String? smsCode;
  String? verificationID;
  String? userName;

  void setPhoneNumber(String phoneNum) {
    phoneNumber = phoneNum;
    notifyListeners();
  }

  void setTheSmsCode(String theSmsCode) {
    smsCode = theSmsCode;
    notifyListeners();
  }

  void setTheVerificationID(String theVerificationID) {
    debugPrint(theVerificationID);
    verificationID = theVerificationID;
    notifyListeners();
  }

  void setTheUserName(String theUserName) {
    debugPrint(theUserName);
    userName = theUserName;
    notifyListeners();
  }

  void setTheGUser(GeneralUser theGeneralUser) {
    debugPrint(theGeneralUser.phoneNumber);
    generalUser = theGeneralUser;
    notifyListeners();
  }

  Future<void> verifyPhoneNumber() async {
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber!,
      verificationCompleted: (PhoneAuthCredential credential) {
        debugPrint('verification completed');
      },
      verificationFailed: (FirebaseAuthException e) {
        debugPrint('failed ${e.toString()}');
      },
      codeSent: (String verificationId, int? resendToken) {
        setTheVerificationID(verificationId);

        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => RegisterConfirmationScreenView(
        //       verificationID: verificationId,
        //       userName: username,
        //     ),
        //   ),
        // );
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  verifySmsCode() async {
// returns a user credential
    PhoneAuthCredential _credential = PhoneAuthProvider.credential(
        verificationId: verificationID!, smsCode: smsCode!);

    debugPrint('before');

    UserCredential _userCredential =
        await auth.signInWithCredential(_credential);

    GeneralUser _gUser = GeneralUser(
        email: '',
        userName: userName ?? 'no name',
        uid: _userCredential.user!.uid,
        phoneNumber: _userCredential.user!.phoneNumber!,
        createdQuestions: [],
        correctAnswersCount: 0,
        tokens: []);

    await addtheUserToTheDatabase(_gUser);
  }

  Future<void> addtheUserToTheDatabase(GeneralUser gUser) async {
    await _firestore
        .collection('users')
        .doc(gUser.uid)
        .set(gUser.toMap(), SetOptions(merge: true));

    setTheGUser(gUser);
  }

  Stream<User?> get authStatusChanges => auth.authStateChanges();

  Future<bool> isUserLoggedIn() async {
    if (auth.currentUser != null) {
      GeneralUser _generaluser = await _firestore
          .collection('users')
          .doc(auth.currentUser!.uid)
          .get()
          .then((value) => GeneralUser.fromSnapshot(value));

      setTheGUser(_generaluser);
      return true;
    }
    return false;
  }
}
