import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/menu_item.dart';

class MenuProvider extends ChangeNotifier {
  List<MenuItem> _allItems = [];
  List<MenuItem> _filteredItems = [];
  Map<String, List<MenuItem>> _categorizedItems = {};
  bool _isLoading = false;
  String? _errorMessage;
  String _searchQuery = '';

  List<MenuItem> get filteredItems => _filteredItems;
  Map<String, List<MenuItem>> get categorizedItems => _categorizedItems;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  MenuProvider() {
    fetchMenuItems();
  }

  Future<void> fetchMenuItems() async {
    _isLoading = true;
    notifyListeners();

    // Replace with your actual mock API endpoint
    const apiUrl = 'https://68a043526e38a02c58182d50.mockapi.io/canteen/menu';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final List<dynamic> menuJson = json.decode(response.body);
        _allItems = menuJson.map((json) => MenuItem.fromJson(json)).toList();
        _filterAndCategorizeItems();
        _errorMessage = null;
      } else {
        _errorMessage = 'Failed to load menu: Status ${response.statusCode}';
      }
    } catch (e) {
      _errorMessage = 'Failed to connect to the server: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void searchMenu(String query) {
    _searchQuery = query;
    _filterAndCategorizeItems();
  }

  void _filterAndCategorizeItems() {
    if (_searchQuery.isEmpty) {
      _filteredItems = _allItems;
    } else {
      _filteredItems = _allItems
          .where((item) =>
              item.name.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    }
    
    _categorizedItems = {};
    for (var item in _filteredItems) {
      if (!_categorizedItems.containsKey(item.category)) {
        _categorizedItems[item.category] = [];
      }
      _categorizedItems[item.category]!.add(item);
    }
    
    notifyListeners();
  }
}