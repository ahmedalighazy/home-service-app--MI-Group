import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:home_service_app/core/widgets/custom_app_bar.dart';

import '../../logic/cubit/chat_cubit.dart';
import '../widgets/chat_app_bar_title.dart';
import '../widgets/chat_input_bar.dart';
import '../widgets/chat_messages_list.dart';

class ChatDetailScreen extends StatelessWidget {
  const ChatDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit()..loadMessages(),
      child: Scaffold(
        // backgroundColor: AppColors.white,
        appBar: CustomAppBar(titleWidget: ChatAppBarTitle()),
        body: const Column(
          children: [
            Expanded(child: ChatMessagesList()),
            ChatInputBar(),
          ],
        ),
      ),
    );
  }
}
