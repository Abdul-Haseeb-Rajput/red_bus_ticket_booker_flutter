class BookingService {
  String id;
  String userId;
  String busId;
  String ticketId;
  DateTime bookingDate;

  BookingService({
    required this.id,
    required this.userId,
    required this.busId,
    required this.ticketId,
    required this.bookingDate,
  });

  factory BookingService.fromMap(Map<String, dynamic> data) {
    return BookingService(
      id: data['id'],
      userId: data['userId'],
      busId: data['busId'],
      ticketId: data['ticketId'],
      bookingDate: data['bookingDate'].toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'busId': busId,
      'ticketId': ticketId,
      'bookingDate': bookingDate,
    };
  }
}
