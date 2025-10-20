import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import '../models/menu_item.dart';
import '../providers/cart_provider.dart';
import '../utils/constants.dart';
import '../utils/responsive.dart';
import '../screens/item_detail_screen.dart';

class MenuItemCard extends StatelessWidget {
  final MenuItem item;

  const MenuItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ItemDetailScreen(item: item),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.only(bottom: Responsive.spacing(context, 16)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 4,
        shadowColor: Colors.black.withAlpha(30),
        clipBehavior: Clip.antiAlias, // This is important for the image border radius
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(
                  item.image,
                  height: Responsive.responsive(context, mobile: 200, tablet: 220, desktop: 250),
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: Responsive.responsive(context, mobile: 200, tablet: 220, desktop: 250),
                    color: AppColors.lightGrey,
                    child: Icon(Icons.restaurant, size: 60, color: AppColors.grey),
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(26),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.favorite_border,
                      color: AppColors.primary,
                      size: 20,
                    ),
                  ),
                ),
                if (item.isVeg)
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.success,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.circle, color: Colors.white, size: 8),
                          const SizedBox(width: 4),
                          Text(
                            'VEG',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: Responsive.fontSize(context, 10),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                if (item.isPopular)
                  Positioned(
                    bottom: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.local_fire_department, color: Colors.white, size: 14),
                          const SizedBox(width: 4),
                          Text(
                            'Popular',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: Responsive.fontSize(context, 11),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
            // The Expanded widget was causing issues in some layouts, so we manage space with Padding.
            Padding(
              padding: EdgeInsets.all(Responsive.padding(context, 16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          item.name,
                          style: TextStyle(
                            fontSize: Responsive.fontSize(context, 18),
                            fontWeight: FontWeight.bold,
                            color: AppColors.dark,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '\$${item.price.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: Responsive.fontSize(context, 20),
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Responsive.spacing(context, 8)),
                  Text(
                    item.description,
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 13),
                      color: AppColors.grey,
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: Responsive.spacing(context, 12)),
                  Row(
                    children: [
                      RatingBarIndicator(
                        rating: item.rating,
                        itemBuilder: (context, index) => const Icon(
                          Icons.star,
                          color: AppColors.secondary,
                        ),
                        itemCount: 5,
                        itemSize: 16.0,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${item.rating}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Responsive.fontSize(context, 14),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '(${item.reviews} reviews)',
                        style: TextStyle(
                          fontSize: Responsive.fontSize(context, 12),
                          color: AppColors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Responsive.spacing(context, 16)),
                  SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<CartProvider>().addToCart(item);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${item.name} added to cart!'),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.add_shopping_cart, size: 18),
                          const SizedBox(width: 8),
                          Text(
                            'Add to Cart',
                            style: TextStyle(
                              fontSize: Responsive.fontSize(context, 14),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}