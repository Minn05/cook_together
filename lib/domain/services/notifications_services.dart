import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:recipes/data/env/env.dart';
import 'package:recipes/data/storage/secure_storage.dart';
import 'package:recipes/domain/models/response/response_notifications.dart';



class NotificationsServices {


  Future<List<Notificationsdb>> getNotificationsByUser() async {

    final token = await secureStorage.readToken();

    final resp = await http.get(Uri.parse('${Environment.urlApi}/notification/get-notification-by-user'),
      headers: { 'Accept' : 'application/json', 'xxx-token' : token! }
    );

    return ResponseNotifications.fromJson(jsonDecode(resp.body)).notificationsdb;
  }



}

final notificationServices = NotificationsServices();