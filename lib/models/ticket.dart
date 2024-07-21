class Ticket {
  String id;
  String busId;
  String qrCode;
  DateTime purchaseDate;
  DateTime expiryDate;
  int scanCount;
  bool isExpired;
  String? busRoute;

  Ticket({
    required this.id,
    required this.busId,
    required this.qrCode,
    required this.purchaseDate,
    required this.expiryDate,
    required this.scanCount,
    required this.isExpired,
    this.busRoute,
  });

  factory Ticket.fromMap(Map<String, dynamic> data) {
    return Ticket(
      id: data['id'],
      busId: data['busId'],
      qrCode: data['qrCode'],
      purchaseDate: data['purchaseDate'].toDate(),
      expiryDate: data['expiryDate'].toDate(),
      scanCount: data['scanCount'],
      isExpired: data['isExpired'],
      busRoute: data['busRoute'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'busId': busId,
      'qrCode': qrCode,
      'purchaseDate': purchaseDate,
      'expiryDate': expiryDate,
      'scanCount': scanCount,
      'isExpired': isExpired,
      'busRoute': busRoute,
    };
  }

  void calculateExpiryDate() {
    expiryDate = purchaseDate.add(const Duration(hours: 24));
  }
}
