import 'package:flutter/material.dart';
import 'package:flutter_provider/data/product_data.dart';
import 'package:flutter_provider/models/product_model.dart';
import 'package:flutter_provider/providers/favourite_provider.dart';
import 'package:provider/provider.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Favourite Page",
          style: TextStyle(
            color: Colors.deepPurpleAccent,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      ),
      body: Consumer<FavouriteProvider>(
        builder: (BuildContext context, FavouriteProvider favProovider,
            Widget? child) {
          final favItems = favProovider.favourites.entries
              .where((entry) => entry.value)
              .map((entry) => entry.key)
              .toList();

          if (favItems.isEmpty) {
            return Center(child: Text("No Favourite added yet!"));
          }

          return ListView.builder(
            itemCount: favItems.length,
            itemBuilder: (context, index) {
              final productId = favItems[index];
              final Product product = ProductData()
                  .products
                  .firstWhere((product) => product.id == productId);

              return Container(
                color: const Color.fromARGB(231, 219, 125, 236),
                margin: EdgeInsets.all(10),
                child: ListTile(
                  title: Text(product.title),
                  subtitle: Text("Rs.${product.price}"),
                  trailing: IconButton(
                      onPressed: () {
                        favProovider.toggleFavourites(product.id);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Removed from favourites!!"),
                          duration: Duration(seconds: 1),
                        ));
                      },
                      icon: Icon(Icons.delete)),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
