import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_cutter/modules/create/bloc/create_expense/create_expense_bloc.dart';

class ExpenseImageWidget extends StatelessWidget {
  const ExpenseImageWidget({
    super.key,
    required this.groupId,
  });

  final int groupId;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[300],
              ),
              child: MaterialButton(
                onPressed: () {
                  context.read<CreateExpenseBloc>().add(
                        CreateExpenseUploadFile(
                          groupId: groupId,
                        ),
                      );
                },
                child: const Icon(Icons.image_rounded),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[300],
            ),
            child: MaterialButton(
              onPressed: () {},
              child: const Icon(Icons.location_on_outlined),
            ),
          ),
        ),
      ],
    );
  }
}
