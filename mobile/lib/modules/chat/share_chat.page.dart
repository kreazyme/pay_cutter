import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_cutter/common/endpoints.dart';
import 'package:pay_cutter/common/enum.dart';
import 'package:pay_cutter/common/styles/color_styles.dart';
import 'package:pay_cutter/common/widgets/animation/app_loading.widget.dart';
import 'package:pay_cutter/common/widgets/custom_app_error.widget.dart';
import 'package:pay_cutter/common/widgets/custome_appbar.widget.dart';
import 'package:pay_cutter/common/widgets/toast/toast_ulti.dart';
import 'package:pay_cutter/data/repository/chat_repo.dart';
import 'package:pay_cutter/generated/di/injector.dart';
import 'package:pay_cutter/modules/chat/share/share_chat_bloc.dart';
import 'package:pay_cutter/modules/chat/widget/share/share_copy_link.widget.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ShareChat extends StatelessWidget {
  const ShareChat({
    super.key,
    required this.id,
  });

  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ShareChatBloc(
        chatRepository: getIt.get<ChatRepository>(),
      ),
      child: BlocListener<ShareChatBloc, ShareChatState>(
        listener: _onListener,
        child: _ShareChatView(
          id: id,
        ),
      ),
    );
  }

  void _onListener(
    BuildContext context,
    ShareChatState state,
  ) {
    if (state is ShareChatFailure) {
      ToastUlti.showError(context, null);
    }
  }
}

class _ShareChatView extends StatelessWidget {
  const _ShareChatView({
    required this.id,
  });
  final int id;

  @override
  Widget build(BuildContext context) {
    context.read<ShareChatBloc>().add(ShareChatUrlGet(id: id));
    return Scaffold(
      appBar: const CustomAppbar(
        title: 'Share Chat',
      ),
      body: BlocBuilder<ShareChatBloc, ShareChatState>(
        builder: (context, state) {
          if (state.status == HandleStatus.loading) {
            return const Center(
              child: AppCustomLoading(),
            );
          } else if (state.status == HandleStatus.success) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.backgroundColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: QrImage(
                    data: '${AppEndpoints.share}/${state.url!}',
                    version: QrVersions.auto,
                    size: 200.0,
                    foregroundColor: AppColors.textColor,
                    eyeStyle: QrEyeStyle(
                      eyeShape: QrEyeShape.circle,
                      color: AppColors.textColor,
                    ),
                  ),
                ),
                const Spacer(),
                ShareCopyLinkWidget(
                  url: state.url!,
                ),
              ],
            );
          } else {
            return const Center(
              child: CustomAppErrorWidget(),
            );
          }
        },
      ),
    );
  }
}
