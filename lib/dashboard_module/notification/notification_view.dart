import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import 'notification_controller.dart';

class NotificationModel {
  final String title;
  final String content;
  final DateTime time;

  NotificationModel({
    required this.title,
    required this.content,
    required this.time,
  });
}

final _notificationController = Get.put(NotificationController());

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // Simulated list of notifications

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
   await  _notificationController.notificationApi();
    });
  }

  void deleteNotification(int index) {
    _notificationController.state?.notifications?.removeAt(index); // Remove the notification from the list
    // _notificationController.notificationApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: _notificationController.obx((state) {
        return RefreshIndicator(
          onRefresh: () async {
            return;
          },
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: state?.notifications?.length ?? 0,
            itemBuilder: (context, index) {
              final notification = state?.notifications?[index];
              return Slidable(
                key: const ValueKey(0),
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  // dragDismissible: Drag
                  dismissible: DismissiblePane(onDismissed: () {
                    deleteNotification(index);

                    // return;
                  }),
                  children: [
                    SlidableAction(
                      autoClose: false,
                      onPressed: (context) {
                        setState(() {});
                      },
                      backgroundColor: const Color(0xFF21B7CA),
                      foregroundColor: Colors.white,
                      icon: Icons.share,
                      label: 'Share',
                    ),
                    SlidableAction(
                      onPressed: (context) {
                        deleteNotification(index);

                        Get.snackbar(notification?.title ?? "", "Message has been deleted ");
                        setState(() {});
                        // return;
                      },
                      backgroundColor: Color(0xFFFE4A49),
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                  ],
                ),
                child: ListTile(
                  title: Text(notification?.title ?? ""),
                  subtitle: Text(notification?.content ?? ""),
                  trailing: const Text(
                    'ago',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }


}
