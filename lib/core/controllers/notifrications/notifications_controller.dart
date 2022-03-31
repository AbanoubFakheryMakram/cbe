
import 'package:awesome_notifications/awesome_notifications.dart';
import '../../../utils/constants/app_colors.dart';
import '../../base/service_locator.dart';

class NotificationsController {

  NotificationsController() {
    listenToEvents();
  }

  bool _streamIsOpened = false;

  // the scenario to show progress notifications
  // first check if the notification permissions is enabled using isNotificationsEnabled() method
  // if granted ok, else request the permission using requestNotificationPermissions() method
  // then use showProgressNotification() method to show the progress notification and wait until downloading finished
  // then destroy that notification by id using destroyNotification() method
  // then show normal notification using showNormalNotification() to notify user that downloading is finished
  // and call listenToEvents() to listen if the user clicked on the notification (pass the channel name and the callback)
  // finally destroy all notifications

  var notifications = serviceLocator<AwesomeNotifications>();

  Future<void> initNotifications() async {
    await notifications.initialize(
      'resource://drawable/logo',  // place the logo inside app/src/main/res/drawable
      [
        NotificationChannel(
          channelKey: 'your channel key',
          channelName: 'your channel name',
          defaultColor: AppColors.green,
          importance: NotificationImportance.High,
          channelDescription: 'your channel descriptions',
        ),
      ],
    );
  }

  Future<bool> isNotificationsEnabled() async {
    return notifications.isNotificationAllowed();
  }

  Future<bool> requestNotificationPermissions() async {
    return await notifications.requestPermissionToSendNotifications();
  }

  Future<void> showNormalNotification(String title, String body, {int? id, Map<String, String>? payload}) async {
    await notifications.createNotification(
      content: NotificationContent(
        channelKey: 'your channel key',
        id: id ?? createUniqueId(),
        title: title,
        body: body,
        payload: payload,
        icon: 'resource://drawable/logo',
      ),
    );
  }

  Future<void> showProgressNotification(String title, String body, {int? id}) async {
    await notifications.createNotification(
      content: NotificationContent(
        id: id ?? createUniqueId(),
        channelKey: 'your channel key',
        title: title,
        body: body,
        category: NotificationCategory.Progress,
        notificationLayout: NotificationLayout.ProgressBar,
        locked: true,
      ),
    );
  }

  Future<void> listenToEvents() async {
    if(_streamIsOpened) return;
    _streamIsOpened = true;
    notifications.actionStream.listen((event) {
      if(event.payload == null) return;  // the payload is the notification data
      /// do an action when a notification is tapped ///
    });
  }

  Future<void> removeListener() async {
    notifications.actionSink.close();
    _streamIsOpened = false;
  }

  Future<void> destroyNotification(int id) async {
    await notifications.dismiss(id);
  }

  Future<void> destroyAllNotification() async {
    await notifications.dismissAllNotifications();
  }

  int createUniqueId() {
    return DateTime.now().millisecondsSinceEpoch.remainder(100000);
  }

  void dispose() {
    removeListener();
    notifications.dispose();
  }
}