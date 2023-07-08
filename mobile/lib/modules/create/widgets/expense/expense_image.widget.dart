import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pay_cutter/common/extensions/string.extentions.dart';
import 'package:pay_cutter/common/ultis/params_wrapper_ultis.dart';
import 'package:pay_cutter/modules/create/bloc/create_expense/create_expense_bloc.dart';
import 'package:pay_cutter/routers/app_routers.dart';

class ExpenseImageWidget extends StatelessWidget {
  const ExpenseImageWidget({
    super.key,
    required this.groupId,
    this.location,
    this.imageUrl,
  });

  final int groupId;
  final LatLng? location;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            if (imageUrl == null)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                  child: GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[300],
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          context.read<CreateExpenseBloc>().add(
                                CreateExpenseUploadFile(
                                  groupId: groupId,
                                ),
                              );
                        },
                        child: const Icon(Icons.image_rounded),
                      ),
                    ),
                  ),
                ),
              ),
            if (location == null)
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[300],
                  ),
                  child: MaterialButton(
                    onPressed: () async {
                      var result = await Navigator.pushNamed(
                          context, AppRouters.pickLocation);
                      if (result == null ||
                          result is! ParamsWrapper2<LatLng, String>) return;
                      context.read<CreateExpenseBloc>().add(
                            CreateExpenseChangeLocation(
                              location: result.param1,
                              address: result.param2,
                            ),
                          );
                    },
                    child: const Icon(Icons.location_on_outlined),
                  ),
                ),
              ),
          ],
        ),
        if (!imageUrl.isNullOrEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                imageUrl!,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const SizedBox(
                    height: 200,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              ),
            ),
          ),
        if (location != null)
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 16,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            height: 300,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: location!,
                zoom: 14.4746,
              ),
              zoomGesturesEnabled: false,
              markers: {
                Marker(
                  markerId: const MarkerId('1'),
                  position: location!,
                )
              },
            ),
          )
      ],
    );
  }
}
