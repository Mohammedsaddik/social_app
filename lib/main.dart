import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/state.dart';
import 'package:social_app/layout/home-layout.dart';
import 'package:social_app/network/local_cash/cash_helper.dart';
import 'package:social_app/network/remote/dio_helper.dart';
import 'package:social_app/shared/componnen/commponnents.dart';
import 'package:social_app/style/themes.dart';
import 'modules/login/login_screen/login_screen.dart';
import 'shared/bloc_observe/bloc_obsevable.dart';
import 'shared/constant/constant.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async
{
  print('on background messaging');
  print(message.data.toString());
  showToast(
    message: 'on background messaging',
    state: ToastState.SUCCESS,
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var token = await FirebaseMessaging.instance.getToken();
  print(token);
  FirebaseMessaging.onMessage.listen((event) {
    print('on message');
    print(event.data.toString());
    showToast(
      message: 'on message',
      state: ToastState.SUCCESS,
    );
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print('on message opend app');
    print(event.data.toString());
    showToast(
      message: 'on message opend app',
      state: ToastState.SUCCESS,
    );
  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getData(key: 'isDark');
  Widget widget;
  uId = CacheHelper.getData(key: 'uId');

  if (uId != null) {
    widget = SocialLayout();
  } else {
    widget = SocialLoginScreen();
  }
  runApp(MyApp(startWidget: widget));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  MyApp({
    required this.startWidget,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => SocialCubit()
            ..getUserData()
            ..getPosts(),
        ),
      ],
      child: BlocConsumer<SocialCubit, SocialState>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheam,
            themeMode: ThemeMode.dark,
            home: startWidget,
          );
        },
      ),
    );
  }
}
