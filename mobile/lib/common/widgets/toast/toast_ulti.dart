import 'package:flutter/material.dart';
import 'package:pay_cutter/common/styles/text_styles.dart';

abstract class ToastUlti {
  static void showSuccess(
    BuildContext context,
    String? message,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(
              Icons.check_circle_outline_rounded,
              color: Colors.white,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: Text(
              message ?? 'Update Sucessfully',
              style: TextStyles.body,
            )),
            IconButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                },
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                ))
          ],
        ),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  static void showError(
    BuildContext context,
    String? message,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(
              Icons.error_outline_rounded,
              color: Colors.white,
            ),
            const SizedBox(
              width: 10,
            ),
            Flexible(
                child: Text(
              message ?? 'An error has been occurred',
              style: TextStyles.body,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            )),
            Expanded(
              child: Container(),
            ),
            IconButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                },
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                ))
          ],
        ),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
        padding: const EdgeInsets.all(10),
      ),
    );
  }
}
