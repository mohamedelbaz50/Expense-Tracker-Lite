import 'package:awamer_task/core/colors.dart';
import 'package:awamer_task/helpers/extentions.dart';
import 'package:awamer_task/presentation/controllers/dashboard_cubit.dart/dashboard_cubit.dart';
import 'package:awamer_task/presentation/pages/add_expense_page.dart';
import 'package:awamer_task/presentation/widgets/dashboard/expenses_item.dart';
import 'package:awamer_task/presentation/widgets/dashboard/income_and_expenses_value_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<String> items = ['This Month', 'Last 7 Days', 'Last Month'];

  String selectedItem = 'This Month';
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    context.read<DashboardCubit>().getExpenses();
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        context.read<DashboardCubit>().getExpenses(loadMore: true);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<DashboardCubit, DashboardState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            body: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.sizeOf(context).height / 2.5,
                  child: Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 20.h,
                        ),
                        width: double.infinity,
                        height: MediaQuery.sizeOf(context).height / 3.5,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15.r),
                            bottomRight: Radius.circular(15.r),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 25.r,
                              backgroundImage: NetworkImage(
                                "https://img.freepik.com/free-photo/people-smiling-men-handsome-cheerful_1187-6057.jpg",
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Good Morning",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                Text(
                                  "Shihab Rahman ",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.r),
                                color: Colors.white,
                              ),
                              child: Row(
                                children: [
                                  DropdownButton(
                                    value: selectedItem,
                                    underline: SizedBox(),
                                    elevation: 0,
                                    icon: Icon(
                                      Icons.keyboard_arrow_down_outlined,
                                      size: 20.sp,
                                      color: Colors.black,
                                    ),
                                    style: TextStyle(
                                      color: Colors.black,

                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    items: items
                                        .map(
                                          (e) => DropdownMenuItem(
                                            value: e,
                                            child: Text(e),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedItem = value!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        // This controls how much the card overlaps the blue header
                        left: 20,
                        right: 20,
                        bottom: 40.h,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 20.h,
                            horizontal: 20.w,
                          ),
                          width: double.infinity,
                          height: MediaQuery.sizeOf(context).height / 4.5,
                          decoration: BoxDecoration(
                            color: AppColors.secondaryColor,
                            boxShadow: [
                              BoxShadow(
                                // ignore: deprecated_member_use
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: Offset(
                                  0,
                                  4,
                                ), // changes position of shadow
                              ),
                            ],
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Total Balance",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "\$ 2,548.00",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28.sp,
                                  fontWeight: FontWeight.w700,
                                  height: 2,
                                ),
                              ),
                              Spacer(),
                              Row(
                                children: [
                                  IncomeAndExpensesValueWidget(
                                    title: "Income",
                                    amount: "\$ 10,840.00",
                                    icon: Icons.arrow_downward,
                                  ),
                                  Spacer(),
                                  IncomeAndExpensesValueWidget(
                                    title: "Expenses",
                                    amount:
                                        "\$ ${context.read<DashboardCubit>().expensesTotal.toStringAsFixed(2)}",
                                    icon: Icons.arrow_upward,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Recent Expenses",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "See All",
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: BlocBuilder<DashboardCubit, DashboardState>(
                    builder: (context, state) {
                      if (state is GetExpensesLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is GetExpensesFailure) {
                        return Center(child: Text('Failed to load expenses'));
                      } else if (state is GetExpensesSuccess) {
                        final expenses = state.expenses;

                        return ListView.builder(
                          physics: BouncingScrollPhysics(),
                          controller: _scrollController,
                          itemCount: expenses.length + 1,
                          itemBuilder: (context, index) {
                            if (index < expenses.length) {
                              final expense = expenses[index];
                              return ExpensesItem(
                                expense: expense,
                                category: expense.category,
                              );
                            }
                            return null;
                          },
                        );
                      }
                      return SizedBox();
                    },
                  ),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: AppColors.primaryColor,
              onPressed: () {
                context.push(AddExpensePage());
              },
              child: Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }
}
