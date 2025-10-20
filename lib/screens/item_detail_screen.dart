import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import '../models/menu_item.dart';
import '../providers/cart_provider.dart';
import '../utils/constants.dart';
import '../utils/responsive.dart';

class ItemDetailScreen extends StatefulWidget {
  final MenuItem item;

  const ItemDetailScreen({super.key, required this.item});

  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  int _quantity = 1;
  String _selectedSize = 'Medium';
  bool _isFavorite = false;

  final List<String> _sizes = ['Small', 'Medium', 'Large'];

  // Price multipliers for different sizes
  double get _sizeMultiplier {
    switch (_selectedSize) {
      case 'Small':
        return 0.8; // 20% less
      case 'Large':
        return 1.3; // 30% more
      case 'Medium':
      default:
        return 1.0; // Base price
    }
  }

  double get _currentPrice => widget.item.price * _sizeMultiplier;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.light,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          SliverToBoxAdapter(
            child: Column(
              children: [
                _buildItemInfo(),
                _buildSizeSelector(),
                _buildDescription(),
                const SizedBox(height: 100), // Space for bottom bar
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 300,
      pinned: true,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundColor: Colors.white,
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.dark),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(
              icon: Icon(
                _isFavorite ? Icons.favorite : Icons.favorite_border,
                color: _isFavorite ? Colors.red : AppColors.dark,
              ),
              onPressed: () => setState(() => _isFavorite = !_isFavorite),
            ),
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Image.asset(
          widget.item.image,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(
            color: AppColors.lightGrey,
            child: const Icon(Icons.restaurant, size: 100, color: AppColors.grey),
          ),
        ),
      ),
    );
  }

  Widget _buildItemInfo() {
    return Container(
      padding: EdgeInsets.all(Responsive.padding(context, 20)),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  widget.item.name,
                  style: TextStyle(
                    fontSize: Responsive.fontSize(context, 24),
                    fontWeight: FontWeight.bold,
                    color: AppColors.dark,
                  ),
                ),
              ),
              Text(
                '\$${_currentPrice.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: Responsive.fontSize(context, 28),
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          SizedBox(height: Responsive.spacing(context, 12)),
          Row(
            children: [
              RatingBarIndicator(
                rating: widget.item.rating,
                itemBuilder: (context, index) => const Icon(
                  Icons.star,
                  color: AppColors.secondary,
                ),
                itemCount: 5,
                itemSize: 20.0,
              ),
              const SizedBox(width: 8),
              Text(
                '${widget.item.rating}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Responsive.fontSize(context, 16),
                ),
              ),
              const SizedBox(width: 4),
              Text(
                '(${widget.item.reviews} reviews)',
                style: TextStyle(
                  fontSize: Responsive.fontSize(context, 14),
                  color: AppColors.grey,
                ),
              ),
            ],
          ),
          SizedBox(height: Responsive.spacing(context, 16)),
          Row(
            children: [
              if (widget.item.isVeg)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.success.withAlpha(26),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.circle, color: AppColors.success, size: 8),
                      const SizedBox(width: 4),
                      Text(
                        'Vegetarian',
                        style: TextStyle(
                          color: AppColors.success,
                          fontWeight: FontWeight.bold,
                          fontSize: Responsive.fontSize(context, 12),
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.primary.withAlpha(26),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.access_time, color: AppColors.primary, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      '20-30 min',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: Responsive.fontSize(context, 12),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSizeSelector() {
    return Container(
      margin: EdgeInsets.all(Responsive.padding(context, 20)),
      padding: EdgeInsets.all(Responsive.padding(context, 20)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Size',
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 18),
              fontWeight: FontWeight.bold,
              color: AppColors.dark,
            ),
          ),
          SizedBox(height: Responsive.spacing(context, 16)),
          Row(
            children: _sizes.map((size) {
              final isSelected = _selectedSize == size;
              double sizePrice;
              switch (size) {
                case 'Small':
                  sizePrice = widget.item.price * 0.8;
                  break;
                case 'Large':
                  sizePrice = widget.item.price * 1.3;
                  break;
                case 'Medium':
                default:
                  sizePrice = widget.item.price;
              }
              
              return Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _selectedSize = size),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primary : AppColors.light,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Text(
                          size,
                          style: TextStyle(
                            color: isSelected ? Colors.white : AppColors.dark,
                            fontWeight: FontWeight.bold,
                            fontSize: Responsive.fontSize(context, 14),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '\$${sizePrice.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: isSelected ? Colors.white : AppColors.grey,
                            fontSize: Responsive.fontSize(context, 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Responsive.padding(context, 20)),
      padding: EdgeInsets.all(Responsive.padding(context, 20)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Description',
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 18),
              fontWeight: FontWeight.bold,
              color: AppColors.dark,
            ),
          ),
          SizedBox(height: Responsive.spacing(context, 12)),
          Text(
            widget.item.description,
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 14),
              color: AppColors.grey,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    final totalPrice = _currentPrice * _quantity;
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(26),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.light,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      if (_quantity > 1) {
                        setState(() => _quantity--);
                      }
                    },
                  ),
                  Text(
                    '$_quantity',
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 18),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => setState(() => _quantity++),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // Add to cart using provider
                  final cart = context.read<CartProvider>();
                  for (int i = 0; i < _quantity; i++) {
                    cart.addToCart(widget.item);
                  }
                  
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('$_quantity ${widget.item.name} ($_selectedSize) added to cart!'),
                      duration: const Duration(seconds: 2),
                      backgroundColor: AppColors.success,
                    ),
                  );
                  
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.shopping_cart),
                    const SizedBox(width: 8),
                    Text(
                      'Add \$${totalPrice.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: Responsive.fontSize(context, 16),
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
    );
  }
}