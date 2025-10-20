import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';
import '../models/menu_item.dart';
import '../providers/cart_provider.dart';
import '../utils/constants.dart';
import '../utils/responsive.dart';
import '../widgets/menu_item_card.dart';
import 'cart_screen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  String _selectedCategory = 'All';

  final List<MenuItem> _allMenuItems = [
    MenuItem(
      id: '1',
      name: 'Margherita Pizza',
      description: 'Classic tomato sauce, mozzarella, and fresh basil',
      price: 12.99,
      image: 'assets/images/margherita_pizza.jpg',
      category: 'Pizza',
      rating: 4.5,
      reviews: 120,
      isVeg: true,
      isPopular: true,
      tags: ['Popular', 'Italian'],
    ),
    MenuItem(
      id: '2',
      name: 'Beef Burger',
      description: 'Juicy beef patty with cheese, lettuce, and special sauce',
      price: 9.99,
      image: 'assets/images/beef_burger.jpg',
      category: 'Burgers',
      rating: 4.8,
      reviews: 95,
      isPopular: true,
      tags: ['Bestseller'],
    ),
    MenuItem(
      id: '3',
      name: 'Carbonara Pasta',
      description: 'Creamy pasta with pancetta and parmesan cheese',
      price: 14.50,
      image: 'assets/images/carbonara_pasta.jpg',
      category: 'Pasta',
      rating: 4.7,
      reviews: 88,
      isPopular: true,
      tags: ['Popular', 'Classic'],
    ),
    MenuItem(
      id: '4',
      name: 'Pepperoni Pizza',
      description: 'Spicy pepperoni with mozzarella and rich tomato sauce',
      price: 15.99,
      image: 'assets/images/pepperoni_pizza.jpg',
      category: 'Pizza',
      rating: 4.6,
      reviews: 150,
      isPopular: true,
      tags: ['Popular', 'Spicy'],
    ),
    MenuItem(
      id: '5',
      name: 'Caesar Salad',
      description: 'Fresh romaine lettuce with parmesan and caesar dressing',
      price: 8.99,
      image: 'assets/images/margherita_pizza.jpg', // Reusing image for demo
      category: 'Salads',
      rating: 4.3,
      reviews: 67,
      isVeg: true,
      tags: ['Healthy', 'Fresh'],
    ),
    MenuItem(
      id: '6',
      name: 'Chicken Burger',
      description: 'Grilled chicken with lettuce and mayo',
      price: 10.99,
      image: 'assets/images/beef_burger.jpg', // Reusing image for demo
      category: 'Burgers',
      rating: 4.5,
      reviews: 82,
      tags: ['Grilled'],
    ),
    MenuItem(
      id: '7',
      name: 'Penne Arrabbiata',
      description: 'Spicy tomato sauce with penne pasta',
      price: 13.50,
      image: 'assets/images/carbonara_pasta.jpg', // Reusing image for demo
      category: 'Pasta',
      rating: 4.4,
      reviews: 71,
      isVeg: true,
      tags: ['Spicy', 'Italian'],
    ),
    MenuItem(
      id: '8',
      name: 'Hawaiian Pizza',
      description: 'Ham, pineapple, and mozzarella cheese',
      price: 14.99,
      image: 'assets/images/pepperoni_pizza.jpg', // Reusing image for demo
      category: 'Pizza',
      rating: 4.2,
      reviews: 93,
      tags: ['Sweet & Savory'],
    ),
  ];

  List<MenuItem> get _filteredItems {
    if (_selectedCategory == 'All') {
      return _allMenuItems;
    }
    return _allMenuItems.where((item) => item.category == _selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.light,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: Responsive.maxWidth(context)),
            child: Column(
              children: [
                _buildHeader(),
                _buildSearchBar(),
                _buildCategoryTabs(),
                Expanded(child: _buildMenuGrid()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final cartItemCount = context.watch<CartProvider>().totalItemCount;

    return Padding(
      padding: EdgeInsets.all(Responsive.padding(context, 16)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Our Menu',
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 28),
              fontWeight: FontWeight.bold,
              color: AppColors.dark,
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.search, size: 28, color: AppColors.dark),
                onPressed: () {},
              ),
              badges.Badge(
                showBadge: cartItemCount > 0,
                badgeContent: Text(
                  '$cartItemCount',
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                ),
                badgeStyle: badges.BadgeStyle(
                  badgeColor: AppColors.primary,
                ),
                child: IconButton(
                  icon: Icon(Icons.shopping_cart_outlined, size: 28, color: AppColors.dark),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CartScreen()),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.padding(context, 16),
        vertical: Responsive.spacing(context, 8),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: Responsive.padding(context, 16)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(13),
              blurRadius: 10,
            ),
          ],
        ),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search for food...',
            hintStyle: TextStyle(fontSize: Responsive.fontSize(context, 14)),
            border: InputBorder.none,
            icon: Icon(Icons.search, color: AppColors.grey),
            suffixIcon: Icon(Icons.tune, color: AppColors.primary),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryTabs() {
    final categories = ['All', 'Pizza', 'Burgers', 'Pasta', 'Salads', 'Desserts', 'Drinks'];
    
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(vertical: Responsive.spacing(context, 16)),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: Responsive.padding(context, 16)),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = _selectedCategory == category;
          return GestureDetector(
            onTap: () => setState(() => _selectedCategory = category),
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  if (!isSelected)
                    BoxShadow(
                      color: Colors.black.withAlpha(13),
                      blurRadius: 8,
                    ),
                ],
              ),
              child: Center(
                child: Text(
                  category,
                  style: TextStyle(
                    color: isSelected ? Colors.white : AppColors.dark,
                    fontWeight: FontWeight.bold,
                    fontSize: Responsive.fontSize(context, 14),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMenuGrid() {
    return Responsive.isDesktop(context) || Responsive.isTablet(context)
        ? GridView.builder(
            padding: EdgeInsets.symmetric(horizontal: Responsive.padding(context, 16)),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: Responsive.isDesktop(context) ? 3 : 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: _filteredItems.length,
            itemBuilder: (context, index) => MenuItemCard(item: _filteredItems[index]),
          )
        : ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: Responsive.padding(context, 16)),
            itemCount: _filteredItems.length,
            itemBuilder: (context, index) => MenuItemCard(item: _filteredItems[index]),
          );
  }
}