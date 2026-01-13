import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final FirestoreService _firestoreService = FirestoreService();

  User? _firebaseUser;
  UserModel? _userModel;
  bool _isLoading = false;
  String? _error;

  User? get firebaseUser => _firebaseUser;
  UserModel? get userModel => _userModel;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => _firebaseUser != null;

  AuthProvider() {
    _initializeAuthListener();
  }

  // Initialize auth state listener
  void _initializeAuthListener() {
    _authService.authStateChanges.listen((User? user) async {
      _firebaseUser = user;
      if (user != null) {
        await _loadUserModel(user.uid);
      } else {
        _userModel = null;
      }
      notifyListeners();
    });
  }

  // Load user model from Firestore
  Future<void> _loadUserModel(String userId) async {
    try {
      _userModel = await _firestoreService.getUser(userId);
      notifyListeners();
    } catch (e) {
      print('Error loading user model: $e');
    }
  }

  // Register with email and password
  Future<bool> register({
    required String email,
    required String password,
    required String displayName,
  }) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final userCredential = await _authService.registerWithEmailAndPassword(
        email: email,
        password: password,
        displayName: displayName,
      );

      _isLoading = false;
      if (userCredential != null) {
        _firebaseUser = userCredential.user;
        if (_firebaseUser != null) {
          await _loadUserModel(_firebaseUser!.uid);
        }
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  // Sign in with email and password
  Future<bool> signIn({
    required String email,
    required String password,
  }) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final userCredential = await _authService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      _isLoading = false;
      if (userCredential != null) {
        _firebaseUser = userCredential.user;
        if (_firebaseUser != null) {
          await _loadUserModel(_firebaseUser!.uid);
        }
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  // Sign in with Google
  Future<bool> signInWithGoogle() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final userCredential = await _authService.signInWithGoogle();

      _isLoading = false;
      if (userCredential != null) {
        _firebaseUser = userCredential.user;
        if (_firebaseUser != null) {
          await _loadUserModel(_firebaseUser!.uid);
        }
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  // Send password reset email
  Future<bool> sendPasswordResetEmail(String email) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await _authService.sendPasswordResetEmail(email);

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      _isLoading = true;
      notifyListeners();

      await _authService.signOut();
      _firebaseUser = null;
      _userModel = null;

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  // Update user profile
  Future<bool> updateProfile({
    String? displayName,
    String? photoUrl,
    String? phoneNumber,
  }) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      // Update Firebase Auth profile
      if (displayName != null || photoUrl != null) {
        await _authService.updateProfile(
          displayName: displayName,
          photoUrl: photoUrl,
        );
      }

      // Update Firestore user document
      if (_firebaseUser != null) {
        final updates = <String, dynamic>{};
        if (displayName != null) updates['displayName'] = displayName;
        if (photoUrl != null) updates['photoUrl'] = photoUrl;
        if (phoneNumber != null) updates['phoneNumber'] = phoneNumber;

        if (updates.isNotEmpty) {
          await _firestoreService.updateUser(_firebaseUser!.uid, updates);
          await _loadUserModel(_firebaseUser!.uid);
        }
      }

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  // Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }
}
