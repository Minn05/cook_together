import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../data/env/env.dart';
import '../../data/storage/secure_storage.dart';
import '../models/response/response_list_chat.dart';
import '../models/response/response_list_messages.dart';


class ChatServices {


  Future<List<ListChat>> getListChatByUser() async {

    final token = await secureStorage.readToken();

    final resp = await http.get(Uri.parse('${Environment.urlApi}/chat/get-list-chat-by-user'),
      headers: { 'Accept': 'application/json', 'xxx-token': token! }
    );  

    return ResponseListChat.fromJson(jsonDecode(resp.body)).listChat;
  }


  Future<List<ListMessage>> listMessagesByUser(String uid) async {

    final token = await secureStorage.readToken();

    final resp = await http.get(Uri.parse('${Environment.urlApi}/chat/get-all-message-by-user/'+ uid),
      headers: { 'Accept': 'application/json', 'xxx-token' : token! }
    );

    return ResponseListMessages.fromJson(jsonDecode(resp.body)).listMessage;
  }
  Future<List<ListChat>> getListChatByRecipe() async {

    final token = await secureStorage.readToken();

    final resp = await http.get(Uri.parse('${Environment.urlApi}/chat/get-list-chat-by-Recipe'),
      headers: { 'Accept': 'application/json', 'xxx-token': token! }
    );  

    return ResponseListChat.fromJson(jsonDecode(resp.body)).listChat;
  }


  Future<List<ListMessageRecipe>> listMessagesByRecipe(String uid) async {

    final token = await secureStorage.readToken();

    final resp = await http.get(Uri.parse('${Environment.urlApi}/chat/get-all-message-by-Recipe/'+ uid),
      headers: { 'Accept': 'application/json', 'xxx-token' : token! }
    );

    return ResponseListMessagesRecipe.fromJson(jsonDecode(resp.body)).listMessage;
  }







}

final chatServices = ChatServices();
