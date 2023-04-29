import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_cutter/common/styles/color_styles.dart';
import 'package:pay_cutter/common/styles/text_styles.dart';
import 'package:pay_cutter/data/repository/auth_repo.dart';
import 'package:pay_cutter/data/repository/user_repo.dart';
import 'package:pay_cutter/generated/assets.gen.dart';
import 'package:pay_cutter/generated/di/injector.dart';
import 'package:pay_cutter/modules/chat/widget/detail/detail_item_button.widget.dart';
import 'package:pay_cutter/modules/profile/bloc/profile.bloc.dart';
import 'package:pay_cutter/routers/app_routers.dart';

import '../../common/widgets/animation/app_loading.widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileBloc(
        userRepo: getIt.get<UserRepo>(),
        authenRepo: getIt.get<AuthenRepo>(),
      ),
      child: BlocListener<ProfileBloc, ProfileState>(
        listener: _onListner,
        child: const _ProfileView(),
      ),
    );
  }

  void _onListner(BuildContext context, ProfileState state) {
    if (state is ProfileLogouted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRouters.login,
        (route) => false,
      );
    }
  }
}

class _ProfileView extends StatelessWidget {
  const _ProfileView();

  final double _avatarSize = 80;

  final Widget _space = const Divider(
    height: 12,
    color: Colors.transparent,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state.status.isLoading || state.status.isInitial) {
            return const AppCustomLoading();
          }
          return Container(
            width: double.infinity,
            margin: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    SizedBox(
                      height: _avatarSize,
                      width: _avatarSize,
                      child: CircleAvatar(
                        radius: _avatarSize,
                        backgroundColor: AppColors.borderColor,
                        child: Padding(
                          padding: const EdgeInsets.all(8), // Border radius
                          child: ClipOval(
                              child: SizedBox(
                            height: _avatarSize,
                            width: _avatarSize,
                            child: state.user?.avatarUrl == null ||
                                    state.user!.avatarUrl.isEmpty
                                ? Image.asset(
                                    Assets.images.imgAvatarDefault.path)
                                : Image.network(
                                    state.user!.avatarUrl,
                                    fit: BoxFit.cover,
                                  ),
                          )),
                        ),
                      ),
                    ),
                    const VerticalDivider(
                      width: 20,
                      color: Colors.transparent,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.user!.name,
                          style: TextStyles.titleBold,
                        ),
                        const Divider(
                          height: 4,
                          color: Colors.transparent,
                        ),
                        Text(
                          '@ ${state.user!.email}',
                          style: TextStyles.body.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                _space,
                DetailItemButtonWidget(
                  onPressed: () {},
                  title: 'Edit Profile',
                  icon: const Icon(
                    Icons.edit,
                  ),
                ),
                DetailItemButtonWidget(
                  onPressed: () {},
                  title: 'Share this app',
                  icon: const Icon(
                    Icons.share_outlined,
                  ),
                ),
                DetailItemButtonWidget(
                  onPressed: () {},
                  title: 'About us',
                  icon: const Icon(
                    Icons.accessible_forward_outlined,
                  ),
                ),
                DetailItemButtonWidget(
                  onPressed: () {},
                  title: 'Send feedback',
                  icon: const Icon(
                    Icons.feedback_outlined,
                  ),
                ),
                DetailItemButtonWidget(
                  onPressed: () {
                    context.read<ProfileBloc>().add(ProfileLogout());
                  },
                  title: 'Logout',
                  isWarning: true,
                  icon: const Icon(
                    Icons.logout_rounded,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
