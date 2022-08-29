import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:soheel_app/core/app_storage/app_storage.dart';
import 'package:soheel_app/core/dio_manager/dio_manager.dart';
import 'package:soheel_app/core/recording_manager/recording_manager.dart';
import 'package:soheel_app/views/shared/chat/model.dart';

import '../../../constants.dart';

part 'states.dart';

class ChatCubit extends Cubit<ChatStates> {
  ChatCubit({required this.tripID, required this.receiverID}) : super(ChatInit());

  static ChatCubit of(context) => BlocProvider.of(context);

  final String tripID;
  final String receiverID;

  bool isRecording = false;
  ChatModel? chatModel;
  TextEditingController txController = TextEditingController();

  Future<void> getChat([bool loading = true]) async {
    if (loading)
      emit(ChatLoading());
    try {
      final response = await DioHelper.post(
        'messages/peer_messages',
        data: {
          'logged': 'true',
          'trip_id': tripID,
        },
      );
      chatModel = ChatModel.fromJson(response.data);
      chatModel?.chatDetails = chatModel?.chatDetails?.reversed.toList();
    } catch (e) {}
    emit(ChatInit());
  }

  Future<void> sendMessage() async {
    if (txController.text.trim().isEmpty) {
      return;
    }
    try {
      final message = txController.text;
      txController.clear();
      final formData = FormData.fromMap({
        'logged': 'true',
        'trip_id': tripID,
        'from_id': AppStorage.customerID,
        'to_id': receiverID,
        'message_txt': message,
        'message_type': 'text'
      });
      await DioHelper.post(
        'messages/send_message',
        formData: formData
      );
      getChat(false);
    } catch (e) {}
    emit(ChatInit());
  }

  Future<void> sendAttachment({required String type, required String filePath}) async {
    try {
      final formData = FormData.fromMap({
        'logged': 'true',
        'trip_id': tripID,
        'from_id': AppStorage.customerID,
        'to_id': receiverID,
        'message_txt': '',
        'message_type': type,
      });
      formData.files.add(MapEntry('message_file', await MultipartFile.fromFile(filePath)));
      await DioHelper.post(
        'messages/send_message',
        formData: formData,
      );
      getChat(false);
    } catch (e) {}
    emit(ChatInit());
  }

  void startRecording() async {
    closeKeyboard();
    final isGranted = await RecordingManager.startRecording();
    if (isGranted) {
      isRecording = true;
      emit(ChatInit());
    }
  }

  void stopRecording(bool sendFile) async {
    final filePath = await RecordingManager.stopRecording();
    if (sendFile) {
      sendAttachment(type: 'audio', filePath: filePath);
    }
    isRecording = false;
    if (!isClosed)
      emit(ChatInit());
  }

  void pickImage() async {
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file != null) {
      sendAttachment(type: 'image', filePath: file.path);
    }
  }


  @override
  Future<void> close() {
    txController.dispose();
    if (isRecording) {
      stopRecording(false);
    }
    return super.close();
  }

}