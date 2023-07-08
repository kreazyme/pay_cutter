import 'package:flutter/material.dart';
import 'package:pay_cutter/common/helper/number_format/number_formarter.dart';
import 'package:pay_cutter/common/styles/text_styles.dart';

class DebitChartItemWidget extends StatelessWidget {
  const DebitChartItemWidget({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.amount,
  });

  final String firstName;
  final String lastName;
  final int amount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 20,
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                firstName,
                style: TextStyles.bodyBold,
              ),
            ),
          ),
          Text(
            NumberFormatter.formatter(amount),
          ),
          const SizedBox(
            width: 12,
          ),
          const Icon(Icons.arrow_forward_rounded),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: Text(
                lastName,
                style: TextStyles.bodyBold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
