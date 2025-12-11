import 'package:awamer_task/core/colors.dart';
import 'package:awamer_task/presentation/widgets/dashboard/category_avatar.dart';
import 'package:awamer_task/presentation/widgets/shared/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class AddExpensePage extends StatefulWidget {
  const AddExpensePage({super.key});

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  String selectedCategory = 'Entertainment';
  final TextEditingController _dateController = TextEditingController();
  List<String> categories = [
    'Entertainment',
    'Groceries',
    'Transport',
    'Shopping',
    'Gas',
    'Rent',
    'News Paper',
  ];
  int selectedIndex = -1;
  @override
  void initState() {
    super.initState();

    // Set today's date as default
    _dateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
  }

  Future<void> _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      String formatted = DateFormat('dd/MM/yyyy').format(picked);
      setState(() {
        _dateController.text = formatted;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text('Add Expense'),
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropDownFormFieldWithLabel(
                selecteditem: selectedCategory,
                items: categories,
              ),
              Text(
                "Amount",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 10.h),
              CustomTextFormField(
                controller: TextEditingController(),
                hintText: '\$ 50.00',
                keyboardType: TextInputType.number,
                obscureText: false,
              ),
              SizedBox(height: 10.h),

              Text(
                "Date",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 10.h),
              CustomTextFormField(
                hintText: '02/01/2025',
                controller: _dateController,
                keyboardType: TextInputType.datetime,
                obscureText: false,
                isReadOnly: true,
                onTap: _pickDate,
                suffixIcon: IconButton(
                  icon: Icon(Icons.calendar_month, color: Colors.black54),
                  onPressed: _pickDate,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                "Atteach Receipt",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 10.h),
              CustomTextFormField(
                controller: TextEditingController(),
                hintText: 'Entertainment',
                keyboardType: TextInputType.text,
                obscureText: false,
              ),
              SizedBox(height: 20.h),
              Text(
                "Categories",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 20.h),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 1,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  String title = categories[index];

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: CategoryItem(
                      title: title,

                      isSelected: selectedIndex == index,
                    ),
                  );
                },
              ),
              Container(
                width: double.infinity,
                height: 40.h,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Center(
                  child: Text(
                    "Save",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, required this.title, this.isSelected = false});

  final String title;
  final bool? isSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CategoryAvatar(category: title, isSelected: isSelected!),
        SizedBox(height: 5.h),
        Text(
          title,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: isSelected! ? AppColors.primaryColor : Colors.black87,
          ),
        ),
      ],
    );
  }
}

class DropDownFormFieldWithLabel extends StatelessWidget {
  const DropDownFormFieldWithLabel({
    super.key,
    required this.selecteditem,
    required this.items,
  });

  final String selecteditem;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Categories",
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 10.h),
          DropdownButtonFormField<String>(
            style: TextStyle(fontSize: 16.sp, color: Colors.grey),

            icon: Icon(
              Icons.keyboard_arrow_down,
              size: 24.sp,
              color: Colors.grey,
            ),
            decoration: InputDecoration(
              hintText: selecteditem,
              contentPadding: EdgeInsets.symmetric(
                vertical: 12.h,
                horizontal: 12.w,
              ),
              hintStyle: TextStyle(fontSize: 16.sp, color: Colors.black87),
              fillColor: Colors.grey[100],
              filled: true,

              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(width: 0, color: Colors.transparent),
              ),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(width: 0, color: Colors.transparent),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(width: 0, color: Colors.transparent),
              ),
            ),
            value: selecteditem,
            items: items
                .map((item) => DropdownMenuItem(value: item, child: Text(item)))
                .toList(),
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }
}
