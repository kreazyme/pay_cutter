import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_cutter/common/styles/text_styles.dart';
import 'package:pay_cutter/modules/core/bloc/core.bloc.dart';
import 'package:pay_cutter/modules/core/widgets/app_bottom_item.widget.dart';
import 'package:pay_cutter/modules/home/home.view.dart';
import 'package:pay_cutter/modules/profile/profile.view.dart';
import 'package:pay_cutter/modules/scan/scan.page.dart';

class CorePage extends StatelessWidget {
  const CorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CoreBloc(),
      child: BlocListener<CoreBloc, CoreState>(
        listener: _onListner,
        child: const _CoreView(),
      ),
    );
  }

  void _onListner(BuildContext context, CoreState state) {
    // if (state is CoreState) {
    //   return _CoreView();
    // }
  }
}

class _CoreView extends StatelessWidget {
  const _CoreView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoreBloc, CoreState>(
      builder: (context, state) => Scaffold(
        appBar: AppBar(
            title: Text(
              'Core Page',
              style: TextStyles.title.copyWith(
                color: Colors.white,
              ),
            ),
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                );
              },
            )),
        body: IndexedStack(
          index: state.indexBottom,
          children: const [
            HomePage(),
            ProfilePage(),
          ],
        ),
        drawer: Container(
          color: Colors.white,
          height: double.infinity,
          width: 300,
          child: const Center(child: Text('Hello World')),
        ),
        bottomNavigationBar: AppBottomNavigation(
          currentIndex: state.indexBottom,
        ),
      ),
    );
  }
}
