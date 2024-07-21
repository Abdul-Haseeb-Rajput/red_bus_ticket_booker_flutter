import 'package:bus_ticket_booker_flutter/models/ticket.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class MyTicketController extends GetxController {
  var tickets = <Ticket>[].obs;
  var loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTickets();
  }

  void fetchTickets() {
    try {
      loading.value = true;
      final userId = FirebaseAuth.instance.currentUser!.uid;
      FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('tickets')
          .snapshots()
          .listen((snapshot) async {
        final List<Ticket> fetchedTickets =
            await Future.wait(snapshot.docs.map((doc) async {
          final ticket = Ticket.fromMap(doc.data() as Map<String, dynamic>);

          // Fetching bus route based on busId
          final busSnapshot = await FirebaseFirestore.instance
              .collection('buses')
              .doc(ticket.busId)
              .get();

          if (busSnapshot.exists) {
            final busData = busSnapshot.data() as Map<String, dynamic>;
            final busRoute = busData['routeName'];
            ticket.busRoute = busRoute;
          }

          return ticket;
        }).toList());

        // Sorting tickets by purchase date in descending order
        fetchedTickets.sort((a, b) => b.purchaseDate.compareTo(a.purchaseDate));

        tickets.assignAll(fetchedTickets);
        loading.value = false;
      });
    } catch (e) {
      // print('Failed to fetch tickets: $e');
      loading.value = false;
    }
  }
}
