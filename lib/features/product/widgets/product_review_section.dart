import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tezda_cart/features/product/domain/product_model.dart';

class ReviewSection extends StatelessWidget {
  final List<Review> reviews;

  const ReviewSection({required this.reviews, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Product Reviews', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ...reviews.map(
            (review) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(review.reviewerName ?? 'Anonymous', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                  SizedBox(height: 4),
                  Text(review.comment ?? '', style: TextStyle(fontSize: 14)),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      RatingBarIndicator(
                        rating: review.rating?.toDouble() ?? 0.0,
                        itemBuilder: (context, index) => Icon(Icons.star, color: Colors.amber),
                        itemCount: 5,
                        itemSize: 16.0,
                        direction: Axis.horizontal,
                      ),
                      Spacer(),
                      Text(' ${review.date?.toLocal().toString().split(' ')[0]}',
                          style: TextStyle(fontSize: 14, color: Colors.grey)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
