import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../utils/constants.dart';
import '../utils/responsive.dart';
import '../models/category.dart';
import '../models/menu_item.dart';
import '../widgets/category_chip.dart';
import '../widgets/menu_item_card.dart';
import 'menu_screen.dart';
import 'cart_screen.dart';
import 'profile_screen.dart';
import 'reservation_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  int _selectedCategoryIndex = 0;

  // This is the master list of all items
  final List<MenuItem> _menuItems = [
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
  ];

  // This list will hold the items to be displayed
  late List<MenuItem> _filteredItems;

  final List<Category> _categories = [
    Category(id: '1', name: 'All', icon: '🍽️', itemCount: 45),
    Category(id: '2', name: 'Pizza', icon: '🍕', itemCount: 12),
    Category(id: '3', name: 'Burgers', icon: '🍔', itemCount: 8),
    Category(id: '4', name: 'Pasta', icon: '🍝', itemCount: 10),
    Category(id: '5', name: 'Desserts', icon: '🍰', itemCount: 15),
  ];

  @override
  void initState() {
    super.initState();
    // Initially, show all popular items
    _filteredItems = _menuItems.where((item) => item.isPopular).toList();
  }

  void _filterItems() {
    final selectedCategory = _categories[_selectedCategoryIndex].name;
    setState(() {
      if (selectedCategory == 'All') {
        _filteredItems = _menuItems.where((item) => item.isPopular).toList();
      } else {
        _filteredItems = _menuItems
            .where((item) => item.isPopular && item.category == selectedCategory)
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.light,
      body: _selectedIndex == 0
          ? _buildHomeContent()
          : _selectedIndex == 1
              ? const MenuScreen()
              : _selectedIndex == 2
                  ? const ReservationScreen()
                  : const ProfileScreen(),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildHomeContent() {
    return SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: Responsive.maxWidth(context)),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: _buildHeader()),
              SliverToBoxAdapter(child: _buildSearchBar()),
              SliverToBoxAdapter(child: _buildCategories()),
              SliverToBoxAdapter(child: _buildSectionHeader('Popular Items')),
              if (_filteredItems.isEmpty)
                SliverToBoxAdapter(
                  child: Container(
                    height: 200,
                    alignment: Alignment.center,
                    child: Text(
                      'No items found in this category.',
                      style: TextStyle(color: AppColors.grey, fontSize: 16),
                    ),
                  ),
                )
              else
                SliverPadding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Responsive.padding(context, 16),
                  ),
                  sliver: Responsive.isDesktop(context) || Responsive.isTablet(context)
                      ? SliverGrid(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: Responsive.isDesktop(context) ? 3 : 2,
                            childAspectRatio: 0.75,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (context, index) => MenuItemCard(item: _filteredItems[index]),
                            childCount: _filteredItems.length,
                          ),
                        )
                      : SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) => MenuItemCard(item: _filteredItems[index]),
                            childCount: _filteredItems.length,
                          ),
                        ),
                ),
              SliverToBoxAdapter(child: SizedBox(height: Responsive.spacing(context, 20))),
            ],
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
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello, Guest 👋',
                style: TextStyle(
                  fontSize: Responsive.fontSize(context, 24),
                  fontWeight: FontWeight.bold,
                  color: AppColors.dark,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'What would you like to eat today?',
                style: TextStyle(
                  fontSize: Responsive.fontSize(context, 14),
                  color: AppColors.grey,
                ),
              ),
            ],
          ),
          const Spacer(),
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
              icon: const Icon(Icons.shopping_cart_outlined, size: 28),
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

  Widget _buildCategories() {
    return Container(
      height: Responsive.responsive(context, mobile: 120, tablet: 140, desktop: 160),
      margin: EdgeInsets.symmetric(vertical: Responsive.spacing(context, 16)),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: Responsive.padding(context, 16)),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedCategoryIndex = index;
              });
              _filterItems(); // Call the filtering logic
            },
            child: CategoryChipWidget(
              category: _categories[index],
              isSelected: _selectedCategoryIndex == index,
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.padding(context, 16),
        vertical: Responsive.spacing(context, 8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 20),
              fontWeight: FontWeight.bold,
              color: AppColors.dark,
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() => _selectedIndex = 1);
            },
            child: Text(
              'See all',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: Responsive.fontSize(context, 14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(26),
            blurRadius: 10,
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.padding(context, 16),
            vertical: Responsive.spacing(context, 8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home, 'Home', 0),
              _buildNavItem(Icons.restaurant_menu, 'Menu', 1),
              _buildNavItem(Icons.book_online, 'Reserve', 2),
              _buildNavItem(Icons.person, 'Profile', 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = _selectedIndex == index;
    return InkWell(
      onTap: () => setState(() => _selectedIndex = index),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.padding(context, 16),
          vertical: Responsive.spacing(context, 8),
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withAlpha(26) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.primary : AppColors.grey,
              size: Responsive.responsive(context, mobile: 24, tablet: 28, desktop: 32),
            ),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? AppColors.primary : AppColors.grey,
                fontSize: Responsive.fontSize(context, 12),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}