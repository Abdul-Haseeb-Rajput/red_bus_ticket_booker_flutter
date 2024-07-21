import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrFullView extends StatelessWidget {
  final String busName;
  final String qrCode;
  final String purchaseDate;
  final String expireDate;
  final String scanCount;

  const QrFullView({
    super.key,
    required this.busName,
    required this.qrCode,
    required this.purchaseDate,
    required this.expireDate, required this.scanCount,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              busName,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            QrImageView(
              data: qrCode,
              version: QrVersions.auto,
              size: 250.0,
              embeddedImage: const AssetImage("assets/images/bus.png"),
              errorCorrectionLevel: QrErrorCorrectLevel.H,
            ),
            const SizedBox(height: 20),
            const Text(
              'Purchase Date & Time',
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            Text(
              "$purchaseDate",
              style: const TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const Text(
              'Expiry Date & Time',
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            Text(
              expireDate,
              style: const TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            const Text(
              "Scan Count",
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            Text(
             scanCount,
              style: const TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
