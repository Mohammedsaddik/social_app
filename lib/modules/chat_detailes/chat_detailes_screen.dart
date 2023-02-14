// ignore_for_file: prefer_const_constructors, prefer_is_empty, must_be_immutable, use_key_in_widget_constructors, curly_braces_in_flow_control_structures

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/state.dart';
import 'package:social_app/models/meessage_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/style/colors.dart';
import 'package:social_app/style/icon_broken.dart';

class ChatDetailesScreen extends StatelessWidget {
  UserModel user;

  ChatDetailesScreen({
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        var messageController = TextEditingController();
        SocialCubit.get(context).getMessages(
          receiverId: user.uId,
        );
        return BlocConsumer<SocialCubit, SocialState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage('${user.image}'),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Text('${user.name}'),
                  ],
                ),
              ),
              body: ConditionalBuilder(
                condition: SocialCubit.get(context).messages.length >= 0,
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            var message =
                                SocialCubit.get(context).messages[index];
                            if (SocialCubit.get(context).model!.uId ==
                                message.senderId)
                              return buildMyMessage(message);
                            return buildMessage(message);
                          },
                          separatorBuilder: (context, index) => SizedBox(
                            height: 15.0,
                          ),
                          itemCount: SocialCubit.get(context).messages.length,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: messageController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '   Type your message here ...',
                                ),
                              ),
                            ),
                            Container(
                              height: 50.0,
                              color: defaultColor,
                              child: MaterialButton(
                                onPressed: () {
                                  SocialCubit.get(context).sendMessage(
                                    text: messageController.text,
                                    dateTime: DateTime.now().toString(),
                                    receiverId: user!.uId,
                                  );
                                },
                                minWidth: 1.0,
                                child: Icon(
                                  IconBroken.Send,
                                  size: 16.0,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                fallback: (context) =>
                    Center(child: CircularProgressIndicator()),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildMessage(MessageModel messageModel) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadiusDirectional.only(
                bottomEnd: Radius.circular(10.0),
                topEnd: Radius.circular(10.0),
                topStart: Radius.circular(10.0),
              )),
          padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          child: Text('${messageModel.text}'),
        ),
      );

  Widget buildMyMessage(MessageModel messageModel) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          decoration: BoxDecoration(
              color: defaultColor.withOpacity(0.2),
              borderRadius: BorderRadiusDirectional.only(
                bottomStart: Radius.circular(10.0),
                topEnd: Radius.circular(10.0),
                topStart: Radius.circular(10.0),
              )),
          padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          child: Text('${messageModel.text}'),
        ),
      );
}
