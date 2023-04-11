import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_cutter/modules/core/bloc/core.bloc.dart';

class AppBottomNavigation extends StatelessWidget {
  const AppBottomNavigation({
    super.key,
    required this.currentIndex,
  });

  final int currentIndex;

  List<BottomNavigationBarItem> _renderItem() {
    return const [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home',
        backgroundColor: Colors.blue,
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.qr_code),
        label: 'Scan',
        backgroundColor: Colors.blue,
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
