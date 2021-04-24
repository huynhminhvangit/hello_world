class Transaction {
  String content;
  double amount;
  DateTime createdAt;

  Transaction(
      {required this.content, required this.amount, required this.createdAt});
}
