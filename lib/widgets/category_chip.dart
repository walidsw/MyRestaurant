import 'package:flutter/material.dart';
import '../models/category.dart';
import '../utils/constants.dart';
import '../utils/responsive.dart';

class CategoryChipWidget extends StatelessWidget {
  final Category category;
  final bool isSelected;

  const CategoryChipWidget({
    super.key,
    required this.category,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Responsive.responsive(context, mobile: 90, tablet: 100, desktop: 110),
      margin: EdgeInsets.only(right: Responsive.spacing(context, 12)),
      padding: EdgeInsets.symmetric(
        vertical: Responsive.padding(context, 12),
        horizontal: Responsive.padding(context, 8),
      ),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          if (!isSelected)
            BoxShadow(
              color: Colors.black.withAlpha(15),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // This centers the content vertically
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            category.icon,
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 28),
            ),
          ),
          const Spacer(), // Use Spacer to push items apart flexibly
          Text(
            category.name,
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 14),
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : AppColors.dark,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: Responsive.spacing(context, 4)),
          Text(
            '${category.itemCount} items',
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 10),
              color: isSelected ? Colors.white70 : AppColors.grey,
            ),
          ),
        ],
      ),
    );
  }
}