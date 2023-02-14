// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:social_app/modules/login/login_screen/login_screen.dart';
import 'package:social_app/network/local_cash/cash_helper.dart';
import 'package:social_app/shared/componnen/commponnents.dart';
import 'package:social_app/style/colors.dart';


class BoardingModel {
  final String image;
  final String body;
  final String title;

  const BoardingModel({
    required this.image,
    required this.body,
    required this.title,
  });
}


class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/images/onboard_1.jpg',
      body: 'On Board 1 Body',
      title: 'On Board 1 Title',
    ),
    BoardingModel(
      image: 'assets/images/onboard_1.jpg',
      body: 'On Board 2 Body',
      title: 'On Board 2 Title',
    ),
    BoardingModel(
      image: 'assets/images/onboard_1.jpg',
      body: 'On Board 3 Body',
      title: 'On Board 3 Title',
    )
  ];
  bool isLast = false;

  var boardController = PageController();
  void submit(context) {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if(value)
      {
        navigateAndFinish(context, SocialLoginScreen());
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: ()
            {
              submit(context);
            },
            child: Row(
              children: [
                Text(
                  'SKIP',
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_rounded,
                  size: 15.0,
                ),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: boardController,
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return BuildBoardingItems(
                    model: boarding[index],
                  );
                },
                itemCount: boarding.length,
              ),
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                    activeDotColor: defaultColor,
                    dotColor: Colors.grey,
                    dotHeight: 10.0,
                    dotWidth: 10.0,
                    expansionFactor: 4.0,
                    spacing: 5.0,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast ) {
                      submit(context);
                    } else {
                      boardController.nextPage(
                        duration: Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: Icon(
                    Icons.arrow_forward_ios,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class BuildBoardingItems extends StatelessWidget {
  final BoardingModel model;

  BuildBoardingItems({required this.model});

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
            image: AssetImage('${model.image}'),
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
        Text(
          '${model.title}',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
        Text(
          '${model.body}',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
