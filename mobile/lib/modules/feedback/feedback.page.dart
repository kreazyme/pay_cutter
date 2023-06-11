// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pay_cutter/common/styles/text_styles.dart';
import 'package:pay_cutter/common/widgets/custom_button.widget.dart';
import 'package:pay_cutter/common/widgets/custome_appbar.widget.dart';
import 'package:pay_cutter/common/widgets/toast/toast_ulti.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        title: 'Feedback our app',
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'How did we do?',
                style: TextStyles.title,
              ),
              const Divider(
                height: 20,
                color: Colors.transparent,
              ),
              RatingBar.builder(
                initialRating: 3,
                minRating: 1,
                direction: Axis.horizontal,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {},
              ),
              const Divider(
                height: 20,
                color: Colors.transparent,
              ),
              const Text(
                'What went well?',
                style: TextStyles.title,
              ),
              const Divider(
                height: 20,
                color: Colors.transparent,
              ),
              const TextField(
                maxLines: 15,
                decoration: InputDecoration(
                  hintText: 'Write your feedback here',
                  border: OutlineInputBorder(),
                ),
              ),
              const Divider(
                height: 20,
                color: Colors.transparent,
              ),
              CustomButtonWidget(
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  await Future.delayed(const Duration(seconds: 2));
                  ToastUlti.showSuccess(
                      context, 'Your feedback sent successfully');
                  Navigator.pop(context);
                },
                content: 'Submit feedback!',
                isLoading: isLoading,
              )
            ],
          ),
        ),
      ),
    );
  }
}
