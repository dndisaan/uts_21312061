import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project_get/app/routes/app_pages.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  Stream<User?> get streamAuthstatus => auth.authStateChanges();

  void signup(String emailAddress, String password) async {
    try {
  UserCredential myUser = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: emailAddress,
    password: password,
  );
  await myUser.user!.sendEmailVerification();
  Get.defaultDialog(
    title: "Verifikasi Email",
    middleText: 
        " Kami Telah Mengirimkan Verifikasi ke Email $emailAddress",
    onConfirm: () {
      Get.back();
      Get.back();
    },
    textConfirm: "OK");

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

  void login(String emailAddress, String password) async {
    try {
  UserCredential myUser = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: emailAddress,
    password: password
  );
  if (myUser.user!.emailVerified) {
    Get.offAllNamed(Routes.HOME);
  } else {
    Get.defaultDialog(
      title: "Verifikasi Email",
      middleText: "Harap Verifikasi Email Terlebih Dahulu",
    );
  }
} on FirebaseAuthException catch (e) {
  if (e.code == 'user-not-found') {
    Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "No user found for that email.");
    print('No user found for that email.');
  } else if (e.code == 'wrong-password') {
    Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "Wrong password provided for that user.");
    print('Wrong password provided for that user.');
  }
}
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }

  void resetPassword(String email) async {
    if(email != "" && GetUtils.isEmail(email)) {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        Get.defaultDialog(
        title: "Berhasil",
        middleText: "Kami Telah mengirimkan reset Password ke $email",
        onConfirm: () {
          Get.back();
          Get.back();
        },
        textConfirm: "OK"
        );
      } catch (e) {
        Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "Tidak Dapat Melakukan Reset Password");
      }
    } else {
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "Masukan Alamat Email yang Valid"
      );
    }
  }

void LoginGoogle() async{
  try {
    GoogleSignIn _googleSigIn = GoogleSignIn();
    GoogleSignInAccount? googleUser = await _googleSigIn.signIn();

    if(googleUser != null) {
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
       );
      await FirebaseAuth.instance.signInWithCredential(credential);
      Get.offNamed(Routes.HOME);
    } else {
      throw "Belum Memiliki akun google";
    }
  } catch (eror) {
    print(eror);
    Get.defaultDialog(
      title: "Terjadi Kesalahan",
      middleText: "${eror.toString()}",
    );
  }
}

}
