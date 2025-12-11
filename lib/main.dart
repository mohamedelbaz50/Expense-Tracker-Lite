import 'package:awamer_task/data/models/expense_model.dart';
import 'package:awamer_task/data/repositories/expenses_repository.dart';
import 'package:awamer_task/presentation/controllers/add_expense_cubit/add_expenses_cubit.dart';
import 'package:awamer_task/presentation/controllers/dashboard_cubit.dart/dashboard_cubit.dart';
import 'package:awamer_task/presentation/pages/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(ExpenseAdapter());

  await Hive.openBox<Expense>('expenses');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AddExpensesCubit(ExpensesRepository()),
        ),
        BlocProvider(create: (context) => DashboardCubit()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            theme: ThemeData(useMaterial3: false),
            // ignore: deprecated_member_use
            useInheritedMediaQuery: true,
            debugShowCheckedModeBanner: false,
            builder: (context, child) {
              return child!;
            },
            home: child,
          );
        },
        child: DashboardPage(),
      ),
    );
  }
}
