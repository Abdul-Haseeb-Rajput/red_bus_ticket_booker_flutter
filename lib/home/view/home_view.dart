import 'package:bus_ticket_booker_flutter/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body:
          // Container(height: 80, width: 80, color: Colors.amber),
          PageView.builder(
        itemCount: homeController.pages.length,
        onPageChanged: (selectedIndex) {
          homeController.changeIndex(selectedIndex)!.value;
        },
        itemBuilder: (context, index) {
          return homeController.pages[index];
        },
        controller: homeController.pageController,
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: homeController.currentIndex.value,
          onTap: (selectedIndex) {
            homeController.changeIndex(selectedIndex)!.value;
          },
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey[400],
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: "Home",
              backgroundColor: Colors.black,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long_rounded),
              label: "My Tickets",
              backgroundColor: Colors.black,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications_rounded),
              label: "Notifications",
              backgroundColor: Colors.black,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
              backgroundColor: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}

class CustomBusCard extends StatelessWidget {
  const CustomBusCard({
    super.key,
    this.imageLink,
    this.busName,
    this.timings,
    this.fromTo,
    this.price,
  });
  final String? imageLink;
  final String? busName;
  final String? timings;
  final String? fromTo;
  final String? price;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
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
                child: Container(
                  // color: Colors.brown,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/bus.png",
                        width: 60,
                      ),
                      Text(
                        busName!,
                        style:
                            const TextStyle(fontSize: 24.0, color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Row(
                  children: [
                    const SizedBox(
                      width: 50,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Timings",
                          style: TextStyle(fontSize: 10.0, color: Colors.grey),
                        ),
                        Text(
                          timings!,
                          style: const TextStyle(fontSize: 12.0),
                        ),
                        const Text(
                          "From - To",
                          style: TextStyle(fontSize: 10.0, color: Colors.grey),
                        ),
                        Container(
                          constraints: const BoxConstraints(
                              maxWidth: 150), // Adjust maximum width as needed
                          child: Wrap(
                            children: [
                              Text(
                                fromTo!,
                                style: const TextStyle(fontSize: 12.0),
                              ),
                            ],
                          ),
                        ),
                        const Text(
                          "Price",
                          style: TextStyle(fontSize: 10.0, color: Colors.grey),
                        ),
                        Text(
                          price!,
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
    );
  }
}

class TicketPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = const Color.fromARGB(255, 246, 246, 246)
      ..style = PaintingStyle.fill;

    Path path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width / 2.5 - 19.5, 0)
      ..arcToPoint(
        Offset(size.width / 2.5 + 19.5, 0),
        radius: const Radius.circular(20),
        clockwise: false,
      )
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width / 2.5 + 19.5, size.height)
      ..arcToPoint(
        Offset(size.width / 2.5 - 19.5, size.height),
        radius: const Radius.circular(20),
        clockwise: false,
      )
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(path, paint);

    // Paint for the dotted lines
    Paint dottedLinePaint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 2;
    // Define the step for the dotted line segments
    double lineLength = 5.0;
    double gapLength = 5.0;
    double startY = 20; // Starting position below the top arc
    double endY = size.height - 20; // Ending position above the bottom arc

    // Draw dotted lines from top to bottom arc
    for (double y = startY; y < endY; y += lineLength + gapLength) {
      canvas.drawLine(
        Offset(size.width / 2.5, y),
        Offset(size.width / 2.5, y + lineLength),
        dottedLinePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
