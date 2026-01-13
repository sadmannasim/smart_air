import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/firestore_service.dart';

class UserProvider extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();

  UserModel? _user;
  bool _isLoading = false;
  String? _error;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Load user data
  Future<void> loadUser(String userId) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      _user = await _firestoreService.getUser(userId);

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  // Update user
  Future<bool> updateUser(String userId, Map<String, dynamic> data) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await _firestoreService.updateUser(userId, data);
      await loadUser(userId);

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

  // Add saved traveler
  Future<bool> addSavedTraveler(
    String userId,
    Map<String, dynamic> traveler,
  ) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final savedTravelers = List<Map<String, dynamic>>.from(
        _user?.savedTravelers ?? [],
      );
      savedTravelers.add(traveler);

      await _firestoreService.updateUser(userId, {
        'savedTravelers': savedTravelers,
      });
      await loadUser(userId);

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

  // Remove saved traveler
  Future<bool> removeSavedTraveler(String userId, int index) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final savedTravelers = List<Map<String, dynamic>>.from(
        _user?.savedTravelers ?? [],
      );

      if (index >= 0 && index < savedTravelers.length) {
        savedTravelers.removeAt(index);

        await _firestoreService.updateUser(userId, {
          'savedTravelers': savedTravelers,
        });
        await loadUser(userId);
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

  // Clear user data
  void clearUser() {
    _user = null;
    _error = null;
    notifyListeners();
  }

  // Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }
}
