import 'package:bus_ticket_booker_flutter/models/booking_servide.dart';
import 'package:bus_ticket_booker_flutter/models/bus_model.dart';
import 'package:bus_ticket_booker_flutter/models/ticket.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class BusDetailsController extends GetxController {
  // final Bus bus = Get.arguments as Bus;

  final firestore = FirebaseFirestore.instance;
  Rx<Bus> bus = Bus(
          id: '',
          routeName: '',
          startTime: '',
          endTime: '',
          routes: [],
          price: 0.0)
      .obs;
  var ticket = Rx<Ticket?>(null);

  @override
  void onInit() {
    super.onInit();
    bus.value = Get.arguments as Bus;
  }

  Future<void> generateTicket() async {
    String routeName = bus.value.routeName;
    String qrCode = '';
    DateTime purchaseDate = DateTime.now();
    DateTime expiryDate = purchaseDate.add(const Duration(hours: 24));
    int scanCount = 0;
    bool isExpired = false;
    String ticketId = firestore.collection('tickets').doc().id;

    try {
      await firestore.runTransaction((transaction) async {
        DocumentReference routeRef =
            firestore.collection('routes').doc(routeName);
        DocumentSnapshot snapshot = await transaction.get(routeRef);

        if (!snapshot.exists) {
          transaction.set(routeRef, {'lastNumber': 1});
          qrCode = '$routeName-01';
        } else {
          int lastNumber = snapshot['lastNumber'];
          int newNumber = lastNumber + 1;
          transaction.update(routeRef, {'lastNumber': newNumber});
          qrCode = '$routeName-${newNumber.toString().padLeft(2, '0')}';
        }
      });
    } catch (error) {
      print("Failed to generate QR code: $error");
      return;
    }

    Ticket newTicket = Ticket(
      id: ticketId,
      busId: bus.value.id,
      busRoute: bus.value.routeName,
      qrCode: qrCode,
      purchaseDate: purchaseDate,
      expiryDate: expiryDate,
      scanCount: scanCount,
      isExpired: isExpired,
    );

    ticket.value = newTicket;

    // Storing the generated ticket in Firestore under the user's collection
    await firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('tickets')
        .doc(ticketId)
        .set(newTicket.toMap());

    // storing the generated ticket in a general tickets collection
    await firestore.collection('tickets').doc(ticketId).set(newTicket.toMap());

    // Creating booking information
    String bookingId = firestore.collection('bookings').doc().id;
    BookingService newBooking = BookingService(
      id: bookingId,
      userId: FirebaseAuth.instance.currentUser!.uid,
      busId: bus.value.id,
      ticketId: ticketId,
      bookingDate: purchaseDate,
    );

    // Store the booking information
    await firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('bookings')
        .doc(bookingId)
        .set(newBooking.toMap());

    // Optionally, you can store the booking in a general bookings collection
    await firestore
        .collection('bookings')
        .doc(bookingId)
        .set(newBooking.toMap());
  }
}
