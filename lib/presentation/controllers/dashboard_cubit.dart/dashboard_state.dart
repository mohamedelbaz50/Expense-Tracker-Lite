part of 'dashboard_cubit.dart';

@immutable
sealed class DashboardState {}

final class DashboardInitial extends DashboardState {}

final class GetExpensesLoading extends DashboardState {}

final class GetExpensesSuccess extends DashboardState {
  final List<Expense> expenses;

  GetExpensesSuccess({required this.expenses});
}

final class GetExpensesFailure extends DashboardState {}
