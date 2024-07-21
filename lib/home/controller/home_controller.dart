import 'package:bus_ticket_booker_flutter/home/view/view_buses.dart';
import 'package:bus_ticket_booker_flutter/models/bus_model.dart';
import 'package:bus_ticket_booker_flutter/my_ticket/view/my_tickets_view.dart';
import 'package:bus_ticket_booker_flutter/notifications/view/notification_view.dart';
import 'package:bus_ticket_booker_flutter/profile/view/profile_view.dart';
import 'package:bus_ticket_booker_flutter/routes/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  var buses = <Bus>[].obs;
  RxInt currentIndex = 0.obs;
  final PageController pageController = PageController();

  @override
  void onInit() {
    super.onInit();
    fetchBuses();
  }

  //
  final List<Widget> pages = [
    const ViewBuses(),
    const MyTicketsView(),
    const Notificationview(),
    const ProfileView(),
  ];

  RxInt? changeIndex(int? selectedIndex) {
    currentIndex.value = selectedIndex!;
    pageController.jumpToPage(selectedIndex);
    return currentIndex;
  }

  ///

  Future<void> fetchBuses() async {
    try {
      QuerySnapshot result =
          await firestore.collection('buses').orderBy('routeName').get();
      var fetchedBuses = result.docs
          .map((doc) => Bus.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      fetchedBuses.sort((a, b) {
        List<String> partsA = a.routeName.split("-");
        List<String> partsB = b.routeName.split("-");
        int prefixComparison = partsA[0].compareTo(partsB[0]);
        if (prefixComparison != 0) {
          return prefixComparison;
        }

        if (partsA.length > 1 && partsB.length > 1) {
          return int.parse(partsA[1]).compareTo(int.parse(partsB[1]));
        } else {
          return a.routeName.compareTo(b.routeName);
        }
      });

      buses.assignAll(fetchedBuses);
    } catch (e) {
      print('Error fetching buses: $e');
      buses.assignAll([]);
    }
  }



  void navigateToBusDetailsView(Bus bus) {
    Get.toNamed(
      RoutesNames.busDetailsView,
      arguments: bus,
    );
  }
}
