import 'package:flutter/material.dart';

class ExpenseImageWidget extends StatelessWidget {
  const ExpenseImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[300],
          ),
          child: MaterialButton(
            onPressed: () {},
            child: const Icon(Icons.image_rounded),
          ),
        )),
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
