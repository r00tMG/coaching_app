import 'package:coaching_academy/utils/constants/images.dart';
import 'package:coaching_academy/utils/widgets/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';

import '../notification_service.dart';

// Custom widget for the notification item
/*class NotificationItem extends StatelessWidget {
  final String title;
  final String description;
  final String time;
  final bool isRead;

  const NotificationItem({
    super.key,
    required this.title,
    required this.description,
    required this.time,
    required this.isRead,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Notification Container
        Slidable(
          endActionPane: ActionPane(
              motion: const ScrollMotion(),

              // A pane can dismiss the Slidable.
              dismissible: DismissiblePane(onDismissed: () {}),
              children: [
                CustomSlidableAction(
                    onPressed: (v) {},
                    backgroundColor: Colors.transparent,
                    child: SvgPicture.asset(AppImages.deleteIcon))
              ]),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border:
                  Border.all(color: isRead ? Colors.transparent : Colors.blue),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: title,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            isPoppins: true,
                          ),
                          CustomText(
                            text: time,
                            color: Colors.black,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            isPoppins: true,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      CustomText(
                        text: description,
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        isPoppins: true,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        // Green dot positioned on the top left tip of the container
        if (!isRead)
          Positioned(
            top: 4, // Adjusts to bring the dot to the tip
            left: 0, // Adjusts to bring the dot to the tip
            child: Container(
              width: 15,
              height: 15,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
                color: Colors.green,
                shape: BoxShape.circle,
              ),
            ),
          ),
      ],
    );
  }
}*/
class NotificationItem extends StatelessWidget {
  final int id;
  final String title;
  final String description;
  final String time;
  final bool isRead;
  final VoidCallback onRefresh;

  const NotificationItem({
    super.key,
    required this.id,
    required this.title,
    required this.description,
    required this.time,
    required this.isRead,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Slidable(
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            dismissible: DismissiblePane(onDismissed: () async {
              await NotificationService.deleteNotification(id);
              onRefresh(); // pour rafraîchir après suppression
            }),
            children: [
              SlidableAction(
                onPressed: (_) async {
                  final success = await NotificationService.markAsRead(id);
                  if (success) onRefresh();
                },
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                icon: Icons.mark_email_read_outlined,
                label: 'Lire',
              ),
              SlidableAction(
                onPressed: (_) async {
                  final success = await NotificationService.deleteNotification(id);
                  if (success) onRefresh();
                },
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Supprimer',
              ),
            ],
          ),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isRead ? Colors.transparent : Colors.blue,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: title,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            isPoppins: true,
                          ),
                          CustomText(
                            text: time,
                            color: Colors.black,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            isPoppins: true,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      CustomText(
                        text: description,
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        isPoppins: true,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        if (!isRead)
          Positioned(
            top: 4,
            left: 0,
            child: Container(
              width: 15,
              height: 15,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
                color: Colors.green,
                shape: BoxShape.circle,
              ),
            ),
          ),
      ],
    );
  }
}
