class Transaction {
  int? billCode;
  int? productId;
  String? productCode;
  double? unitPrice;
  int? quantity;
  DateTime? sellingDate;
  double? totalPrice;
  int? userId;
  int? transactionId;
  String? productName;

  Transaction({
    this.billCode,
    this.productCode,
    this.unitPrice,
    this.quantity,
    this.sellingDate,
    this.totalPrice,
    this.userId,
    this.transactionId,
    this.productName,
    this.productId,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      billCode: json['bill_code'],
      productCode: json['product_code'],
      unitPrice: json['unit_price'],
      quantity: json['quantity'],
      sellingDate: json['selling_date'] != null
          ? DateTime.parse(json['selling_date'])
          : null,
      totalPrice: json['total_price'],
      userId: json['user_id'],
      transactionId: json['TransactionId'],
      productName: json['product_name'],
      productId: json['product_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bill_code': billCode,
      'product_code': productCode,
      'unit_price': unitPrice,
      'quantity': quantity,
      'selling_date': sellingDate?.toIso8601String(),
      'total_price': totalPrice,
      'user_id': userId,
      'TransactionId': transactionId,
      'product_name': productName,
      'product_id': productId,
    };
  }
}
