import 'package:flutter/material.dart';
import 'package:flutter_provider/data/product_data.dart';
import 'package:flutter_provider/models/product_model.dart';
import 'package:flutter_provider/pages/cart_page.dart';
import 'package:flutter_provider/pages/favourite_page.dart';
import 'package:flutter_provider/providers/cart_provider.dart';
import 'package:flutter_provider/providers/favourite_provider.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Product> products = ProductData().products;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Shop - Flutter Provider",
          style: TextStyle(
            color: Colors.deepPurpleAccent,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FavouritePage(),
                ),
              );
            },
            heroTag: "fav_button",
            backgroundColor: Colors.purpleAccent,
            child: Icon(
              Icons.favorite,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CartPage(),
                ),
              );
            },
            heroTag: "cart_button",
            backgroundColor: Colors.purpleAccent,
            child: Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final Product product = products[index];
          return Card(
            child: Consumer2<CartProvider, FavouriteProvider>(
              builder: (BuildContext context, CartProvider cartProvider,
                  FavouriteProvider favouriteProvider, Widget? child) {
                return ListTile(
                  title: Row(
                    children: [
                      Text(
                        product.title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Text(
                        cartProvider.items.containsKey(product.id)
                            ? cartProvider.items[product.id]!.quantity
                                .toString()
                            : "0",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  subtitle: Text("Rs.${product.price.toString()}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          favouriteProvider.toggleFavourites(product.id);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                favouriteProvider.isFavourite(product.id)
                                    ? "Added to Favourites!"
                                    : "Removed from Favourites!"),
                            duration: Duration(seconds: 1),
                          ));
                        },
                        icon: Icon(
                          favouriteProvider.isFavourite(product.id)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: favouriteProvider.isFavourite(product.id)
                              ? Colors.purpleAccent
                              : Colors.grey,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          cartProvider.addItem(
                              product.id, product.price, product.title);

                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Added to Cart!"),
                            duration: Duration(seconds: 1),
                          ));
                        },
                        icon: Icon(
                          Icons.shopping_cart,
                          color: cartProvider.items.containsKey(product.id)
                              ? Colors.purpleAccent
                              : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
