import 'package:e_com_ui/models/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart';

class CartScreen extends StatefulWidget {
  final List<Products> cartItems; // List of cart items

  const CartScreen({Key? key, required this.cartItems}) : super(key: key);
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: widget.cartItems.isEmpty
          ? Center(child: Text('Cart is empty'))
          : ListView.builder(
              itemBuilder: (context, index) {
                final product = widget.cartItems[index];
                return ListTile(
                  leading: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            '$baseUrl${product.images![0].toString()}'),
                      ),
                    ),
                  ),
                  title: Text(product.name.toString()),
                  subtitle: Text('\$${product.purchasePrice}'),
                  trailing: IconButton(
                    onPressed: () {
                      widget.cartItems.remove(product);
                      setState(() {});
                    },
                    icon: Icon(Icons.delete),
                  ),
                );
              },
              itemCount: widget.cartItems.length,
            ),
    );
  }
}
