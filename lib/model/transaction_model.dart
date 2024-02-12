class TransactionModel {
  final int? id;
  final String name;
  final String mobileNumber;
  final String service;
  final double totalPaidAmount;
  final double partiallyPaidAmount;
  final String photo;

  TransactionModel({
    this.id,
    required this.name,
    required this.mobileNumber,
    required this.service,
    required this.totalPaidAmount,
    required this.partiallyPaidAmount,
    required this.photo,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'mobileNumber': mobileNumber,
      'service': service,
      'totalPaidAmount': totalPaidAmount,
      'partiallyPaidAmount': partiallyPaidAmount,
      'photo': photo,
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'],
      name: map['name'],
      mobileNumber: map['mobileNumber'],
      service: map['service'],
      totalPaidAmount: map['totalPaidAmount'],
      partiallyPaidAmount: map['partiallyPaidAmount'],
      photo: map['photo'],
    );
  }
}
