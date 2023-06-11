import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:pay_cutter/common/extensions/string.extentions.dart';
import 'package:pay_cutter/common/shared/app_enviroment.dart';
import 'package:pay_cutter/common/styles/color_styles.dart';
import 'package:pay_cutter/common/styles/text_styles.dart';
import 'package:pay_cutter/common/ultis/params_wrapper_ultis.dart';
import 'package:pay_cutter/common/widgets/custome_appbar.widget.dart';
import 'package:pay_cutter/common/widgets/toast/toast_ulti.dart';
import 'package:pay_cutter/data/models/group.model.dart';
import 'package:pay_cutter/data/repository/group_repo.dart';
import 'package:pay_cutter/generated/di/injector.dart';
import 'package:pay_cutter/routers/app_routers.dart';

class QRScanPage extends StatefulWidget {
  const QRScanPage({super.key});

  @override
  State<QRScanPage> createState() => _QRScanPageState();
}

class _QRScanPageState extends State<QRScanPage> {
  bool _isTorchOn = false;
  bool _isCameraBack = true;
  String? _data;
  final MobileScannerController _controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.normal,
    facing: CameraFacing.back,
    torchEnabled: false,
  );
  final GroupRepository _groupRepository = getIt.get<GroupRepository>();

  String? _getPayCutterGroup() {
    if (_data.isNullOrEmpty) return null;
    if (_data?.contains(AppEnviroment.API_URL) == false) {
      return null;
    }
    return _data?.split('/').last;
  }

  void _joinGroup() async {
    try {
      final group = await _groupRepository.joinGroup(_getPayCutterGroup()!);
      if (mounted) {
        Navigator.pushReplacementNamed(
          context,
          AppRouters.chat,
          arguments: ParamsWrapper2<GroupModel, bool>(
            param1: group,
            param2: false,
          ),
        );
      }
    } catch (e) {
      ToastUlti.showError(context, 'Cannot join group');
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: const CustomAppbar(
        title: 'Scan QR Code',
      ),
      body: Column(children: [
        Container(
          height: width,
          width: width,
          margin: const EdgeInsets.all(20),
          child: MobileScanner(
            controller: _controller,
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
        ),
        const Spacer(),
        Text(
          _getPayCutterGroup() ?? 'Finding PayCutter QR Code',
          style: TextStyles.titleBold.copyWith(
            color: AppColors.textColor.withOpacity(0.5),
          ),
        ),
        const Spacer(),
        SizedBox(
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: GestureDetector(
                  child: Icon(
                    Icons.flash_on,
                    color: _isTorchOn ? Colors.white : Colors.grey,
                  ),
                  onTap: () {
                    setState(() {
                      _controller.toggleTorch();
                      _isTorchOn = !_isTorchOn;
                    });
                  },
                ),
              ),
              Container(
                  height: 72,
                  width: 72,
                  decoration: BoxDecoration(
                    color: _getPayCutterGroup().isNullOrEmpty
                        ? Colors.grey.withOpacity(0.2)
                        : AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  margin: const EdgeInsets.only(bottom: 40),
                  child: GestureDetector(
                    onTap: () {
                      if (_getPayCutterGroup().isNullOrEmpty) {
                        return;
                      }
                      _joinGroup();
                    },
                    child: Center(
                      child: Text(
                        'Join',
                        style: TextStyles.title.copyWith(color: Colors.white),
                      ),
                    ),
                  )),
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: GestureDetector(
                  child: Icon(
                    Icons.camera_alt,
                    color: _isCameraBack ? Colors.white : Colors.grey,
                  ),
                  onTap: () {
                    setState(() {
                      _isCameraBack = !_isCameraBack;
                      _controller.switchCamera();
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
      ]),
    );
  }
}
