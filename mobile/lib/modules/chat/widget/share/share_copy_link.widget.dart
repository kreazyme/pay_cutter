import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pay_cutter/common/styles/color_styles.dart';
import 'package:pay_cutter/common/styles/text_styles.dart';
import 'package:pay_cutter/common/widgets/toast/toast_ulti.dart';

class ShareCopyLinkWidget extends StatefulWidget {
  const ShareCopyLinkWidget({
    super.key,
    required this.url,
  });

  final String url;

  @override
  State<ShareCopyLinkWidget> createState() => _ShareCopyLinkWidgetState();
}

class _ShareCopyLinkWidgetState extends State<ShareCopyLinkWidget> {
  bool isCopied = false;

  void _copyLink(BuildContext context) {
    if (isCopied) return;
    setState(() {
      isCopied = true;
    });
    Clipboard.setData(ClipboardData(text: widget.url));
    ToastUlti.showSuccess(context, 'Copied link to clipboard');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Link to join group',
                    style: TextStyles.title,
                  ),
                  Text(
                    '#${widget.url}',
                    style: TextStyles.bodyBold.copyWith(
                      color: AppColors.disableColor,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                onPressed: () => _copyLink(context),
                icon: Icon(
                  isCopied ? Icons.copy_all_rounded : Icons.copy_rounded,
                  color: !isCopied ? AppColors.primaryColor : Colors.grey,
                ),
              )
            ],
          ),
          const Divider(
            height: 16,
            color: Colors.transparent,
          ),
          MaterialButton(
            onPressed: () {},
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(16),
              ),
              height: 60,
              width: double.infinity,
              alignment: Alignment.center,
              child: Text(
                'Share this group',
                style: TextStyles.title.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
