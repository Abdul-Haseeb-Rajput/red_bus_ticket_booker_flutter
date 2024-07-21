import 'package:bus_ticket_booker_flutter/home/view/home_view.dart';
import 'package:bus_ticket_booker_flutter/models/ticket.dart';
import 'package:bus_ticket_booker_flutter/my_ticket/controller/my_ticket_controller.dart';
import 'package:bus_ticket_booker_flutter/my_ticket/view/qr_full_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

class MyTicketsView extends StatelessWidget {
  const MyTicketsView({super.key});

  @override
  Widget build(BuildContext context) {
    final MyTicketController myTicketsController =
        Get.put(MyTicketController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tickets'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 1,
      ),
      body: Obx(() {
        if (myTicketsController.loading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (myTicketsController.tickets.isEmpty) {
          return const Center(
            child: Text('No tickets Purchased Yet!'),
          );
        }

        return ListView.builder(
          itemCount: myTicketsController.tickets.length,
          itemBuilder: (context, index) {
            final Ticket ticket = myTicketsController.tickets[index];
            // Formatting dates
            final DateFormat dateFormat = DateFormat('dd-MM-yy');
            final DateFormat timeFormat = DateFormat('hh:mm a');
            final String purchaseDate = dateFormat.format(ticket.purchaseDate);
            final String expireDate = dateFormat.format(ticket.expiryDate);
            final String purchaseTime = timeFormat.format(ticket.purchaseDate);
            final String expireTime = timeFormat.format(ticket.expiryDate);

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: QrBusCard(
                busName: ticket.busRoute ?? "Unknown",
                purchaseDate: "$purchaseDate - $purchaseTime",
                expireDate: "$expireDate - $expireTime",
                price: "Rs.50",
                qrCode: ticket.qrCode,
                imageLink: "assets/images/bus.png",
                scanCount: ticket.scanCount.toString(),
              ),
            );
          },
        );
      }),
    );
  }
}

class QrBusCard extends StatelessWidget {
  const QrBusCard({
    super.key,
    this.imageLink,
    this.busName,
    this.qrCode,
    this.purchaseDate,
    this.expireDate,
    this.price,
    this.scanCount,
  });

  final String? imageLink;
  final String? busName;
  final String? qrCode;
  final String? purchaseDate;
  final String? expireDate;
  final String? price;
  final String? scanCount;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => QrFullView(
            busName: busName!,
            qrCode: qrCode!,
            purchaseDate: purchaseDate!,
            expireDate: expireDate!,
            scanCount: scanCount!,
          ),
        );
      },
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 8),
              blurRadius: 14,
              spreadRadius: 2,
              color: Color.fromARGB(39, 0, 0, 0),
              blurStyle: BlurStyle.normal,
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: CustomPaint(
          painter: TicketPainter(),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      QrImageView(
                        data: qrCode!,
                        embeddedImage: AssetImage(imageLink!),
                        errorCorrectionLevel: QrErrorCorrectLevel.H,
                      ),
                      Text(
                        busName!,
                        style:
                            const TextStyle(fontSize: 24.0, color: Colors.red),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Row(
                    children: [
                      const SizedBox(width: 50),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Purchase Date & Time",
                            style:
                                TextStyle(fontSize: 10.0, color: Colors.grey),
                          ),
                          Text(
                            purchaseDate!,
                            style: const TextStyle(fontSize: 12.0),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            "Expiry Date & Time",
                            style:
                                TextStyle(fontSize: 10.0, color: Colors.grey),
                          ),
                          Text(
                            expireDate!,
                            style: const TextStyle(fontSize: 12.0),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            "Price",
                            style:
                                TextStyle(fontSize: 10.0, color: Colors.grey),
                          ),
                          Text(
                            price!,
                            style: const TextStyle(fontSize: 12.0),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            "Scan Count",
                            style:
                                TextStyle(fontSize: 10.0, color: Colors.grey),
                          ),
                          Text(
                            scanCount!,
                            style: const TextStyle(fontSize: 12.0),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
