import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pay_cutter/common/extensions/datetime.extension.dart';
import 'package:pay_cutter/common/extensions/string.extentions.dart';
import 'package:pay_cutter/common/styles/color_styles.dart';
import 'package:pay_cutter/common/styles/text_styles.dart';
import 'package:pay_cutter/common/widgets/app_avatar.widget.dart';
import 'package:pay_cutter/common/widgets/custom_icon.widget.dart';
import 'package:pay_cutter/data/models/expense.model.dart';
import 'package:pay_cutter/modules/chat/chat/chat_bloc.dart';
import 'package:pay_cutter/modules/chat/widget/chat/expense_list_participaints.widget.dart';
import 'package:pay_cutter/modules/chat/widget/chat/view_map_widget.dart';

class ItemChatWidget extends StatefulWidget {
  const ItemChatWidget({
    super.key,
    required this.expense,
  });

  final ExpenseModel expense;

  @override
  State<ItemChatWidget> createState() => _ItemChatWidgetState();
}

class _ItemChatWidgetState extends State<ItemChatWidget> {
  bool _isDetail = false;

  Widget _buildPaidInfo() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Paid by',
                style: TextStyles.detail.copyWith(
                  color: AppColors.textColor,
                ),
              ),
              const Divider(
                height: 4,
                color: Colors.transparent,
              ),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => _buildItemPerson(
                  widget.expense.createdBy.avatarUrl,
                  widget.expense.createdBy.name,
                ),
                separatorBuilder: (context, index) => const Divider(
                  height: 4,
                ),
                itemCount: 1,
              )
            ],
          ),
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Paid for',
                style: TextStyles.detail.copyWith(
                  color: AppColors.textColor,
                ),
              ),
              const Divider(
                height: 4,
                color: Colors.transparent,
              ),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => _buildItemPerson(
                  widget.expense.participants[index].avatarUrl,
                  widget.expense.participants[index].name,
                ),
                separatorBuilder: (context, index) => const Divider(
                  height: 8,
                  color: Colors.transparent,
                ),
                itemCount: widget.expense.participants.length,
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _buildItemPerson(
    String? avatar,
    String name,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        AppAvatar(
          url: avatar,
          height: 24,
          width: 24,
        ),
        const VerticalDivider(
          width: 4,
          color: Colors.transparent,
        ),
        Text(
          name,
          style: TextStyles.body.copyWith(
            color: AppColors.textColor,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isDetail) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12.0),
            topRight: Radius.circular(12.0),
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(12.0),
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.expense.name,
                          style: TextStyles.title.copyWith(
                            color: AppColors.textColor.withOpacity(0.8),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          widget.expense.createdAt.fullDateTime12h,
                          style: TextStyles.body.copyWith(
                            color: AppColors.textColor.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  widget.expense.amount.toString(),
                  style: TextStyles.titleBold.copyWith(
                    color: AppColors.primaryColor,
                  ),
                )
              ],
            ),
            const Divider(
              height: 20,
              color: Colors.transparent,
            ),
            if (_isDetail)
              Container(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    context.read<ChatBloc>().add(
                          ChatDeleteExpense(id: widget.expense.id),
                        );
                  },
                  child: CustomIcon(
                    iconData: Icons.delete_outlined,
                    iconColor: Colors.red.withOpacity(0.8),
                  ),
                ),
              ),
            _buildPaidInfo(),
            const Divider(
              height: 20,
              color: Colors.transparent,
            ),
            if (!widget.expense.imageURL.isNullOrEmpty)
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  image: DecorationImage(
                    image: NetworkImage(widget.expense.imageURL!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            if (widget.expense.location?.address != null)
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 4,
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomIcon(
                          iconData: Icons.location_on_outlined,
                          iconColor: AppColors.primaryColor,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                            child: Text(
                          widget.expense.location!.address!,
                          style: TextStyles.body.copyWith(
                            color: AppColors.textColor,
                          ),
                        )),
                      ],
                    ),
                    const Divider(
                      height: 4,
                      color: Colors.transparent,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ViewMapWidget(
                                    location: LatLng(
                                  widget.expense.location!.lat!,
                                  widget.expense.location!.lng!,
                                )),
                              ));
                        },
                        child: Text('View on map',
                            style: TextStyles.body.copyWith(
                              color: AppColors.primaryColor,
                            )))
                  ],
                ),
              ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _isDetail = false;
                });
              },
              behavior: HitTestBehavior.opaque,
              child: const Icon(
                Icons.arrow_drop_up,
              ),
            )
          ],
        ),
      );
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12.0),
          topRight: Radius.circular(12.0),
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(12.0),
        ),
      ),
      child: Column(children: [
        Row(
          children: [
            AppAvatar(
              url: widget.expense.createdBy.avatarUrl,
            ),
            const SizedBox(width: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.expense.name,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(height: 5.0),
                Text(
                  widget.expense.createdAt.fullDateTime12h,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 12.0,
                  ),
                )
              ],
            ),
            const Expanded(child: SizedBox()),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  widget.expense.amount.toString(),
                  style: TextStyles.titleBold.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
                ExpenseListParticipants(
                  participants: widget.expense.participants,
                ),
              ],
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _isDetail = true;
            });
          },
          behavior: HitTestBehavior.opaque,
          child: const Icon(
            Icons.arrow_drop_down,
          ),
        )
      ]),
    );
  }
}
