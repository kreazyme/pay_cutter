import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_cutter/common/styles/color_styles.dart';
import 'package:pay_cutter/modules/core/bloc/core.bloc.dart';

class AppBottomNavigation extends StatelessWidget {
  const AppBottomNavigation({
    super.key,
    required this.currentIndex,
  });

  final int currentIndex;

  List<BottomNavigationBarItem> _renderItem() {
    return [
      BottomNavigationBarItem(
        icon: const Icon(Icons.home),
        label: 'Home',
        backgroundColor: AppColors.primaryColor,
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.person_rounded),
        label: 'Profile',
        backgroundColor: AppColors.primaryColor,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      items: _renderItem(),
      onTap: (value) => context.read<CoreBloc>().add(
            CoreBottomChange(value),
          ),
      backgroundColor: Colors.white,
    );
  }
}
