import 'package:chatboat/chat_screen.dart';
import 'package:chatboat/src/exceptions/signup_email_password_failure.dart';
import 'package:chatboat/src/features/authentication/screens/welcom_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  //Variables
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  var verificationId = ''.obs;

  //Will be load when app launches this func will be called and set the firebaseUser state
  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  /// If we are setting initial screen from here
  /// then in the main.dart => App() add CircularProgressIndicator()
  _setInitialScreen(User? user) {
    user == null
        ? Get.offAll(() => const WelcomeScreen())
        : Get.offAll(() => const ChatScreen());
  }

  //FUNC
  Future<String?> createUserWithEmailAndPassword(
      String email, String password, String fullName, String phoneNo) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      firebaseUser.value != null
          ? Get.offAll(() => const ChatScreen())
          : Get.to(() => const WelcomeScreen());
    } on FirebaseAuthException catch (e) {
      final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
      print('FIREBASE AUTHENTICATION-${ex.message} ');
      throw ex;
    } catch (_) {
      const ex = SignUpWithEmailAndPasswordFailure();
      print('FIREBASE AUTHENTICATION-${ex.message} ');
      throw ex;
    }
    return null;
  }

  Future<void> phoneAuthentication(String phoneNo) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: '+919558552406',
      verificationCompleted: (credential) async {
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (e) {
        if (e.code == 'invalid Phone-no') {
          Get.snackbar('Error', 'PhoneNo is not valid');
        }
      },
      codeSent: (verificationId, forceResendingToken) {
        this.verificationId.value = verificationId;
      },
      codeAutoRetrievalTimeout: (verificationId) {
        this.verificationId.value = verificationId;
      },
    );
  }

  Future<bool> verifyOTP(String otp) async {
    var credentials = await _auth;
    await _auth.signInWithCredential(PhoneAuthProvider.credential(
        verificationId: this.verificationId.value, smsCode: otp));
    return credentials.currentUser != null ? true : false;
  }

  Future<String?> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
    } catch (_) {}
    return null;
  }

  Future<void> logout() async => await _auth.signOut();
}
