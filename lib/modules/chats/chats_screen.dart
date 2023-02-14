// ignore_for_file: prefer_const_constructors, prefer_is_empty

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/state.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/shared/componnen/commponnents.dart';
import '../chat_detailes/chat_detailes_screen.dart';

class ChatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, index) {},
      builder: (context, index) {
        return ConditionalBuilder(
          builder: (context) => ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) =>
                buildChatItem(SocialCubit.get(context).users[index], context),
            separatorBuilder: (context, index) => Divider(),
            itemCount: SocialCubit.get(context).users.length,
          ),
          condition: SocialCubit.get(context).users.length > 0,
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildChatItem(UserModel model, context) => InkWell(
        onTap: () {
          navigateTo(
              context,
              ChatDetailesScreen(
                user: model,
              ));
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage(
                  '${model.image}',
                ),
              ),
              SizedBox(width: 15.0),
              Text(
                '${model.name}',
                style: TextStyle(
                  height: 1.4,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      );
}
