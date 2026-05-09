import 'dart:developer' as console;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:monkey_shop/domain/models/user.dart';

class FirebaseUserService {
  final CollectionReference<Map<String, dynamic>> _usersRef = FirebaseFirestore.instance.collection('users');

  Future<List<User>> fetchAllUsers() async{
    final snapshot = await _usersRef.get();
    return snapshot.docs.map((doc) {
      final data = doc.data();

      return User(
        id: data['id'] ?? 0,
        name: data['name'] ?? '',
        login: data['login'] ?? '',
        password: data['password'] ?? '',
        role: data['role'] ?? 'user'
      );
    }).whereType<User>().toList();
  }

  Future<void> upsertUser(User user) async {
    final docId = 'user_${user.id}';
    final Map<String, dynamic> data = {
      'id': user.id,
      'name': user.name,
      'login': user.login,
      'password': user.password,
      'role': user.role,
    };

    await _usersRef.doc(docId).set(data, SetOptions(merge: true));
  }

  Future<void> deleteUser(User user) async {
    final docId = 'user_${user.id}';
    await _usersRef.doc(docId).delete();
  }

  Future<bool> userExists(int localUserId) async {
    final doc = await _usersRef.doc('user_$localUserId').get();
    return doc.exists;
  }

  Future<User?> getUserByLogin(String login) async {
    try {
      final snapshot = await _usersRef
          .where('login', isEqualTo: login)
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) return null;

      final doc = snapshot.docs.first;
      final data = doc.data();

      return User(
        id: data['id'] ?? 0,
        name: data['name'] ?? '',
        login: data['login'] ?? '',
        password: data['password'] ?? '',
        role: data['role'] ?? 'user',
      );
    } catch (e) {
      console.log('Error getting user by login: $e');
      return null;
    }
  }
}