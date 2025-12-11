part of 'add_expenses_cubit.dart';

@immutable
sealed class AddExpensesState {}

final class AddExpensesInitial extends AddExpensesState {}

final class AddExpensesLoading extends AddExpensesState {}

final class AddExpensesSuccess extends AddExpensesState {}

final class AddExpensesFailure extends AddExpensesState {}
