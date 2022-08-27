class CreditModel {
  final String cardNumber;
  final String cvv;
  final String month;
  final String year;
  final String cardHolderName;

  CreditModel({
    required this.cardNumber,
    required this.cvv,
    required this.month,
    required this.year,
    required this.cardHolderName,
  });
}
