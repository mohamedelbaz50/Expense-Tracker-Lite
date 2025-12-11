import 'package:awamer_task/data/models/expense_model.dart';
import 'package:awamer_task/data/repositories/expenses_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
part 'add_expenses_state.dart';

class AddExpensesCubit extends Cubit<AddExpensesState> {
  AddExpensesCubit(this._expensesRepository) : super(AddExpensesInitial());
  final ExpensesRepository _expensesRepository;

  Future<void> convertAndAddExpense(Expense expense) async {
    emit(AddExpensesLoading());
    try {
      double? convertedAmount = await _expensesRepository.convertCurrency(
        from: expense.currency,

        amount: expense.amount,
      );

      if (convertedAmount != null) {
        final box = Hive.box<Expense>('expenses');
        final convertedExpense = Expense(
          category: expense.category,
          amount: convertedAmount,
          date: expense.date,
          currency: 'EGP',
        );
        await box.add(convertedExpense);
        if (kDebugMode) {
          print(convertedExpense.amount);
        }
        emit(AddExpensesSuccess());
      } else {
        emit(AddExpensesFailure());
      }
    } catch (e) {
      emit(AddExpensesFailure());
    }
  }
}
