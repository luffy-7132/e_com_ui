import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';
import 'add_to_cart_screen.dart';

String baseUrl = "https://www.infusevalue.live/storage/app/public/product/";

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Products> cartItems = []; // List to store cart items

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Home Screen'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartScreen(cartItems: cartItems),
                ),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<Product_Model>(
        future: Latest_Products(context),
        builder: (context, snapshot) {
          print(snapshot.data);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final product = snapshot.data!.products![index];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: ListTile(
                    leading: Container(
                      height: 200,
                      width: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage('$baseUrl${product.images![0]}'),
                        ),
                      ),
                    ),
                    title: Text(product.name.toString()),
                    subtitle: Text(product.purchasePrice.toString()),
                    trailing: IconButton(
                      icon: Icon(Icons.add_shopping_cart),
                      onPressed: () {
                        setState(() {
                          cartItems.add(product);
                        });
                      },
                    ),
                  ),
                );
              },
              itemCount: snapshot.data!.products!.length,
            );
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Center(child: Text('error'));
          } else {
            return Text('hi9');
          }
        },
      ),
    );
  }

  Future<Product_Model> Latest_Products(BuildContext context) async {
    try {
      String url =
          "https://www.infusevalue.live/api/v1/products/latest?limit=10";
      final response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        print(response.body);
        print(response.statusCode);
        final responseData = jsonDecode(response.body);
        return Product_Model.fromJson(responseData);
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      throw Exception('Error during HTTP request: $e');
    }
  }
}
