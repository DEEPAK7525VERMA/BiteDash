// main.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';

// Define the data model for a canteen menu item.
class CanteenMenuItem {
  final String id;
  final String name;
  final double price;
  final bool availability;
  final String imageUrl;

  CanteenMenuItem({
    required this.id,
    required this.name,
    required this.price,
    required this.availability,
    required this.imageUrl,
  });

  factory CanteenMenuItem.fromJson(Map<String, dynamic> json) {
    // Correctly handle the 'price' field, which might be a String or a number.
    double priceValue = 0.0;
    if (json['price'] != null) {
      if (json['price'] is num) {
        priceValue = json['price'].toDouble();
      } else if (json['price'] is String) {
        priceValue = double.tryParse(json['price']) ?? 0.0;
      }
    }

    return CanteenMenuItem(
      id: json['id'] as String,
      name: json['name'] as String,
      price: priceValue,
      availability: json['availability'] as bool? ?? false,
      imageUrl: json['imageUrl'] as String? ?? 'https://placehold.co/100x100',
    );
  }
}

// This is the model that manages our application's state.
// It extends ChangeNotifier to notify its listeners of any changes.
class CanteenMenuModel extends ChangeNotifier {
  List<CanteenMenuItem> _menuItems = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<CanteenMenuItem> get menuItems => _menuItems;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  CanteenMenuModel() {
    // Fetch data as soon as the model is created.
    fetchMenuItems();
  }

  // Asynchronous function to fetch data from the API.
  Future<void> fetchMenuItems() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners(); // Notify listeners that we are starting to load.

    const apiUrl = 'https://68a043526e38a02c58182d50.mockapi.io/canteen/menu';
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final List<dynamic> menuJson = json.decode(response.body);
        _menuItems = menuJson.map((json) => CanteenMenuItem.fromJson(json)).toList();
        _errorMessage = null; // Clear any previous error message.
      } else {
        _errorMessage = 'Failed to load menu items: Status code ${response.statusCode}';
      }
    } catch (e) {
      _errorMessage = 'Failed to load menu items: $e';
    } finally {
      _isLoading = false;
      notifyListeners(); // Notify listeners that the state has been updated.
    }
  }
}

// The main entry point of the application.
// The entire app is now wrapped in a ChangeNotifierProvider.
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CanteenMenuModel(),
      child: const CanteenApp(),
    ),
  );
}

// The root widget of the app.
class CanteenApp extends StatelessWidget {
  const CanteenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'College Canteen',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Roboto',
      ),
      home: const CanteenMenuPage(),
    );
  }
}

// CanteenMenuPage is now a StatelessWidget that uses a Consumer to listen for changes.
class CanteenMenuPage extends StatelessWidget {
  const CanteenMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('College Canteen Menu'),
        centerTitle: true,
        // Add a refresh button to the AppBar
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Trigger a data fetch when the button is pressed.
              Provider.of<CanteenMenuModel>(context, listen: false).fetchMenuItems();
            },
          ),
        ],
      ),
      body: Center(
        // Use a Consumer to rebuild only the parts of the widget tree that need to update.
        child: Consumer<CanteenMenuModel>(
          builder: (context, menuModel, child) {
            if (menuModel.isLoading) {
              return const CircularProgressIndicator();
            } else if (menuModel.errorMessage != null) {
              return Text('Error: ${menuModel.errorMessage}');
            } else if (menuModel.menuItems.isEmpty) {
              return const Text('No menu items available.');
            } else {
              // If data is available, display the menu in a list.
              return ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: menuModel.menuItems.length,
                itemBuilder: (context, index) {
                  final item = menuModel.menuItems[index];
                  return MenuItemCard(item: item);
                },
              );
            }
          },
        ),
      ),
    );
  }
}

// A custom widget to display each menu item in a card.
class MenuItemCard extends StatelessWidget {
  final CanteenMenuItem item;

  const MenuItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final availabilityColor = item.availability ? Colors.green : Colors.red;
    final availabilityText = item.availability ? 'Available' : 'Sold Out';

    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(item.imageUrl),
              onBackgroundImageError: (exception, stackTrace) {
                debugPrint('Failed to load image: ${item.imageUrl}');
              },
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    '₹${item.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
            Chip(
              label: Text(
                availabilityText,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: availabilityColor,
            ),
          ],
        ),
      ),
    );
  }
}
