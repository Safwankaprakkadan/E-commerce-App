import 'package:e_commerce_app/screen/model.dart';
import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;
  const ProductDetailsScreen({super.key,  required this.product});

  @override
  Widget build(BuildContext context) {
    int rating = double.tryParse(product.productrating ?? '0.0')?.round().clamp(0, 5) ?? 0;
    return Scaffold(
      appBar: AppBar(
        title: Text(product.partsname!),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Container(
             padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(product.partsname!, style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                Center(child: Image.network(product.partimage ?? '', height: 350)),
                SizedBox(height: 16),
                Text(product.description! , style: TextStyle(fontSize: 18)),
                SizedBox(height: 16),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    5,
                    (index) => Icon(
                        Icons.star,
                      color: index < rating ? Colors.amber : Colors.grey,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Text('Price: \$ ${product.price}', style: TextStyle(fontSize: 18)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}