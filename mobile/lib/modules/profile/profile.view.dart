import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_cutter/modules/profile/bloc/profile.bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileBloc(),
      child: BlocListener<ProfileBloc, ProfileState>(
        listener: _onListner,
        child: const _ProfileView(),
      ),
    );
  }

  void _onListner(BuildContext context, ProfileState state) {}
}

class _ProfileView extends StatelessWidget {
  const _ProfileView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) => const Center(
          child: Text('Profile Page'),
        ),
      ),
    );
  }
}
