import 'package:hive/hive.dart';

part 'expense_model.g.dart';

@HiveType(typeId: 0)
class Expense {
  @HiveField(0)
  String category;

  @HiveField(1)
  double amount;

  @HiveField(2)
  String date;
  @HiveField(3)
  String currency;

  Expense({
    required this.category,
    required this.amount,
    required this.date,
    required this.currency,
  });
}
