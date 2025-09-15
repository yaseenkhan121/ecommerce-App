import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfileManager {
  static final _db = FirebaseFirestore.instance;

  static Future<void> createUserProfile(String userId, {String? email, String? name}) async {
    final userRef = _db.collection('users').doc(userId);
    final profileData = {
      'email': email ?? '',
      'name': name ?? 'Guest User',
      'createdAt': FieldValue.serverTimestamp(),
    };

    await userRef.set(profileData, SetOptions(merge: true));
  }

  static Stream<DocumentSnapshot> getUserProfile(String userId) {
    return _db.collection('users').doc(userId).snapshots();
  }
}
