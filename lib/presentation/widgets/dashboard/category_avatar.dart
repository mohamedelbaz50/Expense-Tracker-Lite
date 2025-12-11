import 'package:awamer_task/core/colors.dart';
import 'package:awamer_task/helpers/helpers_fun.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryAvatar extends StatelessWidget {
  final String category;
  final bool isSelected;
  const CategoryAvatar({
    super.key,
    required this.category,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: isSelected ? AppColors.primaryColor : Colors.grey[200],
      radius: 20.r,
      child: Icon(
        HelpersFun().getCategoryIcon(category),
        size: 25.sp,
        color: isSelected
            ? Colors.white
            : HelpersFun().getCategoryColor(category),
      ),
    );
  }
}
