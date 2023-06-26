import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pay_cutter/common/shared/app_enviroment.dart';
import 'package:pay_cutter/common/ultis/params_wrapper_ultis.dart';
import 'package:pay_cutter/common/widgets/custom_icon.widget.dart';
import 'package:pay_cutter/common/widgets/custome_appbar.widget.dart';
import 'package:pay_cutter/common/widgets/toast/toast_ulti.dart';

class PickLocationPage extends StatefulWidget {
  const PickLocationPage({super.key});

  @override
  State<PickLocationPage> createState() => _PickLocationPageState();
}

class _PickLocationPageState extends State<PickLocationPage> {
  LatLng? location;
  String address = '';

  Set<Marker> _getMarker() {
    if (location == null) return {};
    return {
      Marker(
        markerId: const MarkerId('1'),
        position: location!,
      )
    };
  }

  void _getAddress(BuildContext context) async {
    final Dio dio = Dio();
    final Response<dynamic> response = await dio.get(
      '${AppEnviroment.MAP_URL}?at=${location?.latitude ?? 20}%2C${location?.longitude ?? 20}&lang=en-US&apiKey=${AppEnviroment.MAP_KEY}',
    );
    setState(() {
      address = response.data['items'][0]['title'];
    });

    if (mounted) {
      ToastUlti.showSuccess(
        context,
        'Picked location: $address',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: 'Pick your location',
        actions: [
          if (address.isNotEmpty)
            IconButton(
                onPressed: () async {
                  var params = ParamsWrapper2<LatLng, String>(
                      param1: location!, param2: address);
                  Navigator.pop(context, params);
                },
                icon: const CustomIcon(
                  iconData: Icons.done,
                ))
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(
            16.0765013684895,
            108.15041320779056,
          ),
          zoom: 15,
        ),
        onTap: (argument) => setState(() {
          location = argument;
          _getAddress(context);
        }),
        markers: _getMarker(),
      ),
    );
  }
}
