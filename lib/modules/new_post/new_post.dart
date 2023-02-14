// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/state.dart';
import 'package:social_app/style/icon_broken.dart';

class NewPostScreen extends StatelessWidget {
  var textController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Create Post'),
            actions: [
              TextButton(
                onPressed: ()
                {
                  var now= DateTime.now();
                  if(SocialCubit.get(context).postimage==null)
                    {
                      SocialCubit.get(context).createPost(dateTime: now.toString(), text: textController.text,);
                    }else{
                    SocialCubit.get(context).uploadPostImage(dateTime: now.toString(), text: textController.text);
                  }
                },
                child: Text('POST'),
              ),
            ],
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(IconBroken.Arrow___Left_2),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is SocialCreatePostLoadingState)
                  LinearProgressIndicator(),
                if(state is SocialCreatePostLoadingState)
                    SizedBox(height: 10.0,),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(
                          'https://img.freepik.com/free-photo/mindful-peaceful-afro-american-woman-meditates-indoor-keeps-hands-mudra-gesture-has-eyes-closed_273609-25449.jpg?w=740&t=st=1675350650~exp=1675351250~hmac=bf3185721652ab5ecadcb02524e26a57ec5b037c153635e83ce20deefa32d30e'),
                    ),
                    SizedBox(width: 15.0),
                    Expanded(
                      child: Text(
                        'Mohammed Mostafa',
                        style:
                            TextStyle(height: 1.4, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                        hintText: 'what is on your mind ... ',
                        border: InputBorder.none),
                  ),
                ),
                SizedBox(height: 20.0,),
                if(SocialCubit.get(context).postimage !=null)
                  Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Container(
                      height: 140.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        image: DecorationImage(
                          image:FileImage(SocialCubit.get(context).postimage!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: ()
                      {
                        SocialCubit.get(context).removePostImage();
                      },
                      icon: CircleAvatar(
                        radius: 20.0,
                        child: Icon(
                          Icons.close,
                          size: 16.0,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0,),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: ()
                        {
                          SocialCubit.get(context).getPostImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                          [
                            Icon(IconBroken.Image),
                            SizedBox(width: 5.0,),
                            Text('add photo')
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: (){},
                        child: Text('#tags'),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
