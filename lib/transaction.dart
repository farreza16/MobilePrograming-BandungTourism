// transaction.dart


class Transaction {
  final String destinationTitle;
  final String destinationAddress;
  final String ticketPrice;
  final DateTime selectedDate;
  final int ticketCount;
  final String customerName;
  final int totalPrice;

  Transaction({
    required this.destinationTitle,
    required this.destinationAddress,
    required this.ticketPrice,
    required this.selectedDate,
    required this.ticketCount,
    required this.customerName,
  }) : totalPrice = _calculateTotalPrice(ticketPrice, ticketCount);

  static int _calculateTotalPrice(String ticketPrice, int ticketCount) {
    int price = int.parse(ticketPrice.replaceAll('Rp ', '').replaceAll('.', ''));
    return price * ticketCount;
  }
}
