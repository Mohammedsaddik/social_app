
import 'package:social_app/modules/on_boarding/on_boarding_screen.dart';
import 'package:social_app/network/local_cash/cash_helper.dart';
import 'package:social_app/shared/componnen/commponnents.dart';

void signOut(context)
{
  CacheHelper.remouveData(key: 'token').then((value)
  {
    navigateAndFinish(context, OnBoardingScreen());
  });
}

void printFullText(String text) {
  final pattern = new RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String token='';
String? uId='';