import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/features/auth/models/users.dart';

final userDataServiceProvider = Provider(
  (ref) => UserService(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  ),
);

class UserService {
  FirebaseAuth auth;
  FirebaseFirestore firestore;

  UserService({
    required this.auth,
    required this.firestore,
  });

  addUserDataToFireStore({
    required String displayName,
    required String email,
    required String username,
    required String description,
    required String profilePicture,
  }) async {
    UserModel user = UserModel(
      displayName: displayName,
      email: email,
      username: username,
      description: description,
      profilePic: profilePicture,
      userId: auth.currentUser!.uid,
      subscriptions: [],
      type: 'user',
      videos: 0,
    );

    await firestore.collection('users').doc(auth.currentUser!.uid).set(user.toMap());
  }
  
}