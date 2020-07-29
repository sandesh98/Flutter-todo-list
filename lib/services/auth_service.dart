import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<String> get onAuthStateChanged => _firebaseAuth.onAuthStateChanged.map(
    (FirebaseUser user) => user?.uid
  );

    // GET UID
  Future<String> getCurrentUID() async {
    return (await _firebaseAuth.currentUser()).uid;
  }

  Future<String> loginUser(String email, String password) async {
    return (await (_firebaseAuth.signInWithEmailAndPassword(email: email, password: password))).user.uid;
  }

  Future<String> registerUser(String email, String password, String name) async {
    final authResult = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

    await updateUserName(name, authResult.user);
    return authResult.user.uid;
  }

  Future updateUserName(String name, FirebaseUser currentUser) async {
    var userUpdateInfo = UserUpdateInfo();
    userUpdateInfo.displayName = name;
    await currentUser.updateProfile(userUpdateInfo);
    await currentUser.reload();
  }

  logout() {
    return _firebaseAuth.signOut();
  }
}

