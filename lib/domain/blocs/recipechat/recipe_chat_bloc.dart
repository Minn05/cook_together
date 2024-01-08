import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import '../../../data/env/env.dart';
import '../../../data/storage/secure_storage.dart';

part 'recipe_chat_event.dart';
part 'recipe_chat_state.dart';

class ChatRecipeBloc extends Bloc<ChatRecipeEvent, ChatRecipeState> {
  late io.Socket _socket;

  ChatRecipeBloc() : super(const ChatRecipeInitial()) {
    on<OnIsWrittingRecipeEvent>(_isWritting);
    on<OnEmitMessageRecipeEvent>(_emitMessages);
    on<OnListenMessageRecipeEvent>(_listenMessageEvent);
  }

  void initSocketChat() async {
    final token = await secureStorage.readToken();

    _socket = io.io(Environment.baseUrl + 'socket-chat-message', {
      'transports': ['websocket'],
      'autoConnect': true,
      'forceNew': true,
      'extraHeaders': {'xxx-token': token}
    });

    _socket.connect();

    _socket.on('message-recipe', (data) {
      print(data);
      add(OnListenMessageRecipeEvent(
          data['from'], data['to'], data['message']));
    });
  }

  void disconnectSocketMessagePersonal() {
    _socket.off('message-recipe');
  }

  void disconnectSocket() {
    _socket.disconnect();
  }

  Future<void> _isWritting(
      OnIsWrittingRecipeEvent event, Emitter<ChatRecipeState> emit) async {
    emit(ChatSetIsWrittingRecipeState(writting: event.isWritting));
  }

  Future<void> _emitMessages(
      OnEmitMessageRecipeEvent event, Emitter<ChatRecipeState> emit) async {
    _socket.emit('message-recipe',
        {'from': event.userId, 'to': event.recipeId, 'message': event.message});
  }

  Future<void> _listenMessageEvent(
      OnListenMessageRecipeEvent event, Emitter<ChatRecipeState> emit) async {
    emit(ChatListengMessageRecipeState(
        uidFrom: event.userId,
        uidTo: event.recipeId,
        messages: event.messages));
  }
}
