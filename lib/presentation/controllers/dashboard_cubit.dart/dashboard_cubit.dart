import 'package:awamer_task/data/models/expense_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(DashboardInitial());
  final box = Hive.box<Expense>('expenses');
  final int limit = 20;
  int page = 0;
  bool hasMore = true;
  bool isLoadingMore = false;
  List<Expense> allExpenses = [];

  void getExpenses({bool loadMore = false}) {
    if (!loadMore) {
      emit(GetExpensesLoading());
      page = 0;
      allExpenses.clear();
      hasMore = true;
    }

    if (!hasMore || isLoadingMore) return;

    isLoadingMore = true; // prevent duplicate calls

    try {
      final keys = box.keys.cast<int>().toList()..sort();
      final start = page * limit;
      if (start >= keys.length) {
        hasMore = false;
        isLoadingMore = false;
        emit(GetExpensesSuccess(expenses: allExpenses));
        return;
      }

      final end = start + limit;
      final selectedKeys = keys.sublist(
        start,
        end > keys.length ? keys.length : end,
      );
      final newExpenses = selectedKeys.map((k) => box.get(k)!).toList();

      allExpenses.addAll(newExpenses);
      page++;
      isLoadingMore = false;
      getTotalExpensesAmount();
      emit(GetExpensesSuccess(expenses: allExpenses));
    } catch (e) {
      isLoadingMore = false;
      emit(GetExpensesFailure());
      if (kDebugMode) print('Error fetching expenses: $e');
    }
  }

  double expensesTotal = 0.0;
  void getTotalExpensesAmount() {
    expensesTotal = box.values.fold(
      0.0,
      (sum, expense) => sum + expense.amount,
    );
  }
}
