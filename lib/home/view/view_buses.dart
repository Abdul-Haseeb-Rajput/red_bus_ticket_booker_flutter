import 'package:bus_ticket_booker_flutter/home/controller/home_controller.dart';
import 'package:bus_ticket_booker_flutter/home/view/home_view.dart';
import 'package:bus_ticket_booker_flutter/models/bus_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewBuses extends StatelessWidget {
  const ViewBuses({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController viewBusesController = Get.find<HomeController>();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Bus Ticket Booking'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Obx(() {
        if (viewBusesController.buses.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(8.0),
            itemCount: viewBusesController.buses.length,
            itemBuilder: (context, index) {
              Bus bus = viewBusesController.buses[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    viewBusesController.navigateToBusDetailsView(bus);
                  },
                  child: CustomBusCard(
                    imageLink: "",
                    busName: bus.routeName,
                    timings: "${bus.startTime} - ${bus.endTime}",
                    fromTo: "${bus.routes.first} <-> ${bus.routes.last}",
                    price: "Rs. ${bus.price}",
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }
}
