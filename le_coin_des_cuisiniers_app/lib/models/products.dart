class Product {
  String? productCode;
  String? productName;
  String? brand;
  double? purchasePrice;
  double? otherExpenses;
  double? sellingPrice;
  int? purchasedQuantity;
  DateTime? purchasedDate;
  int? remainingQuantity;
  int? id;

  Product({
    this.productCode,
    this.productName,
    this.purchasePrice,
    this.otherExpenses,
    this.purchasedQuantity,
    this.purchasedDate,
    this.sellingPrice,
    this.brand,
    this.remainingQuantity,
    this.id,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productCode: json['product_code'],
      productName: json['product_name'],
      brand: json['brand'],
      purchasePrice: (json['purchase_price'] is int)
          ? (json['purchase_price'] as int).toDouble()
          : json['purchase_price'],
      purchasedQuantity: json['purchased_quantity'],
      purchasedDate: json['purchased_date'] != null
          ? DateTime.parse(json['purchased_date'])
          : null,
      sellingPrice: (json['selling_price'] is int)
          ? (json['selling_price'] as int).toDouble()
          : json['selling_price'],
      remainingQuantity: json['remaining_quantity'],
      otherExpenses: (json['other_expenses'] is int)
          ? (json['other_expenses'] as int).toDouble()
          : json['other_expenses'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_code': productCode,
      'product_name': productName,
      'purchase_price': purchasePrice,
      'purchased_quantity': purchasedQuantity,
      'purchased_date': purchasedDate?.toIso8601String(),
      'selling_price': sellingPrice,
      'brand': brand,
      'remaining_quantity': remainingQuantity,
      'other_expenses': otherExpenses,
      'id': id,
    };
  }

  @override
  String toString() {
    return 'Product(productCode: $productCode, productName: $productName, purchasePrice: $purchasePrice, sellingPrice: $sellingPrice, purchasedQuantity: $purchasedQuantity, purchasedDate: $purchasedDate, remainingQuantity: $remainingQuantity,brand: $brand, other_expenses: $otherExpenses, id:$id)';
  }
}
