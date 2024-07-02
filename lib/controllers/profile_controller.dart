import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileController extends GetxController {
  Map profile = {'displayName': ''}.obs;

  @override
  void onInit() {
    getProile();
    super.onInit();
  }

  void signOutMe() async {
    final box = GetStorage();
    await FirebaseAuth.instance.signOut();
    box.write('user', null);
    Get.toNamed('/login');
  }

  void getProile() {
    final box = GetStorage();
    if (box.read('user') != null) {
      profile = box.read('user') as Map;
      update();
    }
  }

  Future<void> login(email, password) async {
    try {
      print("Login------------->");
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      print(userCredential);
      final box = GetStorage();
      Map userMap = {
        "displayName": userCredential.user!.displayName,
        "email": userCredential.user!.email,
        "phoneNumber": userCredential.user!.phoneNumber,
        "photoURL": userCredential.user!.photoURL,
        "uid": userCredential.user!.uid,
      };
      box.write('user', userMap);
      Get.offAllNamed('/home');

      // print(userCredential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
}
