import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../utils/constants.dart';
import '../utils/responsive.dart';
import 'home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingPage> _pages = [
    OnboardingPage(
      icon: Icons.restaurant,
      title: 'Discover Best Foods',
      description: 'Explore a wide variety of delicious dishes from our extensive menu',
    ),
    OnboardingPage(
      icon: Icons.delivery_dining,
      title: 'Fast Delivery',
      description: 'Get your favorite meals delivered to your doorstep quickly',
    ),
    OnboardingPage(
      icon: Icons.payment,
      title: 'Easy Payment',
      description: 'Multiple payment options for your convenience',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: Responsive.maxWidth(context)),
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) => setState(() => _currentPage = index),
                    itemCount: _pages.length,
                    itemBuilder: (context, index) => _buildPage(_pages[index]),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(Responsive.padding(context, 24)),
                  child: Column(
                    children: [
                      SmoothPageIndicator(
                        controller: _pageController,
                        count: _pages.length,
                        effect: ExpandingDotsEffect(
                          activeDotColor: AppColors.primary,
                          dotColor: AppColors.lightGrey,
                          dotHeight: 12,
                          dotWidth: 12,
                        ),
                      ),
                      SizedBox(height: Responsive.spacing(context, 32)),
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_currentPage == _pages.length - 1) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const HomeScreen()),
                              );
                            } else {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeIn,
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            _currentPage == _pages.length - 1 ? 'Get Started' : 'Next',
                            style: TextStyle(
                              fontSize: Responsive.fontSize(context, 18),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPage(OnboardingPage page) {
    return Padding(
      padding: EdgeInsets.all(Responsive.padding(context, 40)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(Responsive.padding(context, 32)),
            decoration: BoxDecoration(
              color: AppColors.primary.withAlpha(26),
              shape: BoxShape.circle,
            ),
            child: Icon(
              page.icon,
              size: Responsive.responsive(
                context,
                mobile: 120,
                tablet: 150,
                desktop: 180,
              ),
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: Responsive.spacing(context, 48)),
          Text(
            page.title,
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 28),
              fontWeight: FontWeight.bold,
              color: AppColors.dark,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: Responsive.spacing(context, 16)),
          Text(
            page.description,
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 16),
              color: AppColors.grey,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class OnboardingPage {
  final IconData icon;
  final String title;
  final String description;

  OnboardingPage({
    required this.icon,
    required this.title,
    required this.description,
  });
}