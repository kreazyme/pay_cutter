import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pay_cutter/common/extensions/regex.dart';
import 'package:pay_cutter/modules/scan/barcode_painter.dart';
import 'package:pay_cutter/modules/scan/bloc/scan.bloc.dart';
import 'package:tiengviet/tiengviet.dart';

class ScanPage extends StatelessWidget {
  const ScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ScanBloc(),
      child: BlocListener<ScanBloc, ScanState>(
        listener: _onListener,
        child: const _ScanView(),
      ),
    );
  }

  void _onListener(BuildContext context, ScanState state) {}
}

class _ScanView extends StatefulWidget {
  const _ScanView();

  @override
  State<_ScanView> createState() => _ScanViewState();
}

List<CameraDescription> cameras = [];

class _ScanViewState extends State<_ScanView> {
  XFile? image;
  final TextRecognizer _textRecognizer = TextRecognizer();
  bool _isBusy = false;
  bool _canProcess = true;

  CustomPaint? _customPaint;
  String? _text = '';

  Future<void> _takePicture() async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);
    if (photo == null) {
      log('____________ No photos');
      return;
    }
    setState(() {
      log('set state');
      image = photo;
    });
    if (photo.path != null) {
      processImage(InputImage.fromFilePath(photo.path));
    }
  }

  Future<void> processImage(InputImage inputImage) async {
    log('Start processing');
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    setState(() {
      _text = '';
    });
    final recognizedText = await _textRecognizer.processImage(inputImage);
    if (inputImage.inputImageData?.size != null &&
        inputImage.inputImageData?.imageRotation != null) {
      log('start painted');
      final painter = TextRecognizerPainter(
        recognizedText,
        inputImage.inputImageData!.size,
        inputImage.inputImageData!.imageRotation,
      );
      _customPaint = CustomPaint(painter: painter);
    } else {
      recognizedText.blocks
          .sort((a, b) => a.boundingBox.top.compareTo(b.boundingBox.top));
      recognizedText.blocks.reversed.forEach((element) {
        String vnText = TiengViet.parse(element.text);
        if (checkBill.hasMatch(vnText)) {
          log('------------------------');
          log(vnText);
          String? txtBill = recognizedText
              .blocks[recognizedText.blocks.indexOf(element) + 1].text;
          log(txtBill);
        }
      });
      // recognizedText.blocks.forEach((block) async {
      //   String txtsss = TiengViet.parse(block.text);
      //   if (checkBill.hasMatch(txtsss)) {
      //     log('_________');
      //     log(txtsss);
      //     String? txtBill = recognizedText
      //         .blocks[recognizedText.blocks.indexOf(block) + 1].text;
      //     if (txtBill.isNotEmpty) {
      //       String? txt123 = isMoney
      //           .firstMatch(txtBill.split(',').join().split('.').join())
      //           ?.group(0);
      //       _text = txt123 ?? 'No text found';
      //     }
      //     log('_________');
      //   }
      // });
      // log(recognizedText.text);
      // _text = recognizedText.text;
      _customPaint = null;
    }
    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: image?.path == null
          ? MaterialButton(
              onPressed: _takePicture,
              child: const Text('Scan'),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  const Divider(
                    height: 20,
                  ),
                  Text(
                    _text ?? 'No text found',
                    style: const TextStyle(fontSize: 20),
                  ),
                  MaterialButton(
                    onPressed: _takePicture,
                    child: const Text('Scan'),
                  ),
                  Image.file(
                    File(image!.path),
                  )
                ],
              ),
            ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _canProcess = false;
    _textRecognizer.close();
  }
}
