import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tezda_cart/features/product/domain/product_model.dart';
import 'package:tezda_cart/features/product/widgets/product_image_section.dart';
import 'package:tezda_cart/features/product/widgets/product_review_section.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({required this.product, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      appBar: AppBar(
        title: Text(
          'Product Details',
        ),
        backgroundColor: Colors.black,
        foregroundColor: const Color.fromARGB(255, 193, 145, 0),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (product.images != null && product.images!.isNotEmpty) ImageSection(images: product.images!),
            Container(
              color: Colors.white,
              margin: EdgeInsets.only(top: 8),
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.title ?? '', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        '\$${((product.price ?? 0) - ((product.price ?? 0) * (product.discountPercentage ?? 0) / 100)).toStringAsFixed(2)}',
                        style: TextStyle(
                          color: const Color.fromARGB(255, 193, 145, 0),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 16),
                      Text(
                        '\$${(product.price)?.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 14,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      Spacer(),
                      if (product.discountPercentage != null)
                        Text(
                          '${product.discountPercentage}% off',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.red,
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 8),
                  (product.stock ?? 0) > 0
                      ? Text('In-Stock', style: TextStyle(fontSize: 16))
                      : Text('Sold out', style: TextStyle(fontSize: 16)),
                  if (product.rating != null)
                    Row(
                      children: [
                        RatingBarIndicator(
                          rating: product.rating!,
                          itemBuilder: (context, index) => Icon(Icons.star, color: Colors.amber),
                          itemCount: 5,
                          itemSize: 20.0,
                          direction: Axis.horizontal,
                        ),
                        SizedBox(width: 8),
                        Text('${product.rating} (${product.reviews?.length ?? 0} reviews)',
                            style: TextStyle(fontSize: 16)),
                      ],
                    ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              margin: EdgeInsets.only(top: 8),
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('PRODUCT DETAILS', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 16),
                  Text('Description:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text(product.description ?? '', style: TextStyle(fontSize: 16)),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Text('Brand:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          )),
                      SizedBox(
                        width: 8,
                      ),
                      Text(product.brand ?? '',
                          style: TextStyle(
                            fontSize: 16,
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Category:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          )),
                      SizedBox(
                        width: 8,
                      ),
                      Text(product.category ?? '',
                          style: TextStyle(
                            fontSize: 16,
                          )),
                    ],
                  ),
                  SizedBox(height: 8),
                  if (product.dimensions != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Dimensions:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        Text('Width: ${product.dimensions!.width} cm', style: TextStyle(fontSize: 16)),
                        Text('Height: ${product.dimensions!.height} cm', style: TextStyle(fontSize: 16)),
                        Text('Depth: ${product.dimensions!.depth} cm', style: TextStyle(fontSize: 16)),
                      ],
                    ),
                ],
              ),
            ),
            if (product.reviews != null && product.reviews!.isNotEmpty) ReviewSection(reviews: product.reviews!),
          ],
        ),
      ),
    );
  }
}
