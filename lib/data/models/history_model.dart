class HistoryModel {
  String? invoiceNumber;
  String? transactionType;
  String? description;
  int? totalAmount;
  String? createdOn;

  HistoryModel(
      {this.invoiceNumber,
      this.transactionType,
      this.description,
      this.totalAmount,
      this.createdOn});

  HistoryModel.fromJson(Map<String, dynamic> json) {
    invoiceNumber = json['invoice_number'];
    transactionType = json['transaction_type'];
    description = json['description'];
    totalAmount = json['total_amount'];
    createdOn = json['created_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['invoice_number'] = invoiceNumber;
    data['transaction_type'] = transactionType;
    data['description'] = description;
    data['total_amount'] = totalAmount;
    data['created_on'] = createdOn;
    return data;
  }
}
