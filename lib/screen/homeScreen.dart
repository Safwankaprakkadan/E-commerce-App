import 'dart:convert';

import 'package:e_commerce_app/screen/loginScreen.dart';
import 'package:e_commerce_app/screen/model.dart';
import 'package:e_commerce_app/screen/product_details.dart';
import 'package:e_commerce_app/screen/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeDashboard extends StatefulWidget {
  const HomeDashboard({super.key});

  @override
  State<HomeDashboard> createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard> {
  TextEditingController searchController = TextEditingController();
  List<Product> filteredProducts = [];
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final productProvider =
          Provider.of<ProductCategoryProvider>(context, listen: false);
      productProvider.fetchProductsAndCategories().then((_) {
        setState(() {
          filteredProducts = productProvider.products;
        });
      });
    });
    searchController.addListener(() {
      filterProducts();
    });
  }

  void filterProducts() {
    final productCategory =
        Provider.of<ProductCategoryProvider>(context, listen: false);
    setState(() {
      filteredProducts = productCategory.products
          .where((product) => product.partsname!
              .toLowerCase()
              .contains(searchController.text.toLowerCase()))
          .toList();
    });
  }

  void _logout(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text('Log out'),
            content: Text('Are you sure want to logout'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel')),
              TextButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                        ModalRoute.withName("/Login"));
                  },
                  child: Text('Ok')),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final productCategory = Provider.of<ProductCategoryProvider>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
            child: Text(
          'Spare List',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        )),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              _logout(context);
            },
          ),
        ],
      ),
      body: productCategory.isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'Search by parts name',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 60,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: productCategory.categories.length,
                    itemBuilder: (context, index) {
                      Category category = productCategory.categories[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Chip(
                          label: Text(category.cat_name!),
                        ),
                      );
                    },
                  ),
                ),
                Divider(),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8.0,
                      crossAxisSpacing: 8.0,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
                      int rating =
                          double.tryParse(product.productrating ?? '0.0')
                                  ?.round()
                                  .clamp(0, 5) ??
                              0;

                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 4,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ProductDetailsScreen(product: product),
                              ),
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AspectRatio(
                                aspectRatio: 1.2,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(12)),
                                  child: Image.network(
                                    product.partimage ?? '',
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.partsname!,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Row(
                                      children: List.generate(
                                        5,
                                        (index) => Icon(
                                          Icons.star,
                                          color: index < rating
                                              ? Colors.amber
                                              : Colors.grey,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      '\$: ${product.price}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
