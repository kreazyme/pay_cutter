import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:pay_cutter/common/styles/text_styles.dart';

class QRScanPage extends StatefulWidget {
  const QRScanPage({super.key});

  @override
  State<QRScanPage> createState() => _QRScanPageState();
}

class _QRScanPageState extends State<QRScanPage> {
  bool _isTorchOn = false;
  bool _isCameraBack = true;
  String? _data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'QR Scan',
          style: TextStyles.title.copyWith(
            color: Colors.white,
          ),
        ),
      ),
      body: Column(children: [
        Text(_data ?? 'No data found!!!!'),
        SizedBox(
          height: 300,
          width: 300,
          child: Stack(
            children: [
              MobileScanner(
                // fit: BoxFit.contain,
                controller: MobileScannerController(
                  detectionSpeed: DetectionSpeed.normal,
                  facing:
                      _isCameraBack ? CameraFacing.back : CameraFacing.front,
                  torchEnabled: _isTorchOn,
                ),
                onDetect: (capture) {
                  final List<Barcode> barcodes = capture.barcodes;
                  for (final barcode in barcodes) {
                    debugPrint('Barcode found! ${barcode.rawValue}');
                    setState(() {
                      _data = barcode.rawValue;
                    });
                  }
                },
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 100,
                  color: Colors.black.withOpacity(0.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.flash_on,
                          color: _isTorchOn ? Colors.white : Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _isTorchOn = !_isTorchOn;
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.camera_alt,
                          color: _isCameraBack ? Colors.white : Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _isCameraBack = !_isCameraBack;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
