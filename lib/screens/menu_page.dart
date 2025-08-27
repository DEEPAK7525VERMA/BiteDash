import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/menu_provider.dart';
import '../widgets/menu_item_card.dart';
import '../widgets/cart_icon.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final menuProvider = Provider.of<MenuProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('BiteDash Menu'),
        actions: const [
          CartIcon(),
          SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              onChanged: (value) {
                menuProvider.searchMenu(value);
              },
              decoration: InputDecoration(
                hintText: 'Search for food...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
            ),
          ),
          // Menu List
          Expanded(
            child: _buildMenuBody(context, menuProvider),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuBody(BuildContext context, MenuProvider menuProvider) {
    if (menuProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (menuProvider.errorMessage != null) {
      return Center(child: Text('Error: ${menuProvider.errorMessage}'));
    }

    if (menuProvider.categorizedItems.isEmpty) {
      return const Center(child: Text('No items found.'));
    }

    final categories = menuProvider.categorizedItems.keys.toList();

    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        final items = menuProvider.categorizedItems[category]!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                category,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (context, itemIndex) {
                return MenuItemCard(item: items[itemIndex]);
              },
            ),
          ],
        );
      },
    );
  }
}