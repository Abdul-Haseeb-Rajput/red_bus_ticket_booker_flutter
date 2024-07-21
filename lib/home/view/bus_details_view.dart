import 'package:bus_ticket_booker_flutter/home/controller/bus_details_controller.dart';
import 'package:bus_ticket_booker_flutter/home/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BusDetails extends StatelessWidget {
  const BusDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final BusDetailsController busController = Get.find<BusDetailsController>();
    final String formattedRoutes =
        busController.bus.value.routes.join(' <--> ');
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Bus Details'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/bus.png",
                    width: 120,
                  ),
                  Text(
                    busController.bus.value.routeName,
                    style: const TextStyle(fontSize: 30),
                  ),
                  const SizedBox(height: 16),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Route Names",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Text(
                    formattedRoutes,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Timings",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Text(
                    "${busController.bus.value.startTime} till ${busController.bus.value.endTime}",
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () async {
                // await busController.generateTicket();
                // Show the custom bottom sheet
                Get.bottomSheet(const BookingBottomSheet(),
                    backgroundColor: Colors.amber);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Proceed'),
            ),
          ),
        ],
      ),
    );
  }
}

class BookingBottomSheet extends StatelessWidget {
  const BookingBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final BusDetailsController busDetailsController =
        Get.find<BusDetailsController>();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Bus Details',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          CustomBusCard(
            busName: busDetailsController.bus.value.routeName,
            fromTo:
                "${busDetailsController.bus.value.routes.first} - ${busDetailsController.bus.value.routes.last}",
            imageLink: "assets/images/bus.png",
            price: busDetailsController.bus.value.price.toString(),
            timings:
                "${busDetailsController.bus.value.startTime} - ${busDetailsController.bus.value.endTime}",
            key: key,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              busDetailsController.generateTicket();

              Get.back(); // Close the bottom sheet
              Future.delayed(
                const Duration(milliseconds: 300),
                () {
                  Get.snackbar(
                    "Successfully booked",
                    "Go to my tickets to check the unique Qr code",
                    duration: const Duration(seconds: 5),
                  );
                },
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 50),
            ),
            child: const Text('Book Now'),
          ),
        ],
      ),
    );
  }
}
