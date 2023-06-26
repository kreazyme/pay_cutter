import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pay_cutter/common/widgets/custome_appbar.widget.dart';

class ViewMapWidget extends StatelessWidget {
  const ViewMapWidget({
    super.key,
    required this.location,
  });

  final LatLng location;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        title: 'View Location',
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(
            16.0765013684895,
            108.15041320779056,
          ),
          zoom: 15,
        ),
        markers: {
          Marker(
            markerId: const MarkerId('1'),
            position: location,
          )
        },
      ),
    );
  }
}
