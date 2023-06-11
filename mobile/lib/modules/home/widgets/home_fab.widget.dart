// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:pay_cutter/common/styles/color_styles.dart';
import 'package:pay_cutter/data/models/group.model.dart';
import 'package:pay_cutter/modules/home/bloc/home.bloc.dart';
import 'package:pay_cutter/routers/app_routers.dart';

class HomeFABWidget extends StatelessWidget {
  const HomeFABWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      // animatedIcon: AnimatedIcons.add_event,
      icon: Icons.add,
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      animatedIconTheme: const IconThemeData(size: 22),
      backgroundColor: AppColors.primaryColor,
      visible: true,
      curve: Curves.bounceIn,
      children: [
        // FAB 1
        SpeedDialChild(
          child: const Icon(
            Icons.group_add,
            color: Colors.white,
          ),
          backgroundColor: AppColors.primaryColor,
          onTap: () async {
            Object? result =
                await Navigator.pushNamed(context, AppRouters.createGroup);
            if (result != null) {
              context.read<HomeBloc>().add(
                    HomeAddGroup(
                      group: result as GroupModel,
                    ),
                  );
            }
          },
          label: 'Add Group',
          labelStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.white,
            fontSize: 16.0,
          ),
          labelBackgroundColor: AppColors.primaryColor,
        ),
        // FAB 2
        SpeedDialChild(
          child: const Icon(
            Icons.qr_code_scanner_rounded,
            color: Colors.white,
          ),
          backgroundColor: AppColors.primaryColor,
          onTap: () => Navigator.pushNamed(
            context,
            AppRouters.qrScan,
          ),
          label: 'Scan QR',
          labelStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.white,
            fontSize: 16.0,
          ),
          labelBackgroundColor: AppColors.primaryColor,
        ),
        // SpeedDialChild(
        //   child: const Icon(
        //     Icons.qr_code_scanner_rounded,
        //     color: Colors.white,
        //   ),
        //   backgroundColor: AppColors.primaryColor,
        //   onTap: () => Navigator.pushNamed(
        //     context,
        //     AppRouters.scanBill,
        //   ),
        //   label: 'Heheh',
        //   labelStyle: const TextStyle(
        //     fontWeight: FontWeight.w500,
        //     color: Colors.white,
        //     fontSize: 16.0,
        //   ),
        //   labelBackgroundColor: AppColors.primaryColor,
        // )
      ],
    );
  }
}
