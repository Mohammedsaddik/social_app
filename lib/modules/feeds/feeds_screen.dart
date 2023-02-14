
// ignore_for_file: prefer_const_constructors, prefer_is_empty, unnecessary_string_interpolations

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/state.dart';
import 'package:social_app/models/new_post_model.dart';
import 'package:social_app/style/colors.dart';
import 'package:social_app/style/icon_broken.dart';
class FeedsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<SocialCubit,SocialState>(
      listener: (context,state){},
      builder: (context,state)
      {
        return ConditionalBuilder(
          builder: (context)=>SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 5.0,
                  margin: EdgeInsets.all(8.0),
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      Image(
                        image: NetworkImage(
                            'https://img.freepik.com/free-photo/joyful-afro-woman-raises-arms-tilts-head-dressed-casual-knitted-jumper-laughs-from-happiness-celebrates-victory-isolated-yellow_273609-32594.jpg?w=740&t=st=1675347511~exp=1675348111~hmac=dc6f4d14d0d67d04c9879e8e9abd6b4af8155451eea2f30fc19b77b00072718d'),
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 200.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'communicate with friends',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(
                    height: 8.0,
                  ),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => buildPostItem(SocialCubit.get(context).posts[index],context,index),
                  itemCount: SocialCubit.get(context).posts.length,
                ),
                SizedBox(height: 100.0),
              ],
            ),
          ),
          condition: SocialCubit.get(context).posts.length>0&&SocialCubit.get(context).model !=null,
          fallback: (context)=>Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildPostItem(PostModel model,context,index) => Card(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5.0,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25.0,
                    backgroundImage: NetworkImage(
                        '${model.image}'),
                  ),
                  SizedBox(width: 15.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${model.name}',
                              style: TextStyle(
                                  height: 1.4, fontWeight: FontWeight.bold,),
                            ),
                            SizedBox(width: 5.0),
                            Icon(
                              Icons.check_circle,
                              color: defaultColor,
                              size: 16.0,
                            )
                          ],
                        ),
                        Text(
                          '${model.dateTime}',
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(height: 1.4),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 15.0),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.more_horiz,
                      size: 16.0,
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey,
                ),
              ),
              Text(
                '${model.text}',
                style: Theme.of(context).textTheme.subtitle1,
              ),
//              Padding(
//                padding: const EdgeInsets.only(bottom: 10.0, top: 5.0),
//                child: Container(
//                  width: double.infinity,
//                  child: Wrap(
//                    children: [
//                      Padding(
//                        padding: const EdgeInsetsDirectional.only(end: 8.0),
//                        child: Container(
//                          height: 25.0,
//                          child: MaterialButton(
//                            onPressed: () {},
//                            minWidth: 1.0,
//                            padding: EdgeInsets.zero,
//                            child: Text(
//                              '#Software',
//                              style: Theme.of(context)
//                                  .textTheme
//                                  .caption!
//                                  .copyWith(color: defaultColor),
//                            ),
//                          ),
//                        ),
//                      ),
//                      Padding(
//                        padding: const EdgeInsetsDirectional.only(end: 8.0),
//                        child: Container(
//                          height: 25.0,
//                          child: MaterialButton(
//                            onPressed: () {},
//                            minWidth: 1.0,
//                            padding: EdgeInsets.zero,
//                            child: Text(
//                              '#Flutter',
//                              style: Theme.of(context)
//                                  .textTheme
//                                  .caption!
//                                  .copyWith(color: defaultColor),
//                            ),
//                          ),
//                        ),
//                      ),
//                    ],
//                  ),
//                ),
//              ),
            if(model.postImage !='')
              Padding(
                padding: const EdgeInsetsDirectional.only(
                    top:15.0
                ),
                child: Container(
                  height: 140.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    image: DecorationImage(
                      image: NetworkImage(
                          '${model.postImage}'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
             Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: InkWell(
                          onTap: () {},
                          child: Row(
                            children: [
                              Icon(
                                IconBroken.Heart,
                                size: 18.0,
                                color: Colors.red,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                '${SocialCubit.get(context).likes[index]}',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: InkWell(
                          onTap: ()
                          {
                            SocialCubit.get(context).commentPost(SocialCubit.get(context).postsId[index]);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                IconBroken.Chat,
                                size: 18.0,
                                color: Colors.amber,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                '${SocialCubit.get(context).comments[index]}comment',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
             Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey,
                ),
              ),
             Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 18.0,
                            backgroundImage: NetworkImage(
                                '${SocialCubit.get(context).model!.image}'),
                          ),
                          SizedBox(width: 15.0),
                          Text(
                            'Write a comment...',
                            style:
                            Theme.of(context).textTheme.caption!.copyWith(),
                          ),
                        ],
                      ),
                      onTap: () {},
                    ),
                  ),
                  InkWell(
                    onTap: ()
                    {
                      SocialCubit.get(context).likePost(SocialCubit.get(context).postsId[index]);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          IconBroken.Heart,
                          size: 18.0,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          'Like',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
