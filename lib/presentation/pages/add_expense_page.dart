import 'dart:io';

import 'package:awamer_task/core/colors.dart';
import 'package:awamer_task/data/models/expense_model.dart';
import 'package:awamer_task/helpers/extentions.dart';
import 'package:awamer_task/presentation/controllers/add_expense_cubit/add_expenses_cubit.dart';
import 'package:awamer_task/presentation/controllers/dashboard_cubit.dart/dashboard_cubit.dart';
import 'package:awamer_task/presentation/pages/dashboard_page.dart';
import 'package:awamer_task/presentation/widgets/dashboard/category_avatar.dart';
import 'package:awamer_task/presentation/widgets/shared/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddExpensePage extends StatefulWidget {
  const AddExpensePage({super.key});

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  String selectedCategory = 'Entertainment';
  String selectedCurrency = 'EGP';
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<String> categories = [
    'Entertainment',
    'Groceries',
    'Transport',
    'Shopping',
    'Gas',
    'Rent',
    'News Paper',
  ];
  List<String> currencies = [
    'USD',
    'AFN',
    'ALL',
    'AMD',
    'AUD',
    'CAD',
    'AED',
    'EGP',
  ];
  int selectedIndex = -1;
  File? selectedImage;
  String imagePath = 'Upload Image';
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

  Future<void> pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      // Pick an image.
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      selectedImage = File(image!.path);
      setState(() {
        imagePath = image.path.split('/').last;
      });
    } on Exception {
      // TODO
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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropDownFormFieldWithLabel(
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value!;
                    });
                  },
                  selecteditem: selectedCategory,
                  items: categories,
                  title: 'Category',
                ),
                DropDownFormFieldWithLabel(
                  onChanged: (value) => setState(() {
                    selectedCurrency = value!;
                  }),
                  selecteditem: selectedCurrency,
                  items: currencies,
                  title: 'Currency',
                ),
                Text(
                  "Amount",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 10.h),
                CustomTextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter amount';
                    }
                    return null;
                  },
                  controller: _amountController,
                  hintText: '\$ 50.00',
                  keyboardType: TextInputType.number,
                  obscureText: false,
                ),
                SizedBox(height: 10.h),

                Text(
                  "Date",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
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
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 10.h),
                CustomTextFormField(
                  controller: TextEditingController(),
                  hintText: imagePath,
                  isReadOnly: true,
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  suffixIcon: IconButton(
                    icon: Icon(Icons.camera_alt, color: Colors.black54),
                    onPressed: pickImage,
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  "Categories",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
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
                BlocBuilder<AddExpensesCubit, AddExpensesState>(
                  builder: (context, state) {
                    if (state is AddExpensesLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return GestureDetector(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            BlocProvider.of<AddExpensesCubit>(context)
                                .convertAndAddExpense(
                                  Expense(
                                    category: selectedCategory,
                                    amount: double.parse(
                                      _amountController.text.trim(),
                                    ),
                                    date: _dateController.text.trim(),
                                    currency: selectedCurrency,
                                  ),
                                )
                                .then((_) {
                                  context.read<DashboardCubit>().getExpenses();
                                  context.pushAndRemoveUntil(DashboardPage());
                                });
                          }
                        },
                        child: Container(
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
                      );
                    }
                  },
                ),
              ],
            ),
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
    required this.title,
    this.onChanged,
  });

  final String selecteditem;
  final List<String> items;
  final String title;
  final ValueChanged<String?>? onChanged;

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
            style: TextStyle(fontSize: 16.sp, color: Colors.black87),

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
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
