import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pay_cutter/common/widgets/custom_icon.widget.dart';
import 'package:pay_cutter/common/widgets/custome_appbar.widget.dart';

class PickLocationPage extends StatefulWidget {
  const PickLocationPage({super.key});

  @override
  State<PickLocationPage> createState() => _PickLocationPageState();
}

class _PickLocationPageState extends State<PickLocationPage> {
  LatLng? location;

  Set<Marker> _getMarker() {
    if (location == null) return {};
    return {
      Marker(
        markerId: const MarkerId('1'),
        position: location!,
      )
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: 'Pick your location',
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pop(location);
              },
              icon: const CustomIcon(
                iconData: Icons.done,
              ))
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(16.0765013684895, 108.15041320779056),
        ),
        onTap: (argument) => setState(() {
          location = argument;
        }),
        markers: _getMarker(),
      ),
    );
  }
}
