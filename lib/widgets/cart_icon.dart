import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;
import '../providers/cart_provider.dart';
import '../screens/cart_page.dart';

class CartIcon extends StatelessWidget {
  const CartIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cart, child) {
        return badges.Badge(
          position: badges.BadgePosition.topEnd(top: -4, end: -4),
          showBadge: cart.items.isNotEmpty,
          badgeContent: Text(
            cart.items.length.toString(),
            style: const TextStyle(color: Colors.white, fontSize: 10),
          ),
          child: IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartPage()),
              );
            },
          ),
        );
      },
    );
  }
}