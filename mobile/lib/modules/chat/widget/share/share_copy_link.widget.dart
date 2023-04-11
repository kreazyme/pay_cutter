import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pay_cutter/common/styles/color_styles.dart';
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
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      height: 60,
      alignment: Alignment.center,
      child: Row(
        children: [
          Icon(
            Icons.link_rounded,
            color: AppColors.primaryColor,
          ),
          Container(
            width: 1,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            color: Colors.grey,
            height: double.infinity,
          ),
          Text(
            widget.url,
            style: const TextStyle(
              color: Colors.blue,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          IconButton(
            onPressed: () => _copyLink(context),
            icon: Icon(
              Icons.copy_rounded,
              color: !isCopied ? AppColors.primaryColor : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
